package components
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.controls.Alert;
	import mx.controls.Image;

	public class MoveImg extends Image
	{
		public var moveflag:Boolean;
		public var mousePoint:Point;
		public var focusObj:Object;
		public function MoveImg()
		{
			this.mouseChildren=false;
			this.source='../asserts/move.png';
			this.addEventListener(MouseEvent.MOUSE_DOWN,function():void{
				moveflag=true;
			});
			this.addEventListener(MouseEvent.MOUSE_UP,function():void{
				moveflag=false;
			});
		}
		
	}
}