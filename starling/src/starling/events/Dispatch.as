package starling.events
{
	
	
	import flash.utils.getQualifiedClassName;
	
	import starling.display.Sprite;
	import starling.utils.ObjectUtil;
	
	
	public class Dispatch
	{
		/**
		 * The dispatch pool for dispatches that can be reused
		 */
		private static var _dispatchPool:Vector.<Dispatch> = new Vector.<Dispatch>();
		
		public function get onComplete():Function {return _onComplete;}
		public function set onComplete(value:Function):void{ _onComplete = value}
		protected var _onComplete:Function;
		
		public function get locks():Vector.<DispatchLock> {return _locks;}
		public function set locks(value:Vector.<DispatchLock>):void{ _locks = value}
		protected var _locks:Vector.<DispatchLock>;
		
		public function get data():Object {return _data;}
		public function set data(value:Object):void{ _data = value}
		protected var _data:Object;
		
		protected static var idCount:int = 1;
		
		public function get id():String { return _generateId()};
		protected var _id:String = "";
		
		/**
		 * Reference to the original event
		 */
		public var type:String;
		
		public var dispatcher:IEventDispatcher;
		
		public function Dispatch()
		{
			_locks = new Vector.<DispatchLock>();
		}
		
		
		//
		// POOLING FUNCTIONS
		//
		internal function reset():void
		{
			_onComplete = null;
			_data = null;
			_id = "";
			
			//remove all locks
			_locks.splice(0, _locks.length);
		}
		
		internal static function poolSize():int
		{
			return _dispatchPool.length;	
		}
		
		internal static function toPool(dispatch:Dispatch):void
		{
			dispatch.reset();
			_dispatchPool[_dispatchPool.length] = dispatch;
		}
		
		internal static function fromPool():Dispatch
		{
			//return new Dispatch();
			var dispatch:Dispatch;
			
			if(_dispatchPool.length){
				dispatch = _dispatchPool.pop();
				EventDispatcher.log("New dispatch from pool: " + dispatch.id);
			}
			else dispatch = new Dispatch();
			
			return dispatch;
		}
		
		//
		// LOCKING FUNCTIONS
 		//
		
		/**
		 * Add a lock to the event which prevents it from firing the callback.
		 * The lock will be removed once the unlock event is fired by the locking
		 * EventDispatcher
		 */
		public function addLock(by:IEventDispatcher, unlockEvent:String, key:String= null):void
		{
			if(!onComplete)
			{
				throw new Error(id + ": Can't add lock to dispatch without onComplete callback. Already fired?");
			}
			key = key===null?"*":key;
			locks.push(DispatchLock.fromPool(by, unlockEvent, key));
			by.addEventListener(unlockEvent, _onUnlock);
			
			EventDispatcher.logger(id+": Added lock, on: "+unlockEvent+", key: "+key+", lock count: "+locks.length.toString(), 1, "EventDispatcher");
			EventDispatcher.logger(id+": "+locks[locks.length-1].key);
			
		}
		
		public function callbackIfUnlocked():void
		{
			if(locks.length == 0)
			{
				//If a callback is registered callback
				var numArgs:int = onComplete.length;
				
				if (numArgs == 0) onComplete();
				else if (numArgs == 1) onComplete(data);
				else if (numArgs == 2) onComplete(data, this);
				
				EventDispatcher.removeDispatch(this);
				Dispatch.toPool(this);
			}
		}
		
		/**
		 * Callback attached to every lock event. Will remove the
		 * lock and fire the callback if no locks are remaining
		 */
		private function _onUnlock(e:Event):void
		{
			//Go through the locks and check if they need to be unlocked
			var by:EventDispatcher = e.target;
			var event:String = e.type;
			var key:String;
			
			if(e.data && e.data.key !== undefined)
			{
				key = e.data.key;
			}else{
				key = "*";
			}
			
				//go through locks and check if it matches
			for (var i:int = 0; i < locks.length; i++) 
			{
				if(locks[i].isKey(by, event, key))
				{
					_removeLock(locks[i]);
					//reduce the counter by one, to prevent
					//skipping a lock
					i--;
				}
			}
			
			//merge the data, aware that this might cause problems
			if(e.data && e.data.forwardData !== undefined && e.data.forwardData)
			{
				if(data == null)
				{
					data = e.data;
				}else{
					data = ObjectUtil.merge(data, e.data);	
				}
			}
			
			callbackIfUnlocked();
		}
		
		/**
		 * Remove a lock from the dispatch
		 */
		private function _removeLock(lock:DispatchLock):void
		{
			_removeListener(lock);
			var i:int = locks.indexOf(lock);
			if(i>=0)locks.splice(i,1);
			DispatchLock.toPool(lock);
			
			EventDispatcher.logger(id+": Removing lock, on: "+lock.releaseOn+", key: "+lock.key+", lock count: "+locks.length.toString() + "\n" + toString(), 1, "EventDispatcher");
			
		}
		
		private function _removeListener(lock:DispatchLock):void
		{
			var count:int = 0;
			for (var i:int = 0; i < locks.length; i++) 
			{
				if(lock.by === locks[i].by && lock.releaseOn === locks[i].releaseOn)
				{
					count++;
				}
			}
			if(count == 1)
			{
				lock.by.removeEventListener(lock.releaseOn, _onUnlock);
			}
		}
		
		private function _generateId():String
		{
			if(_id == "")
			{
				_id = "Dispatch" + idCount;
				idCount++;
			}
			return _id;
		}
		
		//
		// Debugging functions
		//
		
		/**
		 * Return info on the dispatch for debugging
		 */
		internal function toString():String
		{
			var log:String = id + ": Lock count "+locks.length.toString() + "\n";
			//go through locks and check if it matches
			for (var i:int = 0; i < locks.length; i++) 
			{
				var e:Sprite = locks[i].by as Sprite;
				var name:String = e!==null?e.name:getQualifiedClassName(locks[i].by);
				log += "Locked by '"+name+"' unlocks on '" + locks[i].releaseOn + "' with key '"+locks[i].key+"'\n";
					
			}
			return log;
		}
	}
}