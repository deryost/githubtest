/**
 * This class log errors in multiple ways:
 * For now, it use the trace function and the MonsterDebugger library (in production only)
 * 
 * @author		Maxime Gendreau
 * @company 	UrbanImmersive
 * @link 		http://www.urbanimmersive.com
 * @example 	Logger.$().log('debugging test', Logger.LEVEL_DEBUG, this);
 * @version 0.01
 * 
 */

package com.avu3d.logger
{
	import nl.demonsters.debugger.MonsterDebugger;
	
	public class Logger
	{
		private static var instance:Logger; // The singleton only instance
		private static var allowInstantiation:Boolean;
		
		private var isMonsterDebuggerEnabled:Boolean = false;
		
		public static const LEVEL_DEBUG:int 	= 0;
		public static const LEVEL_INFO:int 		= 1;
		public static const LEVEL_WARNING:int 	= 2;
		public static const LEVEL_ERROR:int 	= 3;
		public static const LEVEL_CRITICAL:int	= 4;
		
		/**
		 * Singleton Constructor use internally only
		 * @version 0.01
		 */
		public function Logger() {
			if (!allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use Logger.getInstance() or Logger.$() instead of new.");
			}
		}
		
		/**
		 * Return the Singleton instance
		 * @version 0.01
		 * 
		 * @return 	Logger
		 */			
		public static function getInstance():Logger {
			if (instance == null) {
				allowInstantiation = true;
				instance = new Logger();
				allowInstantiation = false;
			}
			return instance;			
		}
		
		/**
		 * Shortcut for the getInstance Method
		 * @version 0.01
		 * 
		 * @return 	Logger
		 */		
		public static function $():Logger{
			return Logger.getInstance();
		}
		
		/**
		 * Trace the message in the MonsterDebugger and the built-in trace function 
		 * @version 0.01
		 * 
		 * @param msg: the message to display 
		 * @param logLevel: the level of importance: debug, info, warning, error, critical...
		 * @param object: if given, the object related
		 */
		public function log(msg:*, logLevel:int = 0, object=null):void{	
			var sepLevel = ''; // Visual level indicator separator
			switch(logLevel){
				case LEVEL_DEBUG:		sepLevel = '[debug] ';		break;
				case LEVEL_INFO: 		sepLevel = '[info] ';		break;
				case LEVEL_WARNING:		sepLevel = '[warning] ';	break;
				case LEVEL_ERROR:		sepLevel = '[ERROR] ';		break;
				case LEVEL_CRITICAL:	sepLevel = '[CRITICAL] '; 	break;
				default: 				sepLevel = ''; 				break;
			}
			trace(sepLevel + msg);
			if(isMonsterDebuggerEnabled){
				MonsterDebugger.trace(object, sepLevel + msg); // Send a trace to MonsterDebugger
			}
		}
		
		/**
		 * Clear all the log message where it is possible 
		 * @version 0.01
		 */		
		public function clear():void{
			if(isMonsterDebuggerEnabled){
				MonsterDebugger.clearTraces();
			}
		}
		
		/**
		 * Toggle the use of the MonsterDebugger 
		 * @version 0.01
		 * 
		 * @param bool: enable/disable
		 */		
		public function toggleMonsterDebugger(bool:Boolean):void{
			isMonsterDebuggerEnabled = bool;
		}
		
	}
}