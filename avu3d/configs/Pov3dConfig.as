/**
 * This class load the text file and process it to be used as an flash model object
 * 
 * @author		Maxime Gendreau
 * @company 	UrbanImmersive
 * @link 		http://www.urbanimmersive.com
 * @version 0.01
 * 
 */
package com.avu3d.configs
{
	import com.avu3d.*;
	import com.avu3d.configs.*;
	import com.avu3d.links.*;
	import com.avu3d.logger.*;
	
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class Pov3dConfig extends BaseObject
	{		
		private var rawConfig:Object = new Object(); // Create an object to stock all config (raw)
		private var globalLinks:Array = new Array(); 
		
		public static const DIR_NONE:int 		= 0; // No movement
		public static const DIR_FORWARD:int 	= 1; // O degrees in first quadrant, X axis
		public static const DIR_RIGHT:int 		= 2; // 90 degrees, Y axis
		public static const DIR_BACKWARD:int 	= 3; // 180 degrees, X axis
		public static const DIR_LEFT:int 		= 4; // 270 degrees, Y axis
		public static const DIR_UP:int	 		= 5; // Go up, Z axis
		public static const DIR_DOWN:int 		= 6; // GO down, Z axis
		public static const DIR_SPIN_RIGHT:int	= 7; // Turn right on same pano
		public static const DIR_SPIN_LEFT:int	= 8; // Turn left on same pano
		
		/**
		 * Constructor : load the file and dispatch an event when it's done
		 * @version 0.01
		 * 
		 * @param filePath: filePath
		 */		
		public function Pov3dConfig(filePath:String):void{
			log('New Pov3dConfig(filePath:'+filePath+')', Logger.LEVEL_DEBUG, this);
			var textLoader:URLLoader = new URLLoader();
			textLoader.addEventListener(Event.COMPLETE, function(e:Event){
				try{
					processFile(e.target.data);
					dispatchEvent(new ConfigEvent(ConfigEvent.FILE_LOADED));
				}catch(err:Error){
					log('Error with the processing of the file:' + filePath, Logger.LEVEL_ERROR, err);
				}
			});
			textLoader.load(new URLRequest(filePath));
		}
		
		/**
		 * Process the raw file into a untreated flash object
		 * @version 0.01
		 * 
		 * @param file: raw file to treat
		 */	
		private function processFile(file){
			var splitGlobalLinks:Array = file.split('@@');
			if(splitGlobalLinks.length > 1 && splitGlobalLinks[1].length > 1){
				splitGlobalLinks = splitGlobalLinks.slice(1);
				for(var key in splitGlobalLinks){
					var gl = splitGlobalLinks[key].split(',');
					var gLink:GlobalLink = new GlobalLink(gl[0],gl[1],gl[2],gl[3],gl[4],gl[5],gl[6],gl[7],gl[8],gl[9],gl[11]);
					globalLinks.push(gLink);
				}
			}
			
			rawConfig = file.split("@@"); // split on @@ for removing global links
			rawConfig = rawConfig[0].split(","); // split on comma
			
		}
		
		
		/**
		 * Return a untreated value
		 * @example getValue('0','Home', 1)
		 * @version 0.01
		 * 
		 * @param pos: the position in the array we want
		 * @param defaultVal: return a this default value if nothing was found
		 */			
		public function getValue(pos:int, defaultVal:*=false):*{
			if(!rawConfig)return defaultVal;
			if(!rawConfig[pos])return defaultVal;
			
			return rawConfig[pos];
		}
		
		
		/**
		 * Find the id of the image to go with the direction
		 * @version 0.01
		 * 
		 * @param direction
		 * @return id: id of the image to go
		 */		
		public function getIdByDirection(direction:int):int{
			return getValue(direction-1);
		}
		
		/**
		 * Return a link object with the direction
		 * @version 0.01
		 * 
		 * @param direction
		 * @return LinkInterface: return a Link object
		 */		
		public function getLinkByDirection(direction:int){
			var id = getIdByDirection(direction);
			if(id > 0){ // This is a normal linkPov3d
				return new LinkPov3d(id);
			}else{ // This is a special link
				for each(var globalLink:GlobalLink in globalLinks){
					if(globalLink.comkey == direction){
						var link = globalLink.getLink();
						log('special link:' + link);
						return link;
						break;
					}
				}
			}	
		}
	}
}