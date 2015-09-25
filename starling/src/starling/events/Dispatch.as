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
			var dispatch:Dispatch;
			
			if(_dispatchPool.length){
				dispatch = _dispatchPool.pop();
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
		public function addLock(by:EventDispatcher, unlockEvent:String, key:String= null):void
		{
			key = key===null?"*":key;
			locks.push(DispatchLock.fromPool(by, unlockEvent, key));
			by.addEventListener(unlockEvent, _onUnlock);
		}
		
		public function callbackIfUnlocked():void
		{
			if(locks.length == 0)
			{
				//If a callback is registered callback
				if(onComplete !== null)
				{
					var numArgs:int = onComplete.length;
				
					if (numArgs == 0) onComplete();
					else if (numArgs == 1) onComplete(data);
				}
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
			if(data == null)
			{
				data = e.data;
			}else{
				data = ObjectUtil.merge(data, e.data);	
			}
			callbackIfUnlocked();
		}
		
		/**
		 * Remove a lock from the dispatch
		 */
		private function _removeLock(lock:DispatchLock):void
		{
			lock.by.removeEventListener(lock.releaseOn, _onUnlock);
			var i:int = locks.indexOf(lock);
			if(i>=0)locks.splice(i,1);
			DispatchLock.toPool(lock);
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