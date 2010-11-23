/**
 * This class is use to create events for the navigation system
 * For example sending a link that has been trigger to do a specific action
 * 
 * @author		Maxime Gendreau
 * @company 	UrbanImmersive
 * @link 		http://www.urbanimmersive.com
 * @version 0.01
 * 
 */

package com.avu3d.navs{
	
	import com.avu3d.links.*;
	
	import flash.events.*;
	
	public class NavEvent extends Event{
		
		public var link:LinkInterface;
		
		public static const LINK_TRIGGERED:String = "linkTriggered";
		
		public function NavEvent(type:String, link:LinkInterface, bubbles:Boolean = false, cancelable:Boolean = false){
			super(type, bubbles, cancelable);
			this.link = link;
		}
		
		/**
		 *  every custom event must override clone()
		 */
		public override function clone():Event{
			return new NavEvent(type, link, bubbles, cancelable);
		}
		
		/**
		 *  every custom event must override toString()
		 */
		public override function toString():String{
			return formatToString("NavEvent", "type", "link", "bubbles", "cancelable", "eventPhase");
		}		
	}
}