package components
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.controls.Alert;
	import mx.controls.Label;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.states.AddChild;
	import mx.states.State;
	
	import tags.Td;
	import tags.Tr;

	public class TextArea extends UIComponent
	{
		private var textArea:mx.controls.TextArea;
		//private var textField:TextField;
		private var _text:String;
		private var _textAreaId:String;
		private var _hidden:Boolean;
		private var _readonly:Boolean;
		private var _disabled:Boolean;
		private var _source:String;
		private var _dataType:String;
		private var _dataDisplaySize:String;
		private var _field:String;
		private var _textAreaName:String;
		private var _textAlign:String;
		private var _initValue;
		private var _customScript;
		private var _isNeed;
		private var _contentBackgroundColor:String;
		private var _fontColor:String;
		
		public function TextArea(){
			super();
			textArea = new mx.controls.TextArea();
			textArea.x=3;
			textArea.y=3;
			textArea.height=50;
			this.height=50;
			addChild(textArea);
			this.addEventListener(FlexEvent.UPDATE_COMPLETE,function(event:FlexEvent):void{
				textArea.width=width-8;
				textArea.height=height;
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
				//textField.width=textArea.width;
				//textField.height=textArea.height;
				
			});
			textArea.addEventListener(FocusEvent.FOCUS_IN,function():void{
				
				setText();
			});
			textArea.addEventListener(FocusEvent.FOCUS_OUT,function():void{
				
				setUnText();
			});
			
			
			//textField = new TextField();
			//textField.x=textArea.x;
			//textField.y=textArea.y;
			//textField.height=textArea.height;
			//textField.mouseEnabled=false;
			//addChild(textField);
		}
		
		//设定属性
		public function setPropertie(pro:Object):void{
			var ui:String = pro.ui;
			var id:String = pro.id;
			var value:String = pro.value;
			if(ui=="textArea"){
				switch(id){
					case "id":
						this.textAreaId = value;
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
					case "disabled":
						if(value=="true"){
							this.disabled =true;
						}else{
							this.disabled =false;
						}
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
						this.textAreaName =value;
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
					case "isNeed":
						if(value=="true"){
							this.isNeed =true;
						}else{
							this.isNeed =false;
						}
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
			this.textArea.setStyle("contentBackgroundColor",value);
		}
		public function setUnText():void{
			if(textArea.text=="" 
				|| (textArea.text!=null && textArea.text!="" && textArea.text.substr(0,1)=="{" && textArea.text.substr(textArea.text.length-1,1)=="}")){
				if(source!=null && source!="" && field!=null && field!=""){
					textArea.text="{"+source+"."+field+"}";
				}
				
			}
		}
		public function setText():void{
			if(source!=null && source!="" && field!=null && field!=""){
				if(textArea.text=="{"+source+"."+field+"}"){
					textArea.text = "";
				}			
			}
		}
		public function get text():String
		{
			if((textArea.text!=null && textArea.text!="" && textArea.text.substr(0,1)=="{" && textArea.text.substr(textArea.text.length-1,1)=="}")){
				_text = "";
			}else{
				_text = textArea.text;
			}
			return _text;
		}

		public function set text(value:String):void
		{	
			textArea.text=value;
			_text = value;
			this.setUnText();
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
		public function get textAreaId():String
		{
			if(_textAreaId==null || _textAreaId==""){
				_textAreaId=this.name
			}
			return _textAreaId;
		}

		public function set textAreaId(value:String):void
		{
			_textAreaId = value;
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
			this.textArea.enabled = !value;
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
		

		public function get textAreaName():String
		{
			return _textAreaName;
		}

		public function set textAreaName(value:String):void
		{
			_textAreaName = value;
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
		
		public function get initValue()
		{
			return _initValue==null?"":_initValue;
		}
		
		public function set initValue(value):void
		{
			_initValue = value;
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






	}
}