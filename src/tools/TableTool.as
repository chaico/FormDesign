package tools
{
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.containers.Canvas;
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	
	import tags.Table;

	public class TableTool extends UIComponent
	{
		private var _event:MouseEvent;
		private var topY:int = -20;
		private var _table:Table;
		private var _mergecellBtnDisable:Boolean;
		var imgMergecell:Image = new Image();
		public function TableTool()
		{
			super();
			this.init();
		}
		/**
		 * 初始化工具箱
		 * */
		public function init():void{
			var canvas:Canvas = new Canvas();
			canvas.setStyle("backgroundColor","0xffffff");
			canvas.width=50;
			canvas.height=22;
			canvas.x=0;
			canvas.y=topY;
			this.addChild(canvas);
			this.AddDeleteBtn(0);
			this.AddMergecellBtn(25);
			//this.AddTextBtn(25);
			this.setXY();
		}
		/**
		 * 添加删除按钮
		 * */
		private function AddDeleteBtn(x:Number):void{
			
			var me:TableTool = this;
			var img:Image = new Image();
			img.source='../asserts/recycle_bin.png';
			img.width=23;
			img.height=23;
			img.x = x
			img.y= topY;
			img.addEventListener(MouseEvent.CLICK,function (e:MouseEvent):void{
				var msg:String="是否确定删除表格？";
				Alert.show(msg,"警告",Alert.OK|Alert.CANCEL,null,function (e:CloseEvent):void{
					if(e.detail==Alert.OK){
						table.parent.removeChild(table);
						parent.removeChild(me);
					}
				},null,Alert.CANCEL);
			});
			addChild(img);
		}
		private function AddMergecellBtn(x:Number):void{
			var me:TableTool = this;
			imgMergecell.source='../asserts/mergecell.png';
			imgMergecell.width=23;
			imgMergecell.height=23;
			imgMergecell.x= x;
			imgMergecell.y= topY;
			imgMergecell.addEventListener(MouseEvent.CLICK,function (e:MouseEvent):void{
				if(mergecellBtnDisable == false){
					table.merge();
				}
			});
			addChild(imgMergecell);
		}
		
		public function set mergecellBtnDisable(value:Boolean):void
		{
			if(value==true){
				imgMergecell.source='../asserts/mergecell_disable.png';
			}else{				
				imgMergecell.source='../asserts/mergecell.png';
			}
			_mergecellBtnDisable = value;
		}
		
		private function AddTextBtn(x:Number):void{
			var me:TableTool = this;
			var img:Image = new Image();
			img.source='../asserts/text.png';
			img.width=23;
			img.height=23;
			img.x= x;
			img.y= topY;
			img.addEventListener(MouseEvent.CLICK,function (e:MouseEvent):void{
				
			});
			addChild(img);
		}
		/**
		 * 改变位置
		 * */
		public function ChangePoint(event:MouseEvent):void{
			this.event = event;
			this.setXY();
		}
		public function removeEvent(event:MouseEvent):void{
			//trace(event.target);
			//if(event.target is TableTool){
			//	this.parent.removeChild(this);
			//}
		
		}
		public function setXY():void{
			var width:Number = 0;
			var height:Number = 0;
			//this.x = event.target.x;
			//this.y = event.target.y;
		}


		public function get event():MouseEvent
		{
			return _event;
		}

		public function set event(value:MouseEvent):void
		{
			_event = value;
		}

		public function get table():Table
		{
			return _table;
		}

		public function set table(value:Table):void
		{
			_table = value;
		}

		public function get mergecellBtnDisable():Boolean
		{
			return _mergecellBtnDisable;
		}


	}
}