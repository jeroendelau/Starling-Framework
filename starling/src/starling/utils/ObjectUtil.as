package starling.utils
{
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	public class ObjectUtil
	{	
		public static function merge(target:Object, base:Object):Object
		{
			for( var key:String in base ) {
				var ext:* = base[key];
				
				//Check if the key is avialable. If not
				//copy the value
				if(target[key] === undefined){
					if(isNotObjectOrArray(base[key])){
						//simply copy
						target[key] = base[key];	
					}else if(ArrayUtil.isArray(base[key])){
						target[key] = ArrayUtil.copy(base[key]);
					}else{
						//extend
						target[key] = {};
						merge(target[key], base[key]);
					}
					continue;
				}
				
				//Make sure the types match
				var type1:String = getQualifiedClassName(target[key]);
				var type2:String = getQualifiedClassName(base[key]);
				
				//types don't match just return
				if(type1 !== type2)
				{
					continue;
				}				
				else
				{
					//Merge
					ObjectUtil.merge(target[key], ext );
				}
			}
			return target;
		}
		
		
		public static function clone(original:Object):*
		{
			
			return ObjectUtil.merge({}, original);
			
			var newObject:Object = {};
			var myBA:ByteArray = new ByteArray(); 
			myBA.writeObject( original ); 
			myBA.position = 0; 
			return( myBA.readObject() ); 
		}
		
		public static function isObject(val:*):Boolean
		{
			var name:String = getQualifiedClassName(val);
			return (name == 'Object');
		}
		
		public static function isNotObjectOrArray(val:*):Boolean
		{
			var name:String = getQualifiedClassName(val);
			return (name != 'Object' && name != "Array");
		}
		
		public static function isNotObject(val:*):Boolean
		{
			return !isObject(val);
		}
	}
}