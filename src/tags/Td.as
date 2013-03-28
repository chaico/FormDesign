package tags
{
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	import mx.containers.GridItem;
	import mx.events.FlexEvent;
	import mx.managers.CursorManager;

	public class Td extends GridItem
	{
		private var _tdId:String;
		private var _canvas:Canvas = new Canvas();
		private var _backgroundColor:String;
		public function Td()
		{
			super();
			this.width=80;
			this.setStyle("color",0x000000);
			this.horizontalScrollPolicy="off";
			this.verticalScrollPolicy="off";
			canvas.setStyle("backgroundColor","red");
			canvas.setStyle("backgroundAlpha","0");
			addChild(canvas);
			
			addEventListener(FlexEvent.UPDATE_COMPLETE,function(event:FlexEvent):void{
				canvas.width= width;
				canvas.height= height;
			});
			//changeWHEvent();
		}
		
		//**改变宽高事件
		private function changeWHEvent():void{
			var changeWFlag:Boolean;
			var changeHFlag:Boolean;
			this.addEventListener(MouseEvent.MOUSE_DOWN,function(event:MouseEvent):void{
				/*if(focusObj.contentMouseX+4 > focusObj.width-10  && focusObj.contentMouseX+4 <= focusObj.width){
				changeWFlag=true;
				}else if(focusObj.contentMouseY+4 > focusObj.height-5  && focusObj.contentMouseY+4 <= focusObj.height){
				changeHFlag=true;
				}*/
			});
			this.addEventListener(MouseEvent.MOUSE_UP,function(event:MouseEvent):void{
				changeWFlag=false;
				changeHFlag=false;
				CursorManager.removeAllCursors();
			});
			this.addEventListener(MouseEvent.MOUSE_MOVE,function(event:MouseEvent):void{
				if(event.target is Td){
					if(changeWFlag==true){
						//width = contentMouseX+4;
					}else if(changeHFlag==true){
						//height = contentMouseY+4;
					}else{
						Horz(-10,0)  
						//Vert(0,-10); 
						//CursorManager.removeAllCursors();
					}
					
				}
				
			});
		}
		
		//垂直调整
		private function Vert(xOffset:Number,yOffset:Number):void{
			[Embed(source="asserts/pan_vert.png")]  
			var curvert:Class;   
			CursorManager.setCursor(curvert,2,xOffset,yOffset); 
			
		}
		//水平调整
		private function Horz(xOffset:Number,yOffset:Number):void{
			[Embed(source="asserts/pan_horz.png")]  
			var curhorz:Class;   
			CursorManager.setCursor(curhorz,2,xOffset,yOffset);
			
		}
		public function get tdId():String
		{
			if(_tdId==null || _tdId==""){
				_tdId=this.name
			}
			return _tdId;
		}

		public function set tdId(value:String):void
		{
			_tdId = value;
		}

		public function get canvas():Canvas
		{
			return _canvas;
		}

		public function set canvas(value:Canvas):void
		{
			_canvas = value;
		}

		public function get backgroundColor():String
		{
			return _backgroundColor;
		}

		public function set backgroundColor(value:String):void
		{
			_backgroundColor = value;
			if(value==null || value=="null"|| value==""){
				return
			}
			this.setStyle("backgroundColor",value);
		}

	}
}