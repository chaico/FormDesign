package components
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import mx.controls.Alert;
	import mx.controls.Label;
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.states.AddChild;
	import mx.states.State;
	

	public class InputField extends UIComponent
	{
		private var textInput:TextInput;
		//private var textField:TextField;
		private var _text:String;
		private var _inputFieldId:String;
		private var _hidden:Boolean;
		private var _readonly:Boolean;
		private var _disabled:Boolean;
		private var _source:String;
		private var _dataType:String;
		private var _dataDisplaySize:String;
		private var _field:String;
		private var _inputFieldName:String;
		private var chageWHFlag:Boolean;
		private var _textAlign:String;
		private var _initValue;
		private var _isType;
		private var _isNeed;
		private var _customScript;
		private var _contentBackgroundColor:String;
		private var _fontColor:String;
		private var _comboGridIni:String;
		public function InputField(){
			super();
			textInput = new TextInput();
			textInput.x=3;
			textInput.y=3;
			textInput.height=25;
			this.isType="text";
			this.height=25;
			addChild(textInput);
			this.addEventListener(FlexEvent.UPDATE_COMPLETE,function(event:FlexEvent):void{
				textInput.width=width-8;
				textInput.height=height;
				
			//	textField.width=textInput.width;
			//	textField.height=textInput.height;
			});
			textInput.addEventListener(FocusEvent.FOCUS_IN,function():void{
				
				setText();
			});
			textInput.addEventListener(FocusEvent.FOCUS_OUT,function():void{
				
				setUnText();
			});
			
			//textField = new TextField();
			//textField.x=textInput.x;
			//textField.y=textInput.y;
			//textField.height=textInput.height;
			//textField.mouseEnabled=false;
			//addChild(textField);
			
		}
		//设定属性
		public function setPropertie(pro:Object):void{
			var ui:String = pro.ui;
			var id:String = pro.id;
			var value:String = pro.value;
			if(ui=="inputField"){
				switch(id){
					case "id":
						this.inputFieldId = value;
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
					case "text":
						this.text =value;
						break;
					case "hidden":
						if(value=="true"){
							this.hidden =true;
						}else{
							this.hidden =false;
						}
						break;
					case "readonly":
						if(value=="true"){
							this.readonly =true;
						}else{
							this.readonly =false;
						}
						break;
					case "isNeed":
						if(value=="true"){
							this.isNeed =true;
						}else{
							this.isNeed =false;
						}
						break;
					case "disabled":
						if(value=="true"){
							this.disabled =true;
						}else{
							this.disabled =false;
						}
						break;
					case "isType":
						if(value==null || value=="null" || value=="" || value=="false"){
							value = "text";
						}
						this.isType =value;
						break;
					case "source":
						this.source =value;
						break;
					case "field":
						this.field =value;
						break;
					case "dataType":
						this.dataType =value;
						break;
					case "dataDisplaySize":
						this.dataDisplaySize =value;
						break;
					case "name":
						this.inputFieldName =value;
						break;
					case "textAlign":
						this.textAlign =value;
						break;
					case "initValue":
						this.initValue =value;
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
			this.textInput.setStyle("color",value);
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
			this.textInput.setStyle("contentBackgroundColor",value);
		}
		public function setUnText():void{
			if(textInput.text=="" 
				|| (textInput.text!=null && textInput.text!="" && textInput.text.substr(0,1)=="{" && textInput.text.substr(textInput.text.length-1,1)=="}")){
				if(source!=null && source!="" && field!=null && field!=""){
					textInput.text="{"+source+"."+field+"}";
				}
				
			}
		}
		public function setText():void{
			if(source!=null && source!="" && field!=null && field!=""){
				if(textInput.text=="{"+source+"."+field+"}"){
					textInput.text = "";
				}			
			}
		}
		public function get text():String
		{
			if((textInput.text!=null && textInput.text!="" && textInput.text.substr(0,1)=="{" && textInput.text.substr(textInput.text.length-1,1)=="}")){
				_text = "";
			}else{
				_text = textInput.text;
			}
			return _text;
		}

		public function set text(value:String):void
		{	
			
			textInput.text=value;
			_text = value;
			this.setUnText();
		}

		public function get inputFieldId():String
		{
			if(_inputFieldId==null || _inputFieldId==""){
				_inputFieldId=this.name
			}
			return _inputFieldId;
		}
		public function set inputFieldId(value:String):void
		{
			_inputFieldId = value;
		}
		public function get source():String
		{
			return _source==null?"":_source;
		}
		
		public function set source(value:String):void
		{
			_source = value;
			this.setUnText();
		}
		
		
		public function get field():String
		{
			return _field==null?"":_field;
		}
		
		public function set field(value:String):void
		{
			_field = value;
			this.setUnText();
		}

		public function get hidden():Boolean
		{
			return _hidden;
		}

		public function set hidden(value:Boolean):void
		{
			_hidden = value;
		}

		public function get readonly():Boolean
		{
			return _readonly;
		}

		public function set readonly(value:Boolean):void
		{
			_readonly = value;
		}

		public function get disabled():Boolean
		{
			return _disabled;
		}

		public function set disabled(value:Boolean):void
		{
			this.textInput.enabled=!value;
			_disabled = value;
		}


		public function get dataType():String
		{
			return _dataType==null?"":_dataType;
		}

		public function set dataType(value:String):void
		{
			_dataType = value;
		}

		public function get dataDisplaySize():String
		{
			return _dataDisplaySize==null?"":_dataDisplaySize;
		}

		public function set dataDisplaySize(value:String):void
		{
			_dataDisplaySize = value;
		}

		public function get inputFieldName():String
		{
			return _inputFieldName;
		}

		public function set inputFieldName(value:String):void
		{
			_inputFieldName = value;
		}

		public function get textAlign():String
		{
			return _textAlign;
		}

		public function set textAlign(value:String):void
		{
			if(value!=null && value!=""){
				textInput.setStyle("textAlign",value);
			}
			_textAlign = value;
		}

		public function get initValue()
		{
			return _initValue==null?"":_initValue;
		}

		public function set initValue(value):void
		{
			_initValue = value;
		}

		public function get isType()
		{
			return _isType;
		}

		public function set isType(value):void
		{
			_isType = value;
		}

		public function get customScript()
		{
			return _customScript;
		}

		public function set customScript(value):void
		{
			_customScript = value;
		}

		public function get isNeed()
		{
			return _isNeed;
		}

		public function set isNeed(value):void
		{
			_isNeed = value;
		}

		public function get comboGridIni():String
		{
			return _comboGridIni;
		}

		public function set comboGridIni(value:String):void
		{
			_comboGridIni = value;
		}





	}
}