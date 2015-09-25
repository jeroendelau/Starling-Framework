package starling.events
{
	
	public class DispatchLock
	{
		/**
		 * The key pool that to enable the reuse of dispatch locks
		 */
		private static var _lockPool:Vector.<DispatchLock> = new Vector.<DispatchLock>();
		
		public function get by():EventDispatcher {return _by;}
		public function set by(value:EventDispatcher):void{ _by = value}
		protected var _by:EventDispatcher;
		
		public function get releaseOn():String {return _releaseOn;}
		public function set releaseOn(value:String):void{ _releaseOn = value}
		protected var _releaseOn:String;
		
		/**
		 * Optional key that needs to be provided specific to this
		 * combination of dispatcher and release event. This enables
		 * lockers to fire multiple types of release events
		 * 
		 * Default value is "*" which means no key required
		 */
		public function get key():String {return _key;}
		public function set key(value:String):void{ _key = value}
		protected var _key:String;
		
		public function DispatchLock(by:EventDispatcher, releaseOn:String, key:String)
		{
			setup(by, releaseOn, key);
		}
		
		public function isKey(trigger:EventDispatcher, event:String, key:String = "*"):Boolean
		{
			key = key===null?"*":key;
			return (_by === trigger && event === _releaseOn && (_key === key));
		}
		
		//
		// POOLING FUNCTIONS
		//
		internal function reset():void
		{
			_by = null;
			_releaseOn = "";
			_key = "*";
		}
		
		internal static function poolSize():int
		{
			return _lockPool.length;	
		}
		
		internal function setup(by:EventDispatcher, releaseOn:String, key:String = "*"):DispatchLock
		{
			_by = by;
			_releaseOn = releaseOn;
			_key = key===null?"*":key;
			return this;
		}
		
		internal static function toPool(lock:DispatchLock):void
		{
			lock.reset();
			_lockPool[_lockPool.length] = lock;
		}
		
		internal static function fromPool(by:EventDispatcher, releaseOn:String, key:String = "*"):DispatchLock
		{
			if(_lockPool.length) return _lockPool.pop().setup(by, releaseOn, key);
			else return new DispatchLock(by, releaseOn, key);
		}
	}
}