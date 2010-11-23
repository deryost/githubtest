/**
 * This class load the avw file and process it to be used as an flash model object
 * Easy method to access process and clean value to use
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
	import com.avu3d.logger.*;
	
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
		
	public class AvwConfig extends BaseObject
	{		
		private var rawConfig:Object = new Object(); // Create a big object to stock all config (raw)
		private var projectName:String = null; // Code name of the project use for findings files
		
		public var mainPath:String = ''; // Main path to the file system
		
		private var projectStartId:int;
		
		/**
		 * Constructor : load the file and dispatch an event when it's done
		 * @version 0.01
		 * 
		 * @param projectName: project name (codeName)
		 * @param mainPath: path to the file system
		 */		
		public function AvwConfig(projectName:String, mainPath:String):void{
			log('New AvwConfig(projectName:'+projectName+')', Logger.LEVEL_DEBUG, this);
			var textLoader:URLLoader = new URLLoader();
			textLoader.addEventListener(Event.COMPLETE, function(e){
				processFile(e.target.data);
				dispatchEvent(new ConfigEvent(ConfigEvent.FILE_LOADED));
			});
			textLoader.load(new URLRequest(mainPath + projectName + '.avw'));
			this.projectName = projectName;
			this.mainPath = mainPath;
		}
		
		/**
		 * Process the raw file into a untreated flash object
		 * @version 0.01
		 * 
		 * @param file: raw file to treat
		 */	
		private function processFile(file){
			var currentCat = null;
			var lines = file.split("\n"); // split on line break
			for each (var line:String in lines){
				if(line.length == 0){
					continue; // empty line, we skip
				}else if(line.indexOf('[')==0 && line.indexOf(']') > 1){
					var cat = line.substr(1, line.length-3);
					rawConfig[cat] = new Object(); // Create a category object
				}else if(line.indexOf('=') >= 1){
					var lineSplit = line.split('=');
					var param = lineSplit[0];
					var value = line.substr(param.length+1);
					value = value.split("\r")[0];
					if(value == Number(value))value = Number(value); // If it look like a number make it be a number
					rawConfig[cat][param] = value;
				}
			}
		}
		
		
		/**
		 * Return a untreated value
		 * @example getValue('0','Home', 1)
		 * @version 0.01
		 * 
		 * @param cat: the category to find the param ex.: [cat]
		 * @param param: the parameter name of the value ex.: param=value
		 * @param defaultVal: return a this default value if nothing was found
		 */			
		public function getValue(cat:String, param:String, defaultVal:*=false):*{
			if(!rawConfig)return defaultVal;
			if(!rawConfig[cat])return defaultVal;
			if(!rawConfig[cat][param])return defaultVal;
			
			return rawConfig[cat][param];
		}
		
		/**
		 * Getter method
		 * @version 0.01
		 */	
		public function getProjectName():String{
			return projectName;
		}
		
		/**
		 * Method to return the right image path by id and quality
		 * @todo: implement the quality param
		 * @version 0.01
		 * 
		 * @id
		 * @quality 
		 */	
		public function getImagePath(id:int, quality:String):String{
			return mainPath + 'WEB_' + getProjectName() + '/I' + id + '.jpg';
		}
		
		/**
		 * Method to return the right text file path by id
		 * @todo: implement the quality param
		 * @version 0.01
		 * 
		 * @id
		 */	
		public function getPov3dConfigPath(id:int):String{
			return mainPath + 'WEB_' + getProjectName() + '/I' + id + '.txt';
		}
		
		
		/**
		 * Output all the var of the rawConfig for debugging purpose
		 * @version 0.01
		 * 
		 */			
		public function debug():void{
			for (var cat in rawConfig){
				log('[' + cat + ']');
				for (var line in rawConfig[cat]){
					log(line + ' = ' + rawConfig[cat][line] + ' typeof: ' +typeof(rawConfig[cat][line]));
				}
				log('---------------------------------------\n');
			}
		}
		
		/**
		 * Getter: Return the id where the visit start
		 * @version 0.01
		 * 
		 * @return id
		 */	
		public function getProjectStartId():int{
			if(projectStartId) return projectStartId;
			else return getValue('0','Home',1);
		}
		
		/**
		 * Setter: Overwrite the project start visit id
		 * @version 0.01
		 * 
		 * @param id
		 */	
		public function setProjectStartId(id:int):void{
			projectStartId = id;
		}
	}
}