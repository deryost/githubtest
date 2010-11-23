/**
 * This class is the default class for all the objects in the project
 * Useful for adding functionnalities to all objects of the project in one place
 * 
 * @author		Maxime Gendreau
 * @company 	UrbanImmersive
 * @link 		http://www.urbanimmersive.com
 * @version 0.01
 * 
 */
package com.avu3d{
	
	import com.avu3d.logger.*;
	
	import flash.display.Sprite;

	public class BaseObject extends Sprite{
		
		public function BaseObject(){
		
		}
		
		/**
		 * Shortcut for using the logger
		 * @version 0.01
		 * 
		 * @param msg
		 * @param logLevel
		 * @param object
		 * 
		 */		
		public function log(msg:*, logLevel:int = 0, object=null):void{	
			Logger.$().log(msg, logLevel, object);
		}		
		
		/**
		 * Routine to destroy the current object and sub objects
		 * @version 0.01
		 * 
		 * @return if the operation is successful or not
		 * 
		 */		
		public function destroy():Boolean{
			log("You must implement your own destroy method", Logger.LEVEL_ERROR, this);
			return false;
		}
	}
}