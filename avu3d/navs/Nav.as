/**
 * This class control the navigation in the projet...
 * 
 * @author		Maxime Gendreau
 * @company 	UrbanImmersive
 * @link 		http://www.urbanimmersive.com
 * @version 0.01
 * 
 */

package com.avu3d.navs{
	
	import com.avu3d.*;
	import com.avu3d.configs.*;
	import com.avu3d.links.LinkInterface;
	import com.avu3d.logger.*;
	import com.avu3d.pov3ds.*;
	
	import flash.display.*;
	import flash.events.*;
	
	public class Nav extends BaseObject{
		
		private var avwConfig:AvwConfig = null;
		
		private var currentPov3d:Pov3d = null; // The current Pov3d
		
		/**
		 * Constructor
		 * @version 0.01
		 * 
		 * @param avwConfig
		 */		
		public function Nav(avwConfig:AvwConfig){
			log('New Nav(avwConfig:'+avwConfig+')', Logger.LEVEL_DEBUG, this);	
			addEventListener(Event.ADDED_TO_STAGE, function(e){
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyBoardEvent);
			});
		}
			
		/**
		 * Event to do when a keyPress event has been catch
		 * If we find a corresponding link, we dispatch an event and send the link with it
		 * @version 0.01
		 *  
		 * @param event: a keyboard event
		 */		
		private function onKeyBoardEvent(event:KeyboardEvent):void{
			if(!currentPov3d){
				log('You need to set the current pov3d object (setCurrentPov3d()) if you want the keyBoardEvents to work', Logger.LEVEL_WARNING, currentPov3d);
				return;
			}
			
			var dir = null;
			//log('event.keyCode:' + event.keyCode);
			switch(event.keyCode){
				case 38: case 104: dir = Pov3dConfig.DIR_FORWARD; 	break; // Forward
				case 37: case 100: dir = Pov3dConfig.DIR_SPIN_LEFT; break; // Spin Left
				case 39: case 102: dir = Pov3dConfig.DIR_SPIN_RIGHT;break; // Spin Right
				case 40: case 101: dir = Pov3dConfig.DIR_BACKWARD;	break; // Backward
				
				case 103: case 65: dir = Pov3dConfig.DIR_LEFT; 	break; // Left
				case 105: case 83: dir = Pov3dConfig.DIR_RIGHT;	break; // Right
				
				case 97: case 90: dir = Pov3dConfig.DIR_DOWN; 	break; // Down
				case 98: case 87: dir = Pov3dConfig.DIR_UP; 	break; // Up
			}
			if(dir !== null && currentPov3d !== null){
				var pov3dConfig = currentPov3d.getConfig()
				var link:LinkInterface = pov3dConfig.getLinkByDirection(dir);
				dispatchEvent(new NavEvent(NavEvent.LINK_TRIGGERED, link));
			}
		}
		
		
		/**
		 * Set the current Pov3d object to be able to know the available moves/links
		 * This need to be set for this class to work properly
		 * @version 0.01
		 * 
		 * @param pov3d: a Pov3d object
		 */		
		public function setCurrentPov3d(pov3d:Pov3d):void{
			this.currentPov3d = pov3d;
		}
	}
}