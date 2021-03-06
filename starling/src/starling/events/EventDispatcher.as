// =================================================================================================
//
//	Starling Framework
//	Copyright 2011-2014 Gamua. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package starling.events
{
    import flash.utils.Dictionary;
    import flash.utils.getQualifiedClassName;
    
    import starling.core.starling_internal;
    
    use namespace starling_internal;
    
    /** The EventDispatcher class is the base class for all classes that dispatch events. 
     *  This is the Starling version of the Flash class with the same name. 
     *  
     *  <p>The event mechanism is a key feature of Starling's architecture. Objects can communicate 
     *  with each other through events. Compared the the Flash event system, Starling's event system
     *  was simplified. The main difference is that Starling events have no "Capture" phase.
     *  They are simply dispatched at the target and may optionally bubble up. They cannot move 
     *  in the opposite direction.</p>  
     *  
     *  <p>As in the conventional Flash classes, display objects inherit from EventDispatcher 
     *  and can thus dispatch events. Beware, though, that the Starling event classes are 
     *  <em>not compatible with Flash events:</em> Starling display objects dispatch 
     *  Starling events, which will bubble along Starling display objects - but they cannot 
     *  dispatch Flash events or bubble along Flash display objects.</p>
     *  
     *  @see Event
     *  @see starling.display.DisplayObject DisplayObject
     */
    public class EventDispatcher implements IEventDispatcher
    {
        private var mEventListeners:Dictionary;
        
        /** Helper object. */
        private static var sBubbleChains:Array = [];
        
		//dispatch aggregator
		public static function get dispatches():Vector.<Dispatch>{return _dispatches;}
		protected static var _dispatches:Vector.<Dispatch> = new Vector.<Dispatch>();
		
		public static var logger:Function;
		public static var filter:Array = [];
		
		public function get eventParent():IEventDispatcher {return _eventParent;}
		public function set eventParent(value:IEventDispatcher):void{ _eventParent = value}
		protected var _eventParent:IEventDispatcher;
		
        /** Creates an EventDispatcher. */
        public function EventDispatcher()
        {  }
        
        /** Registers an event listener at a certain object. */
        public function addEventListener(type:String, listener:Function):void
        {
            if (mEventListeners == null)
                mEventListeners = new Dictionary();
            
            var listeners:Vector.<Function> = mEventListeners[type] as Vector.<Function>;
            if (listeners == null)
                mEventListeners[type] = new <Function>[listener];
            else if (listeners.indexOf(listener) == -1) // check for duplicates
                listeners[listeners.length] = listener; // avoid 'push'
        }
        
        /** Removes an event listener from the object. */
        public function removeEventListener(type:String, listener:Function):void
        {
            if (mEventListeners)
            {
                var listeners:Vector.<Function> = mEventListeners[type] as Vector.<Function>;
                var numListeners:int = listeners ? listeners.length : 0;

                if (numListeners > 0)
                {
                    // we must not modify the original vector, but work on a copy.
                    // (see comment in 'invokeEvent')

                    var index:int = listeners.indexOf(listener);

                    if (index != -1)
                    {
                        var restListeners:Vector.<Function> = listeners.slice(0, index);

                        for (var i:int=index+1; i<numListeners; ++i)
                            restListeners[i-1] = listeners[i];

                        mEventListeners[type] = restListeners;
                    }
                }
            }
        }
        
        /** Removes all event listeners with a certain type, or all of them if type is null. 
         *  Be careful when removing all event listeners: you never know who else was listening. */
        public function removeEventListeners(type:String=null):void
        {
            if (type && mEventListeners)
                delete mEventListeners[type];
            else
                mEventListeners = null;
        }
        
        /** Dispatches an event to all objects that have registered listeners for its type. 
         *  If an event with enabled 'bubble' property is dispatched to a display object, it will 
         *  travel up along the line of parents, until it either hits the root object or someone
         *  stops its propagation manually. */
        public function dispatchEvent(event:Event):void
        {
			
            var bubbles:Boolean = event.bubbles;
            
            if (!bubbles && (mEventListeners == null || !(event.type in mEventListeners)))
                return; // no need to do anything
            
			
            // we save the current target and restore it later;
            // this allows users to re-dispatch events without creating a clone.
            
            var previousTarget:EventDispatcher = event.target;
            event.setTarget(this);
            
            if (bubbles) bubbleEvent(event);
            else         invokeEvent(event);
            
            if (previousTarget) event.setTarget(previousTarget);
        }
        
        /** @private
         *  Invokes an event on the current object. This method does not do any bubbling, nor
         *  does it back-up and restore the previous target on the event. The 'dispatchEvent' 
         *  method uses this method internally. */
        internal function invokeEvent(event:Event):Boolean
        {
            var listeners:Vector.<Function> = mEventListeners ?
                mEventListeners[event.type] as Vector.<Function> : null;
            var numListeners:int = listeners == null ? 0 : listeners.length;
            
			//Log before we fire
			if(mEventListeners)
			{
				logDispatch(event, mEventListeners);
			}
			
            if (numListeners)
            {
                event.setCurrentTarget(this);
                
                // we can enumerate directly over the vector, because:
                // when somebody modifies the list while we're looping, "addEventListener" is not
                // problematic, and "removeEventListener" will create a new Vector, anyway.
                
                for (var i:int=0; i<numListeners; ++i)
                {
                    var listener:Function = listeners[i] as Function;
                    var numArgs:int = listener.length;
                    
                    if (numArgs == 0) listener();
                    else if (numArgs == 1) listener(event);
                    else listener(event, event.data);
                    
                    if (event.stopsImmediatePropagation)
                        return true;
                }
                
                return event.stopsPropagation;
            }
            else
            {
                return false;
            }
        }
        
        /** @private */
        internal function bubbleEvent(event:Event):void
        {
            // we determine the bubble chain before starting to invoke the listeners.
            // that way, changes done by the listeners won't affect the bubble chain.
            
            var chain:Vector.<IEventDispatcher>;
            var element:IEventDispatcher = this as IEventDispatcher;
            var length:int = 1;
            var dispatcher:EventDispatcher;
			
            if (sBubbleChains.length > 0) { chain = sBubbleChains.pop(); chain[0] = element; }
            else chain = new <IEventDispatcher>[element];
            
            while ((element = element.eventParent) != null)
                chain[int(length++)] = element;

            for (var i:int=0; i<length; ++i)
            {
				dispatcher = chain[i] as EventDispatcher;
                var stopPropagation:Boolean = dispatcher.invokeEvent(event);
                if (stopPropagation) break;
            }
            
            chain.length = 0;
            sBubbleChains[sBubbleChains.length] = chain; // avoid 'push'
        }
        
        /** Dispatches an event with the given parameters to all objects that have registered 
         *  listeners for the given type. The method uses an internal pool of event objects to 
         *  avoid allocations. */
        public function dispatchEventWith(type:String, bubbles:Boolean=false, data:Object=null):void
        {
           dispatchEventClassWith(Event, type, bubbles, data);
        }
		
		public function dispatchEventWithCallback(type:String, bubbles:Boolean=false, data:Object=null, onComplete:Function = null):Dispatch
		{
			return dispatchEventClassWith(Event, type, bubbles, data, onComplete);
		}
		
		/**
		 * Dispatch an event of a certain class type. This will get the event from the event pool and
		 * populate it with the provide data.
		 */
		public function dispatchEventClassWith(eventClass:Class, type:String, bubbles:Boolean=false, data:Object=null, onComplete:Function = null):Dispatch
		{
			//common error, so check
			if (bubbles || hasEventListener(type)) 
			{
				var event:Event = _prepareEvent(eventClass, type, onComplete, bubbles, data);
				dispatchEvent(event);
				return _cleanupEvent(event);
			}
			
			return null;
		}
		
		/**
		 * If a large list of listeners have not subscribed to the event, broadcast the event to them instead.
		 * Provide a list of of event listeners, and the event will be called on every one.
		 */
		public function broadcastEventClassWith(listeners:*, eventClass:Class, type:String,  onComplete:Function = null, bubbles:Boolean=false, data:Object=null):Dispatch
		{
			var event:Event = _prepareEvent(eventClass, type, onComplete, bubbles, data);
			
			//dispatch the event
			for (var i:int = 0; i < listeners.length; i++) 
			{
				listeners[i].dispatchEvent(event);
			}
			
			return _cleanupEvent(event);
		}
		
		protected function _prepareEvent(eventClass:Class, type:String,  onComplete:Function = null, bubbles:Boolean=false, data:Object=null):Event
		{
			var event:Event = Event.fromTypedPool(eventClass, type, bubbles, data);
			
			if(onComplete !== null){
				event.dispatch = Dispatch.fromPool();
				event.dispatch.onComplete = onComplete;
				event.dispatch.data = data;
				event.dispatch.type = type;
				event.dispatch.dispatcher = this;
				addDispatch(event.dispatch);
			}
			
			return event;
		}
		
		protected function _cleanupEvent(event:Event):Dispatch
		{
			var dispatch:Dispatch = null;
			
			//If there are no locks callback and remove, 
			//providing it wasn't already removed by an instant
			//a listner
			if(event.dispatch !== null && dispatches.indexOf(event.dispatch)>=0){
				dispatch = event.dispatch;
				event.dispatch.callbackIfUnlocked();
			}	
			
			
			//Store the event
			Event.toTypedPool(event);
			
			//return the dispatch
			return dispatch;
		}
		
        
        /** Returns if there are listeners registered for a certain event type. */
        public function hasEventListener(type:String):Boolean
        {
            var listeners:Vector.<Function> = mEventListeners ? mEventListeners[type] : null;
            return listeners ? listeners.length != 0 : false;
        }
		
		/**
		 * Pushes dispatches into the the dispatch array
		 */
		internal static function addDispatch(dispatch:Dispatch):void
		{
			log(dispatch.id+ ": added");
			_dispatches.push(dispatch);
		}
		
		/**
		 * Removes a dispatch from the dipatch array
		 */
		internal static function removeDispatch(dispatch:Dispatch):void
		{
			var i:int = _dispatches.indexOf(dispatch);
			if(i >= 0)
			{
				_dispatches.splice(i, 1);
				log(dispatch.id+ ": removed");
			}else{
				log("Removing '" + dispatch.id + "' failed, dispatch was not found", 3);
			}
		}
		
		public static function getPoolSizes():String
		{
			var sizes:String = "";
			sizes += "E"+Event.poolSize().toString();
			sizes += ",D"+Dispatch.poolSize().toString();
			sizes += ",L"+DispatchLock.poolSize().toString();
			
			return sizes;	
		}
		
		public static function logDispatch(event:Event, listeners:*):void
		{
			if(filter.indexOf(event.type)>=0) return;
			
			if(!event.dispatch && listeners is Dictionary)
			{
				log("Dispatching: "+ event.type, 1);
				return;
			}
			
			var logMsg:String = "";
			logMsg += "Dispatching\n";
			logMsg += "-------------\n";
			logMsg += "Type:   '" + event.type + "'\n";
			
			if(event.dispatch)
			{
				logMsg +=  "Dpatch: " + event.dispatch.id + "\n";
			}
			var name:String;
			
			//dispatch the event
			for (var i:int = 0; i < listeners.length; i++) 
			{
				name = getQualifiedClassName(listeners[i]);
				logMsg += "On:     " + name.split("::")[1] + "\n";
			}
			logMsg += "-------------\n"
			log(logMsg, 1);
		}
		
		/**
		 * Logs the current outstanding dispatches
		 */
		public static function logDispatchInfo():void
		{
			var message:String = "";
			
			message  = "\n\nASYNC STATUS";
			message += "\n--------------";
			message += "\nDispatch Count: " + dispatches.length;
			
			
			message += "\n\nLocked Dispatches : " + (dispatches.length);
			message += "\n--------------";
			
			for (var i2:int = 0; i2 < dispatches.length; i2++) 
			{
				message += "\nBroadcast: " + i2;
				message += "\n"+dispatches[i2].toString();
			}
			
			log(message, 1);
		}
		
		internal static function log(message:String, level:int = 1):void
		{
			if(logger)
			{
				logger(message, level, "EventDispatcher");
			}
		}

    }
}