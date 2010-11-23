/**
 * This class control the whole project, it is load by the app class
 * It control the creation/interaction between the most 
 * important objects of the project and bind them together
 * 
 * @author		Maxime Gendreau
 * @company 	UrbanImmersive
 * @link 		http://www.urbanimmersive.com
 * @version 0.01
 * 
 */
package com.avu3d.projects{
	
	import com.avu3d.*;
	import com.avu3d.configs.*;
	import com.avu3d.links.*;
	import com.avu3d.logger.*;
	import com.avu3d.navs.*;
	import com.avu3d.pov3ds.*;
		
	public class Project extends BaseObject{
		
		private var avwConfig:AvwConfig = null;
		private var nav:Nav = null;
		
		private var currentPov3d:Pov3d = null; // The current Pov3d
		private var lastPov3d:Pov3d = null; // The last Pov3d
		
		/**
		 * Constructor
		 * @version 0.01
		 * 
		 * @param avwConfig
		 */		
		public function Project(avwConfig:AvwConfig){
			log('New Project(avwConfig:'+avwConfig+')', Logger.LEVEL_DEBUG, this);
			this.avwConfig = avwConfig;
			nav = new Nav(avwConfig);
			addChild(nav);
			
			createPov3d(avwConfig.getProjectStartId());
			
			nav.addEventListener(NavEvent.LINK_TRIGGERED, function(e:NavEvent){
				triggerLink(e.link);
			});
		}
		
		/**
		 * Depending on the type of link, trigger the right action associate to it 
		 * @version 0.01
		 * 
		 * @param link
		 */		
		public function triggerLink(link:LinkInterface):void{
			if(link is LinkPov3d){ 
				changePov3d(LinkPov3d(link).getId());
			}
		}
		
		/**
		 * Create a Pov3d object and add it to the stage 
		 * @version 0.01
		 * 
		 * @param id
		 */		
		private function createPov3d(id:int):void{
			currentPov3d = new Pov3d(avwConfig, id);
			addChild(currentPov3d);
			nav.setCurrentPov3d(currentPov3d);
		}

		/**
		 * Logic to do when we need to pass from one Pov3d to an other Pov3d: fade-in, fade-out, destroy old object...
		 * @version 0.01
		 * 
		 * @param id: id of the new Pov3d object to load
		 */	
		private function changePov3d(id:int):void{
			if(id !== currentPov3d.getId()){ // if the id does'nt change we do not do anything
				if(lastPov3d){
					//lastPov3d.destroy();
					removeChild(lastPov3d);
				}
				lastPov3d = currentPov3d;
				createPov3d(id);
			}
		}
		
	}
}