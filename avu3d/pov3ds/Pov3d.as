/**
 * This class load the current precalculated image of a Point of View in a 3D space
 * It also load the file to know the possible next 3D moves.
 * 
 * @author		Maxime Gendreau
 * @company 	UrbanImmersive
 * @link 		http://www.urbanimmersive.com
 * @version 0.01
 * 
 */
package com.avu3d.pov3ds{
	
	import com.avu3d.*;
	import com.avu3d.configs.*;
	import com.avu3d.logger.*;
	import com.avu3d.projects.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	
	public class Pov3d extends BaseObject{
		
		private var id:int;
		private var avwConfig:AvwConfig 	= null;
		private var pov3dConfig:Pov3dConfig = null;
		
		private var pov3dConfigLoaded:Boolean 	= false;
		private var imageLoaded:Boolean			= false;
		
		private var image:Loader = new Loader();
		
		/**
		 * Constructor
		 * @version 0.01
		 * 
		 * @param avwConfig: project config file
		 * @param id: the precalculated id related to a Point a View in a 3D space
		 */			
		public function Pov3d(avwConfig:AvwConfig, id:Number){
			log('New Pov3d(avwConfig:' + avwConfig + ' id:'+id+')', Logger.LEVEL_DEBUG, this);
			this.avwConfig = avwConfig;
			this.id = id;
			
			// init & load main image
			image.load(new URLRequest(avwConfig.getImagePath(id, '??TODO??')));
			image.contentLoaderInfo.addEventListener(Event.COMPLETE,function(e){
				imageLoaded = true;
				tryToInit();
			});
			
			// init & load pov3Config
			pov3dConfig = new Pov3dConfig(avwConfig.getPov3dConfigPath(id));
			pov3dConfig.addEventListener(ConfigEvent.FILE_LOADED, function(e){
				pov3dConfigLoaded = true;
				tryToInit();
			});
		}
		
		/**
		 * If everything that should be load is load then we can call the init method 
		 * @version 0.01
		 */		
		private function tryToInit():void{
			//log('Pov3d.checkInit()', Logger.LEVEL_DEBUG, this);
			if(imageLoaded && pov3dConfigLoaded)init();
		}
		
		
		private function init():void{
			addChild(image);
		}
		
		/**
		 * Getter
		 * @return id
		 */		
		public function getId():int{
			return id;
		}
		
		/**
		 * Getter
		 * @return pov3dConfig: a pov3dConfig object
		 */			
		public function getConfig():Pov3dConfig{
			return pov3dConfig;
		}	
		
	}
}