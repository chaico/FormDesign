package components
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.states.AddChild;
	import mx.states.State;

	public class STImage extends UIComponent
	{
		private var image:Image;
		private var _title:String;
		private var _imageId:String;
		private var _hidden:Boolean;
		private var _autoWH:Boolean;
		private var _customScript:String;
		private var _src:String;
		public function STImage(){
			super();
			image = new Image();
			image.x=3;
			image.y=3;
			image.height=25;
			this.height=25;
			image.source="../asserts/image.png"
			image.scaleContent=true;
			image.maintainAspectRatio=false;
				

			addChild(image);
			this.addEventListener(FlexEvent.UPDATE_COMPLETE,function(event:FlexEvent):void{
				image.width=width-8;
				image.height=height;
			});
		}
		
		//设定属性
		public function setPropertie(pro:Object):void{
			var ui:String = pro.ui;
			var id:String = pro.id;
			var value:String = pro.value;
			if(ui=="image"){
				switch(id){
					case "id":
						this.imageId = value;
						break;
					case "width":
						this.width = new Number(value);
						break;
					case "height":
						this.height = new Number(value);
						break;
					case "x":
						this.x = new Number(value);
						break;
					case "y":
						this.y = new Number(value);
						break;
					case "title":
						this.title =value;
						break;
					case "src":
						this.src =value;
						break;
					case "hidden":
						if(value=="true"){
							this.hidden =true;
						}else{
							this.hidden =false;
						}
						break;
					case "customScript":
						this.customScript =value;
						break;
					case "autoWH":
						if(value=="true"){
							this.autoWH =true;
						}else{
							this.autoWH =false;
						}
						break;
					default:
						break;
					
				}
			}
		}
		public function get imageId():String
		{
			if(_imageId==null || _imageId==""){
				_imageId=this.name
			}
			return _imageId;
		}

		public function set imageId(value:String):void
		{
			_imageId = value;
		}

		public function get hidden():Boolean
		{
			return _hidden;
		}

		public function set hidden(value:Boolean):void
		{
			_hidden = value;
		}


		public function get customScript()
		{
			return _customScript;
		}

		public function set customScript(value):void
		{
			_customScript = value;
		}

		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
		}

		public function get src():String
		{
			return _src;
		}

		public function set src(value:String):void
		{
			_src = value;
		}

		public function get autoWH():Boolean
		{
			return _autoWH;
		}

		public function set autoWH(value:Boolean):void
		{
			_autoWH = value;
		}



	}
}