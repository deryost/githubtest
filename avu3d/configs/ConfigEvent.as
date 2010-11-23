/**
 * This class is use to create events for the avwConfig file like telling when it is loaded
 * 
 * @author		Maxime Gendreau
 * @company 	UrbanImmersive
 * @link 		http://www.urbanimmersive.com
 * @version 0.01
 * 
 */

package com.avu3d.configs{
	
	import flash.events.*;
	
	public class ConfigEvent extends Event{
		
		public var status:String;
		
		public static const FILE_LOADED:String = "fileIsLoaded";
		
		public function ConfigEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, status = null){
			super(type, bubbles, cancelable);
			this.status = status;
		}
		
		/**
		 *  every custom event must override clone()
		 */
		public override function clone():Event{
			return new ConfigEvent(type, bubbles, cancelable, status);
		}
		
		/**
		 *  every custom event must override toString()
		 */
		public override function toString():String{
			return formatToString("AvwConfigEvent", "type", "bubbles", "cancelable", "eventPhase", "status");
		}		
	}
}