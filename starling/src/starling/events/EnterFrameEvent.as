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
	import flash.utils.getTimer;
	
	import starling.core.Starling;
	import starling.core.starling_internal;
	
	use namespace starling_internal;

    /** An EnterFrameEvent is triggered once per frame and is dispatched to all objects in the
     *  display tree.
     *
     *  It contains information about the time that has passed since the last frame. That way, you 
     *  can easily make animations that are independent of the frame rate, taking the passed time
     *  into account.
     */ 
    public class EnterFrameEvent extends Event
    {
        /** Event type for a display object that is entering a new frame. */
        public static const ENTER_FRAME:String = "enterFrame";
        
        /** Creates an enter frame event with the passed time. */
        public function EnterFrameEvent(type:String, passedTime:Number, bubbles:Boolean=false)
        {
            super(type, bubbles, passedTime);
        }
        
        /** The time that has passed since the last frame (in seconds). */
        public function get passedTime():Number { return data as Number; }
		
		public function get timeRemaining():Number { return frameTime - timePassed; };
		
		public function get timePassed():Number { return getTimer() - _startTime; }
		
		protected var _startTime:Number;
		
		public var frameTime:Number = 0;
		
		override starling_internal function reset(type:String, bubbles:Boolean=false, data:Object=null):Event
		{
			_startTime = getTimer();
			if(frameTime == 0)
			{
				frameTime = 1/Starling.current.nativeStage.frameRate;
			}
			
		 	return super.reset(type, bubbles, data);
		}
    }
}