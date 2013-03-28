package components
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.controls.Label;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.states.AddChild;
	import mx.states.State;
	
	import tags.Td;
	import tags.Tr;

	public class InputLabel extends UIComponent
	{
		private var _textArea:DynamicTextArea = new DynamicTextArea();
		private var _text:String;
		private var _htmlText:String;
		private var _inputLabelId:String;
		private var _textAlign:String;
		private var _contentBackgroundColor:String;
		private var _fontColor:String;
		public function InputLabel()
		{
			textArea.x=3;
			textArea.y=3;
			textArea.setStyle("contentBackgroundAlpha","0");
			textArea.height=25;
			//Alert.show(textArea.maxHeight+"");
			this.addChild(textArea);
			this.addEventListener(FlexEvent.UPDATE_COMPLETE,function(event:FlexEvent):void{
				//height=textArea.height+5;
				textArea.width=width-8;
				textArea.maxHeight = textArea.height+10;
				if(textArea.parent.parent.parent is Td){
					var td :Td = textArea.parent.parent.parent as Td;
					var tr :Tr = textArea.parent.parent.parent.parent as Tr;
					if(td.width<textArea.width+textArea.x){
						td.width = textArea.width+textArea.x+10;
					}
					if(tr.height<textArea.height+textArea.y){
						tr.height = textArea.height+textArea.y+10;
					}
				}
				textArea.isChangeMinHeight=true;
			});
		}
		override public function set height(value:Number):void{
			super.height=value;
			textArea.maxHeight=value;
		}
		//设定属性
		public function setPropertie(pro:Object):void{
			var ui:String = pro.ui;
			var id:String = pro.id;
			var value:String = pro.value;
			if(ui=="inputLabel"){
				switch(id){
					case "id":
						this.inputLabelId = value;
						break;
					case "width":
						this.width = new Number(value);
						break;
					case "height":
						this.height = new Number(value);
						textArea.resetHeight(new Number(value));
						break;
					case "x":
						this.x = new Number(value);
						break;
					case "y":
						this.y = new Number(value);
						break;
					case "text":
						this.textArea.text =value;
						break;
					case "textAlign":
						this.textAlign =value;
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
			this.textArea.setStyle("color",value);
		}
		public function get contentBackgroundColor():String
		{
			return _contentBackgroundColor;
		}
		
		public function set contentBackgroundColor(value:String):void
		{
			_contentBackgroundColor = value;
			if(value==null || value=="null" || value==""){
				return;
			}
			this.textArea.setStyle("contentBackgroundAlpha","1");
			this.textArea.setStyle("contentBackgroundColor",value);
		}
		override public function get height():Number{
			
			return textArea.height;
		}
		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			//label.text=value;
			textArea.text=value;
			_text = value;
		}

		public function get htmlText():String
		{
			return _htmlText;
		}

		public function set htmlText(value:String):void
		{
			//label.htmlText=value;
			textArea.htmlText=value;
			_htmlText = value;
		}

		public function get textArea():DynamicTextArea
		{
			return _textArea;
		}

		public function set textArea(value:DynamicTextArea):void
		{
			_textArea = value;
		}

		public function get inputLabelId():String
		{
			if(_inputLabelId==null || _inputLabelId==""){
				_inputLabelId=this.name
			}
			return _inputLabelId;
		}

		public function set inputLabelId(value:String):void
		{
			_inputLabelId = value;
		}
		
		
		public function get textAlign():String
		{
			return _textAlign;
		}
		public function set textAlign(value:String):void
		{
			
			if(value!=null && value!=""){
				textArea.setStyle("textAlign",value);
			}
			_textAlign = value;
		}

	}
}