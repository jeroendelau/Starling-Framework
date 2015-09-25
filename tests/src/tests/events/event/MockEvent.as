package tests.events.event
{
	import starling.events.Event;
	
	public class MockEvent extends Event
	{
		public function get testVar():String {return _testVar;}
		public function set testVar(value:String):void{ _testVar = value}
		protected var _testVar:String;
		
		public function MockEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
		
		override protected function _parseParams(params:Object = null):void 
		{
			super._parseParams(params);
			if(params.testVar != null) this._testVar = params.testVar;
		}
	}
}