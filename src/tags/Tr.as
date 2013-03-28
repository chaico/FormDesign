package tags
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.containers.Canvas;
	import mx.containers.GridRow;
	import mx.events.FlexEvent;

	public class Tr extends GridRow
	{
		private var _trId:String;
		private var drawStartPoint:Point;
		private var drawEndPoint:Point;
		private var _isDataGridDetail:Boolean;
		public function Tr()
		{
			super();
		}
		
		public function addTd(index:Number=-1):Td{
			var td:Td  = new Td();			
			
			if(index<0){
				this.addChild(td);
			}else{				
				this.addChildAt(td,index);
			}
			return td;
		}
		
		public function get trId():String
		{
			if(_trId==null || _trId==""){
				_trId=this.name
			}
			return _trId;
		}

		public function set trId(value:String):void
		{
			_trId = value;
		}

		public function get isDataGridDetail():Boolean
		{
			return _isDataGridDetail;
		}

		public function set isDataGridDetail(value:Boolean):void
		{
			_isDataGridDetail = value;
		}


	}
}