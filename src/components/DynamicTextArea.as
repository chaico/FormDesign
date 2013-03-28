package components {
	import flash.events.Event;
	
	import mx.controls.Alert;
	import mx.controls.TextArea;
	import mx.core.IUITextField;
	import mx.core.UITextField;
	import mx.events.FlexEvent;
	
	public class DynamicTextArea extends TextArea{
		public var isChangeMinHeight:Boolean;
		public function DynamicTextArea(){
			super();
			super.horizontalScrollPolicy = "off";
			super.verticalScrollPolicy = "off";
			this.addEventListener(Event.CHANGE, adjustHeightHandler);
			this.addEventListener(FlexEvent.CREATION_COMPLETE, adjustHeightHandler);
			this.setStyle("borderColor",0xE7E7E7);
			//this.text="aaaaaaa";
		}
		private function adjustHeightHandler(event:Event):void{
			trace("textField.getLineMetrics(0).height: " +
				textField.getLineMetrics(0).height);
			if(isChangeMinHeight || height <= textField.textHeight +
				textField.getLineMetrics(0).height){
				height = textField.textHeight;     
				validateNow();
			}
		}
		public function resetHeight(value:Number):void{
			super.height = value;
		}
		override public function set text(val:String):void{
			super.text = val;
			validateNow();
			if(textField!=null){
				height = textField.textHeight;
				validateNow();
			}
		}
		override public function set htmlText(val:String):void{
			super.htmlText = val;
			validateNow();
			if(textField!=null){
				height = textField.textHeight;
				validateNow();
			}
		}
		override public function set height(value:Number):void{
			
			if(textField == null){
				if(height <= value){
					super.height = value;
				}
			}else{       
				var currentHeight:uint = textField.textHeight +
					textField.getLineMetrics(0).height;
				if (isChangeMinHeight || currentHeight<= super.maxHeight){
					if(textField.textHeight !=
						textField.getLineMetrics(0).height){
						super.height = currentHeight;
					}        
				}else{
					super.height = super.maxHeight;  
				}  
			}
		}
		override public function get text():String{
			return super.text;
		}
		override public function get htmlText():String{
			return super.htmlText;
		}
		
		override public function set maxHeight(value:Number):void{
			super.maxHeight = value;
		}
	}
}
