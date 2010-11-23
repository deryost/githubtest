/**
 * This class is the most common type of link, it's a link to a Pov3d object
 * 
 * @author		Maxime Gendreau
 * @company 	UrbanImmersive
 * @link 		http://www.urbanimmersive.com
 * @version 0.01
 * 
 */

package com.avu3d.links{
	
	import com.avu3d.*;
	import com.avu3d.logger.*;
	
	public class LinkPov3d extends BaseObject implements LinkInterface{
		
		private var id:int;
		
		/**
		 * Constructor
		 * @version 0.01
		 *  
		 * @param id
		 */		
		public function LinkPov3d(id){
			log('New LinkPov3d(id:'+id+')', Logger.LEVEL_DEBUG, this);
			this.id = id;
		}
		
		/**
		 * Return the id for creating a Pov3d object 
		 * @version 0.01
		 * 
		 * @return id
		 */		
		public function getId():int{
			return id;
		}
	}
}