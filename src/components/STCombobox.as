package components
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.controls.Alert;
	import mx.controls.ComboBox;
	import mx.controls.Label;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.states.AddChild;
	import mx.states.State;

	public class STCombobox extends UIComponent
	{
		private var comboBox:ComboBox;
		private var _comboBoxId:String;
		private var _hidden:Boolean;
		private var _disabled:Boolean;
		private var _textAlign:String;
		private var _readonly:Boolean;
		private var _source:String;
		private var _dataType:String;
		private var _dataDisplaySize:String;
		private var _field:String;
		private var _comboBoxName:String;
		private var _initValue:String;
		private var _selectValue:String;
		private var _customScript;
		private var _isNeed;
		private var _chromeColor:String;
		private var _fontColor:String;

		public function STCombobox(){
			super();
			comboBox = new ComboBox();
			comboBox.x=3;
			comboBox.y=3;
			comboBox.height=25;
			this.height=25;
			addChild(comboBox);
			this.addEventListener(FlexEvent.UPDATE_COMPLETE,function(event:FlexEvent):void{
				comboBox.width=width-8;
				comboBox.height=height;
			});
		}
		
		//设定属性
		public function setPropertie(pro:Object):void{
			var ui:String = pro.ui;
			var id:String = pro.id;
			var value:String = pro.value;
			if(ui=="comboBox"){
				switch(id){
					case "id":
						this.comboBoxId = value;
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
					case "readonly":
						if(value=="true"){
							this.readonly =true;
						}else{
							this.readonly =false;
						}
						break;
					case "source":
						this.source = value;
						break;
					case "dataType":
						this.dataType = value;
						break;
					case "dataDisplaySize":
						this.dataDisplaySize = value;
						break;
					case "field":
						this.field = value;
						break;
					case "name":
						this.comboBoxName = value;
						break;
					case "initValue":
						this.initValue = value;
						break;
					case "selectValue":
						this.selectValue = value;
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
			this.comboBox.setStyle("color",value);
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
			this.comboBox.setStyle("chromeColor",value);
		}


		public function get comboBoxId():String
		{
			if(_comboBoxId==null || _comboBoxId==""){
				_comboBoxId=this.name
			}
			return _comboBoxId;
		}

		public function set comboBoxId(value:String):void
		{
			_comboBoxId = value;
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
			this.comboBox.enabled = !value;
			_disabled = value;
		}
		
		public function get textAlign():String
		{
			return _textAlign;
		}
		public function set textAlign(value:String):void
		{
			//comboBox.setStyle("textAlign",value);
			_textAlign = value;
		}

		public function get readonly():Boolean
		{
			return _readonly;
		}

		public function set readonly(value:Boolean):void
		{
			_readonly = value;
		}

		public function get source():String
		{
			return _source;
		}

		public function set source(value:String):void
		{
			_source = value;
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

		public function get field():String
		{
			return _field;
		}

		public function set field(value:String):void
		{
			_field = value;
		}

		public function get comboBoxName():String
		{
			return _comboBoxName;
		}

		public function set comboBoxName(value:String):void
		{
			_comboBoxName = value;
		}

		public function get initValue():String
		{
			return _initValue==null?"":_initValue;
		}

		public function set initValue(value:String):void
		{
			_initValue = value;
		}

		public function get selectValue():String
		{
			return _selectValue==null?"":_selectValue;
		}

		public function set selectValue(value:String):void
		{
			_selectValue = value;
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