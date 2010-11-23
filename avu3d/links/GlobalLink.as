package com.avu3d.links
{
	import com.avu3d.*;
	import com.avu3d.links.*;
	import com.avu3d.logger.*;

	public class GlobalLink extends Object{
		
		public var x;
		public var y;
		public var x2;
		public var y2;
		public var idPoint;
		public var action;
		public var param1;
		public var comkey;
		public var param2;
		public var image;
		public var label;
		
		public static const ACTION_POV3D:int 	= 2; // Action to a LinkPov3d
		public static const ACTION_PROJECT:int 	= 3; // Action to a LinkProject
		public static const ACTION_SEQUENCE:int = 5; // Action to a LinkSequence
		public static const ACTION_HTML:int 	= 6; // Action to a LinkHtml
		
		public function GlobalLink(x=null,y=null,x2=null,y2=null,idPoint=null,action=null,param1=null,comkey=null,param2=null,image=null,label=null){
			Logger.$().log('New GlobalLink(' 	+ 'x:' + x 
									+ ' y:' + y 
									+ ' x2:' + x2 
									+ ' y2:' + y2 
								  	+ ' idPoint:' + idPoint 
									+ ' action:' + action
									+ ' param1:' + param1 
									+ ' comkey:' + comkey 
									+ ' param2:' + param2 
									+ ' image:' + image 
									+ ' label:' + label 
									+ ')'
			, Logger.LEVEL_DEBUG, this);
			
			this.x = forceToNumber(x);
			this.y = forceToNumber(y);
			this.x2 = forceToNumber(x2);
			this.y2 = forceToNumber(y2);
			this.idPoint = forceToNumber(idPoint);
			this.action = forceToNumber(action);
			this.param1 = forceToNumber(param1);
			this.comkey = forceToNumber(comkey);
			this.param2 = forceToNumber(param2);
			this.image = image;
			this.label = label;
		}
		
		public function getLink():LinkInterface{
			var link:LinkInterface;
			switch(action){
				case ACTION_POV3D:		link = new LinkPov3d(param1); trace('param1:' + param1); break;
				//case ACTION_PROJECT:	link = new LinkPov3d(param1); break;
				//case ACTION_SEQUENCE:	link = new LinkPov3d(param1); break;
				//case ACTION_HTML:		link = new LinkPov3d(param1); break;
			}
			return link;
		}
		
		private function forceToNumber(str){
			var realNum = Number(str);
			return (isNaN(realNum)) ? str : realNum;
		}
	}
}