package components
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.Label;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.states.AddChild;
	import mx.states.State;

	public class STButton extends UIComponent
	{
		private var button:Button;
		private var _label:String;
		private var _buttonId:String;
		private var _hidden:Boolean;
		private var _disabled:Boolean;
		private var _textAlign:String;
		private var _btnType:String;
		private var _customScript;
		private var _chromeColor:String;
		private var _fontColor:String;
		public function STButton(){
			super();
			button = new Button();
			button.x=3;
			button.y=3;
			button.height=25;
			this.height=25;
			addChild(button);
			this.addEventListener(FlexEvent.UPDATE_COMPLETE,function(event:FlexEvent):void{
				button.width=width-8;
				button.height=height;
			});
		}
		
		//设定属性
		public function setPropertie(pro:Object):void{
			var ui:String = pro.ui;
			var id:String = pro.id;
			var value:String = pro.value;
			if(ui=="button"){
				switch(id){
					case "id":
						this.buttonId = value;
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
					case "label":
						this.label =value;
						this.button.label = value;
						break;
					case "hidden":
						if(value=="true"){
							this.hidden =true;
						}else{
							this.hidden =false;
						}
						break;
					case "disabled":
						if(value=="true"){
							this.disabled =true;
						}else{
							this.disabled =false;
						}
						break;
					case "textAlign":
						this.textAlign =value;
						break;
					case "btnType":
						this.btnType =value;
						break;
					case "customScript":
						this.customScript =value;
						break;
					default:
						break;
					
				}
			}
		}
		public function get fontColor():String
		{
			return _fontColor;
		}		
		public function set fontColor(value:String):void
		{
			_fontColor = value;
			if(value==null || value=="null" || value==""){
				return;
			}
			this.button.setStyle("color",value);
		}
		public function get chromeColor():String
		{
			return _chromeColor;
		}
		
		public function set chromeColor(value:String):void
		{
			_chromeColor = value;
			if(value==null || value=="null" || value==""){
				return;
			}
			this.button.setStyle("chromeColor",value);
		}
		public function get label():String
		{
			_label = button.label;
			return _label;
		}

		public function set label(value:String):void
		{	
			button.label=value;
			_label= value;
		}

		public function get buttonId():String
		{
			if(_buttonId==null || _buttonId==""){
				_buttonId=this.name
			}
			return _buttonId;
		}

		public function set buttonId(value:String):void
		{
			_buttonId = value;
		}

		public function get hidden():Boolean
		{
			return _hidden;
		}

		public function set hidden(value:Boolean):void
		{
			_hidden = value;
		}

		public function get disabled():Boolean
		{
			return _disabled;
		}

		public function set disabled(value:Boolean):void
		{
			this.button.enabled = !value;
			_disabled = value;
		}
		
		public function get textAlign():String
		{
			return _textAlign;
		}
		public function set textAlign(value:String):void
		{
			//button.setStyle("textAlign",value);
			_textAlign = value;
		}

		public function get btnType():String
		{
			return _btnType;
		}

		public function set btnType(value:String):void
		{
			_btnType = value;
		}

		public function get customScript()
		{
			return _customScript;
		}

		public function set customScript(value):void
		{
			_customScript = value;
		}



	}
}