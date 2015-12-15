package starling.events
{
	public interface IEventDispatcher
	{
		function addEventListener(type:String, listener:Function):void;
		function removeEventListener(type:String, listener:Function):void;
		function removeEventListeners(type:String=null):void;
		function dispatchEvent(event:Event):void;
		function dispatchEventWith(type:String, bubbles:Boolean=false, data:Object=null):void;
		function dispatchEventWithCallback(type:String, bubbles:Boolean=false, data:Object=null, onComplete:Function = null):Dispatch;
		function dispatchEventClassWith(eventClass:Class, type:String, bubbles:Boolean=false, data:Object=null, onComplete:Function = null):Dispatch;
		function broadcastEventClassWith(listeners:*, eventClass:Class, type:String,  onComplete:Function = null, bubbles:Boolean=false, data:Object=null):Dispatch;
		function hasEventListener(type:String):Boolean;
	}
}