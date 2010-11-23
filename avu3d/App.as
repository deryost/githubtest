/**
 * This class control the whole application, it first load a project
 * configuration file than the project itself.
 * It also control the switch between projects
 * 
 * @author		Maxime Gendreau
 * @company 	UrbanImmersive
 * @link 		http://www.urbanimmersive.com
 * @version 	0.01 (unstable)
 * 
 */
package com.avu3d
{
	import com.avu3d.logger.*;
	import com.avu3d.configs.*;
	import com.avu3d.projects.*;
	
	import flash.system.*;
	import flash.display.*;
	import flash.events.*;
	
	public class App extends BaseObject{
				
		private var avwConfig:AvwConfig = null;
		private var currentProject:Project = null; // the current project
		
		/**
		 * Constructor
		 * @version 0.01
		 */
		public function App(){
			Logger.$().clear();
			Logger.$().toggleMonsterDebugger(true);
			log('New App()', Logger.LEVEL_DEBUG, this);
			initSecurity();	
			avwConfig = new AvwConfig("GERL10CA7290", "http://www.avu3d.com/avu/uid98/");
			//avwConfig.setProjectStartId(490);
			avwConfig.addEventListener(ConfigEvent.FILE_LOADED, function(e){initConfigLoad()});
		}
		
		/**
		 * Init security policy to be able to communicate with the avu3d website
		 * @version 0.01
		 */
		private function initSecurity():void{
			Security.allowDomain("http://www.avu3d.com");
			Security.allowInsecureDomain("http://www.avu3d.com");
			Security.loadPolicyFile("http://www.avu3d.com/crossdomain.xml");
		}		
		
		/**
		 * This method need to be call when the avwConfig file is loaded and processed
		 * @version 0.01
		 */
		private function initConfigLoad():void{
			currentProject = new Project(avwConfig);
			addChild(currentProject);
			//avwConfig.debug();
		}
		
	}
}