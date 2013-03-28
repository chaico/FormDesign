package components
{
	import   mx . controls . Label ; 
	//自定义样式 
	[ Style ( name ='borderColor', type ='uint', format ='Color', inherit ='no')]    
	[ Style ( name ='borderWidth', type ='Number', format ='Length', inherit ='no')]    
	[ Style ( name ='borderAlpha', type ='Number', format ='Length', inherit ='no')]   
	
	public   class LabelBorder extends Label 
	{ 
		public   function LabelBorder () 
		{ 
			super () ; 
		} 
		
		override   protected function updateDisplayList ( w : Number , h : Number ) : void 
		{ 
			super . updateDisplayList ( w , h ) ; 
			graphics . clear () ; 
			graphics . lineStyle ( getStyle ('borderWidth') , getStyle ('borderColor') , getStyle ('borderAlpha') , false ) ; 
			var   x : Number = - ( getStyle ('borderWidth') / 2); 
			var y:Number = -(getStyle('borderWidth') /   2 ) ; 
			var   width : Number = textWidth + getStyle ('borderWidth') + 3 ; 
			var   height : Number = textHeight + getStyle ('borderWidth') ; 
			graphics.drawRect ( x , y , width , height ) ; 
		} 
	} 

}