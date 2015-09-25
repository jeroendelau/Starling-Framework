// =================================================================================================
//
//	Starling Framework
//	Copyright 2011-2015 Gamua. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package starling.utils
{
    import avmplus.getQualifiedClassName;
    
    import starling.errors.AbstractClassError;

    /** A utility class containing methods related to the Array class.
     *
     *  <p>Many methods of the Array class cause the creation of temporary objects, which is
     *  problematic for any code that repeats very often. The utility methods in this class
     *  can be used to avoid that.</p> */
    public class ArrayUtil
    {
        /** @private */
        public function ArrayUtil() { throw new AbstractClassError(); }

        /** Inserts an element into the array at the specified index.
         *  You can use a negative integer to specify a position relative to the end of the
         *  array (for example, -1 will insert at the very end). If <code>index</code> is
         *  higher than the array length, gaps are filled up with <code>null</code> values. */
        public static function insertAt(array:Array, index:int, object:Object):void
        {
            var i:int;
            var length:uint = array.length;

            if (index < 0) index += length + 1;
            if (index < 0) index = 0;

            for (i = index - 1; i >= length; --i)
                array[i] = null;

            for (i = length; i > index; --i)
                array[i] = array[int(i-1)];

            array[index] = object;
        }

        /** Removes the element at the specified index from the array.
         *  You can use a negative integer to specify a position relative to the end of the
         *  array (for example, -1 will remove the last element). */
        public static function removeAt(array:Array, index:int):Object
        {
            var i:int;
            var length:uint = array.length;

            if (index < 0) index += length;
            if (index < 0) index = 0; else if (index >= length) index = length - 1;

            var object:Object = array[index];

            for (i = index+1; i < length; ++i)
                array[int(i-1)] = array[i];

            array.length = length - 1;
            return object;
        }
		
		/**
		 * Deep copy an array
		 */
		public static function copy(arr:Array):Array 
		{
			// if the other array is a falsy value, return
			var copied:Array=[];
			
			for (var i:int = 0 ; i < arr.length; i++) {
				if(arr[i] is Array){			
					copied.push(ArrayUtil.copy(arr[i]));
				}else{
					copied.push(arr[i]);
				}
			}
			return copied;
		}
		
		public static function isArray(val:*):Boolean
		{
			var name:String = getQualifiedClassName(val);
			return (name == 'Array');
		}
    }
}
