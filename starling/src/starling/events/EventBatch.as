package starling.events
{
	
	import starling.events.Event;
	import starling.events.EventDispatcher;

	/**
	 * A batch of events that will be fired at the same time. They share a collective
	 * dispatch object which allows all listeners to lock the callback until they
	 * are finished executing.
	 */
	
	
	public class EventBatch
	{
		
		protected var _dispatch:Dispatch;	
		
		/**
		 * Prevent creating a new object for every newly added event. We need
		 * to pass the dispatch to all events, so we store it here and pass
		 * all events the same object.
		 */
		protected static var _rootData:Object;
		
		/**
		 * Targets to be dispatch too
		 */
		protected var _targets:Vector.<EventDispatcher>;
		
		
		/**
		 * The events that need to be dispatched
		 */
		protected var _events:Vector.<starling.events.Event>;
		
		public function EventBatch(onComplete:Function)
		{
			_dispatch = Dispatch.fromPool();
			_dispatch.onComplete = onComplete;
			_rootData = {"dispatch": _dispatch};
			_targets = new Vector.<EventDispatcher>();
			_events = new Vector.<Event>();
		}
		
		
		/**
		 * Add an event to the batch 
		 */
		public function addWith(target:EventDispatcher, type:String, data:Object = null):void
		{
			addWithClass(target, type, Event, data);
		}
		
		/**
		 * Add an event of a specific class to the batch
		 */
		public function addWithClass(target:EventDispatcher, type:String, eventClass:Class, data:Object = null):void
		{
			//set the dispatch object
			data = data == null ? _rootData : data;
			data.dispatch = _rootData.dispatch;
			
			var event:Event = Event.fromTypedPool(eventClass, type, false, data);
			
			_targets[_targets.length] = target;
			_events[_events.length] = event;
		}
		
		/**
		 * Dispatch the batch
		 */
		public function dispatch():void
		{
			for (var i:int = 0; i < _targets.length; i++) 
			{
				_targets[i].dispatchEvent(_events[i]);
			}
			
			//If there are no locks callback and remove, 
			//providing it wasn't already removed by an instant
			//a listner
			if(_dispatch !== null && EventDispatcher.dispatches.indexOf(_dispatch)>=0){
				_dispatch.callbackIfUnlocked();
			}	
			
		}
	}
}