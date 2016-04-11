package starling.events
{
	import starling.core.starling_internal;

	use namespace starling_internal;
	
	public interface IEventDispatcher
	{
		function get eventParent():EventDispatcher
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