package tags
{
	import mx.containers.Panel;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	import spark.components.Button;
	
	import sub.DataSourceAdd;
	import sub.DataSourceManager;

	public class DataSourcePanel extends Panel
	{
		import mx.controls.LinkButton;
		
		import flash.events.MouseEvent;
		
		import flash.events.Event;
		
		
		public var formDesign:FormDesign;
		public function DataSourcePanel()
		{
			//trace("加载自定义Panel");
			
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE,function():void{
				
				var addButton:Button  = new Button();
				addButton.label="数据源管理";
				addButton.width=80;
				addButton.height=25;
				addButton.x=60;
				addButton.y=3;
				addButton.addEventListener(MouseEvent.CLICK,appDataSourceSubWindow);
				titleBar.addChild(addButton);
				
				var rButton:Button  = new Button();
				rButton.label="刷新";
				rButton.width=50;
				rButton.height=25;
				rButton.x=150;
				rButton.y=3;
				rButton.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
					formDesign.getDataSourceTree(event);
				});
				titleBar.addChild(rButton);
			});
		}
		
		private function appDataSourceSubWindow(event:MouseEvent):void
		{ 
			var dsa:DataSourceManager = new DataSourceManager();
			dsa.formDesign =formDesign; 
			dsa.formDesign.DataBaseSend();
			PopUpManager.addPopUp(dsa, parent.parent, true); 
			PopUpManager.centerPopUp(dsa); 
			//PopUpManager.createPopUp(htmlDesign,DataSourceAdd,true);
		}
		/**
		 
		 * 覆盖父类方法，创建自定义可视UI组件
		 
		 **/
		
		override protected function createChildren():void
			
		{
			
			trace("create child...");
			
			super.createChildren();
			
			
			
		}
		
		/**
		 
		 * 覆盖父类方法，更新自定义可视UI组件
		 
		 * */
		
		override protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number):void
			
		{
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			//调整对象大小
			/*
			if(buttonUI!=null){
				
				buttonUI.setActualSize( buttonUI.getExplicitOrMeasuredWidth(),
					
					buttonUI.getExplicitOrMeasuredHeight() );
				
				
				
				var y:int = 4;
				
				var buttonx:int = this.width - buttonUI.width - 12;
				
				buttonUI.move(buttonx, y);
				
			}*/
			
		}
		
	}
}