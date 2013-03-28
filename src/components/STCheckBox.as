package components
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.controls.Alert;
	import mx.controls.CheckBox;
	import mx.controls.Label;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.states.AddChild;
	import mx.states.State;
	
	public class STCheckBox extends UIComponent
	{
		private var checkBox:CheckBox;
		private var _label:String;
		private var _checkBoxId:String;
		private var _hidden:Boolean;
		private var _disabled:Boolean;
		private var _selected:Boolean;
		private var _selectedAllChild:Boolean;
		private var _childPropertie:String;
		private var _otherChildPropertie:String;
		private var _selectValue:String;
		private var _source:String;
		private var _dataType:String;
		private var _dataDisplaySize:String;
		private var _field:String;
		private var _readonly:Boolean;
		private var _checkBoxName:String;
		private var _customScript;
		private var _isNeed;
		private var _initValue:String;
		private var _chromeColor:String;
		private var _fontColor:String;
		public function STCheckBox(){
			super();
			checkBox = new CheckBox();
			checkBox.x=3;
			checkBox.y=3;
			checkBox.height=25;
			this.height=25;
			addChild(checkBox);
			this.addEventListener(FlexEvent.UPDATE_COMPLETE,function(event:FlexEvent):void{
				checkBox.width=width-8;
				checkBox.height=height;
			});
		}
		
		//设定属性
		public function setPropertie(pro:Object):void{
			var ui:String = pro.ui;
			var id:String = pro.id;
			var value:String = pro.value;
			if(ui=="checkBox"){
				switch(id){
					case "id":
						this.checkBoxId = value;
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
						this.checkBox.label = value;
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
					case "selected":
						if(value=="true"){
							this.checkBox.selected =true;
						}else{
							this.checkBox.selected  =false;
						}
						break;
					case "selectedAllChild":
						if(value=="true"){
							this.selectedAllChild =true;
						}else{
							this.selectedAllChild  =false;
						}
						break;
					case "childPropertie":
						this.childPropertie =value;
						break;
					case "otherChildPropertie":
						this.otherChildPropertie =value;
						break;
					case "selectValue":
						this.selectValue = value;
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
						this.checkBoxName = value;
						break;
					case "customScript":
						this.customScript =value;
						break;
					case "initValue":
						this.initValue = value;
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
			this.checkBox.setStyle("color",value);
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
			this.checkBox.setStyle("chromeColor",value);
		}
		public function get label():String
		{
			_label = checkBox.label;
			return _label;
		}
		
		public function set label(value:String):void
		{	
			checkBox.label=value;
			_label= value;
		}
		
		public function get checkBoxId():String
		{
			if(_checkBoxId==null || _checkBoxId==""){
				_checkBoxId=this.name
			}
			return _checkBoxId;
		}
		
		public function set checkBoxId(value:String):void
		{
			_checkBoxId = value;
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
			this.checkBox.enabled = !value;
			_disabled = value;
		}

		public function get selected():Boolean
		{
			return this.checkBox.selected;
		}

		public function set selected(value:Boolean):void
		{
			this.checkBox.selected = value;
			_selected = value;
		}

		public function get selectedAllChild():Boolean
		{
			return _selectedAllChild;
		}

		public function set selectedAllChild(value:Boolean):void
		{
			_selectedAllChild = value;
		}

		public function get childPropertie():String
		{
			return _childPropertie==null?"":_childPropertie;
		}

		public function set childPropertie(value:String):void
		{
			_childPropertie = value;
		}

		public function get otherChildPropertie():String
		{
			return _otherChildPropertie==null?"":_otherChildPropertie;
		}

		public function set otherChildPropertie(value:String):void
		{
			_otherChildPropertie = value;
		}
		
		public function get selectValue():String
		{
			return _selectValue==null?"":_selectValue;
		}
		
		public function set selectValue(value:String):void
		{
			_selectValue = value;
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

		public function get checkBoxName():String
		{
			return _checkBoxName;
		}

		public function set checkBoxName(value:String):void
		{
			_checkBoxName = value;
		}

		public function get customScript()
		{
			return _customScript;
		}

		public function set customScript(value):void
		{
			_customScript = value;
		}
		public function get initValue():String
		{
			return _initValue==null?"":_initValue;
		}
		
		public function set initValue(value:String):void
		{
			_initValue = value;
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