package flex.utils.ui
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import mx.containers.TitleWindow;
	import mx.core.EdgeMetrics;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.skins.Border;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	
	use namespace mx_internal;

	/**
	 *  The border alpha value (0-1).
	 *  @default 1
	 */
	[Style(name="borderAlpha", type="Number", format="Length", inherit="no")]

	/**
	 *  The border color.
	 *  @default #000000
	 */
	[Style(name="borderColor", type="uint", format="Color", inherit="no")]

	/**
	 *  The border thickness in pixels.
	 *  @default 1
	 */
	[Style(name="borderThickness", type="Number", format="Length", inherit="no")]

	/**
	 *  Alpha of the background.
	 *  The default value is 0.
	 */
	[Style(name="backgroundAlpha", type="Number", inherit="no")]

	/**
	 *  The background color.
	 *  @default #ffffff
	 */
	[Style(name="backgroundColor", type="uint", format="Color", inherit="no")]
	
	/**
	 *  The radius of the rounded border corners.
	 *  @default 0
	 */
	[Style(name="cornerRadius", type="Number", format="Length", inherit="no")]

	[IconFile("TitledBorderBox.png")]


	/**
	 * This class extends TitleWindow to draw a solid border instead of the default 
	 * Panel border.  This border defaults to a solid square 1 pixel black border that 
	 * goes around the entire panel except for where the title, status and close button are located.
	 * A border is also drawn between the title TextField and the status TextField.
	 * It also has support for added extra buttons in the top right corner of the titlebar, to the
	 * left of the close button. 
	 * 
	 * <pre>
	 *  &lt;ui:TitledBorderWindow
 	 *   <strong>Properties</strong>
 	 *   layout="vertical|horizontal|absolute"
	 *   title=""
	 *   borderDropShadow="false"
	 *   <strong>Styles</strong>
	 *   backgroundAlpha="0"
	 *   backgroundColor="0xffffff"
 	 *   borderColor="#000000"
 	 *   borderThickness="1"
 	 *   borderAlpha="1"
 	 *   cornerRadius="0"
 	 * &gt;
 	 *      ...
 	 *      <i>child tags</i>
 	 *      ...
 	 *  &lt;/ui:TitledBorderWindow&gt;
 	 *  </pre>
	 * 
	 * @author Chris Callendar
	 * @date April 2nd, 2009
	 */
	public class TitledBorderWindow extends TitleWindow
	{
		// setup the default styles
		private static var classConstructed:Boolean = classConstruct(); 
		private static function classConstruct():Boolean {
			var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("TitledBorderWindow");
            if (!style) {
                style = new CSSStyleDeclaration();
            }
            style.defaultFactory = function():void {
        	    this.backgroundAlpha = 0;
        	    this.backgroundColor = 0xffffff;
           	    this.borderColor = 0x0;
        	    this.borderThickness = 1;
        	    this.borderAlpha = 1;
        	    this.cornerRadius = 0;
        	};
			StyleManager.setStyleDeclaration("TitledBorderWindow", style, true);      	
            return true;
        };
		
		private var _borderDropShadow:Boolean;
		private var extraTitleBarButtons:Array;
		private var finishedCreatingChildren:Boolean;

		public function TitledBorderWindow() {
			super();
			_borderDropShadow = false;
			// if we don't set this to null and the headerColors style is set, then 
			// the top border is hidden by the header colors gradient
        	setStyle("headerColors", null);
        	extraTitleBarButtons = [];
        	finishedCreatingChildren = false;
			
			addEventListener("titleChanged", repaintBorder);
			addEventListener("statusChanged", repaintBorder);
			addEventListener("titleIconChanged", repaintBorder);
		}
		
		private function repaintBorder(event:Event):void {
			invalidateDisplayList();
		}

		[Bindable("borderDropShadowChanged")]
		[Inspectable(category="General")]
		/** Adds a DropShadowFilter to the border. False by default. */
		public function get borderDropShadow():Boolean {
			return _borderDropShadow;
		}
		
		public function set borderDropShadow(dropShadow:Boolean):void {
			if (dropShadow != _borderDropShadow) {
				_borderDropShadow = dropShadow;
				if (border) {
					border.filters = (dropShadow ? [ new DropShadowFilter(2, 45, 0x0, 0.4) ] : []);
				}
				dispatchEvent(new Event("borderDropShadowChanged"));
			}
		}
		
		override public function set showCloseButton(value:Boolean):void {
			if (showCloseButton != value) {
				super.showCloseButton = value;
				invalidateDisplayList();
			}
		}
		
		override protected function createChildren():void {
			super.createChildren();
			finishedCreatingChildren = true;
			
			// add any extra buttons that were added before the children were created
			if (extraTitleBarButtons.length > 0) {
				for each (var btn:UIComponent in extraTitleBarButtons) {
					addTitleBarButton(btn);
				}
			}
		}
		
		/**
		 * Adds a button (or UIComponent) to the titleBar.
		 * The button is added to the left of the close button in the top right
		 * corner of the titleBar.
		 */
		public function addTitleBarButton(btn:UIComponent):void {
			if (btn && (btn.parent != titleBar)) {
				if (finishedCreatingChildren) {
					// default to adding it last
					var index:int = titleBar.numChildren;
					// if the close button is there - add it before the close button
					if (closeButton && (closeButton.parent == titleBar)) {
						var closeButtonIndex:int = titleBar.getChildIndex(closeButton);
						if (closeButtonIndex != -1) {
							index = closeButtonIndex;
						}
					}
					titleBar.addChildAt(btn, index);
					invalidateDisplayList();
				}
				extraTitleBarButtons.push(btn);
			}
		}
		
		/**
		 * Removes a titleBar button if it exists.
		 * Can't be the close button.
		 * @return true if the button was removed.
		 */
		public function removeTitleBarButton(btn:UIComponent):Boolean {
			var removed:Boolean = false;
			if (btn && (btn != closeButton) && (btn.parent == titleBar)) {
				var index:int = extraTitleBarButtons.indexOf(btn);
				if (index != -1) {
					extraTitleBarButtons.splice(index, 1);
					if (finishedCreatingChildren) {
						index = titleBar.getChildIndex(btn);
						if (index != -1) {
							titleBar.removeChildAt(index);
							removed = true;
							invalidateDisplayList();
						}
					}
				}
			}
			return removed;
		}
		
		/**
		 * Creates the border if it is needed.
		 */
	    override protected function createBorder():void {
	    	if (!border && isBorderNeeded()) {
	    		border = new Border();
				border.filters = (borderDropShadow ? [ new DropShadowFilter(2, 45, 0x0, 0.4) ] : []);
	    		// add first to put below all child components
	    		rawChildren.addChildAt(DisplayObject(border), 0);
	    		invalidateDisplayList();
	    	}
	    }
	    
	    /**
	    * Determines if a border is needed based on the backgroundAlpha and backgroundColor styles,
	    * as well as the borderThickness and borderAlpha styles.
	    */
	    private function isBorderNeeded():Boolean {
	    	var bgAlpha:Number = getNumberStyle("backgroundAlpha", 1);
			var bgColor:Number = getStyle("backgroundColor");
	    	var bt:Number = getNumberStyle("borderThickness", 1);
	    	var ba:Number = getNumberStyle("borderAlpha", 1);
	    	return (!isNaN(bgColor) && (bgAlpha > 0)) || ((bt > 0) && (ba > 0));
	    }
	    
	    /**
	     * Returns an EdgeMetrics object that has four properties:
	     * <code>left</code>, <code>top</code>, <code>right</code>,
	     * and <code>bottom</code>.
	     */
	    override public function get borderMetrics():EdgeMetrics {
	    	var bt:Number = getNumberStyle("borderThickness", 1);
	    	// should we include the corner radius?!?
	    	var cr:Number = 0; //getNumberStyle("cornerRadius", 0);
	    	var hh:Number = getHeaderHeight();
	    	//  need to include the control bar in the border metrics
	    	var cbh:Number = 0;
	    	if (controlBar) {
	    		cbh = controlBar.height;
	    	}

	    	return new EdgeMetrics(bt+cr, bt+cr+hh, bt+cr, bt+cr+cbh);
	    }
	    
	    override protected function measure():void {
	    	super.measure();
	    	// add extra width for the titlebar buttons
	    	if (extraTitleBarButtons.length > 0) {
	    		var btnWidth:Number = 4;
	    		for each (var btn:UIComponent in extraTitleBarButtons) {
	    			btnWidth += btn.width + 4;
	    		}
	    		measuredMinWidth = measuredMinWidth + btnWidth;
        		measuredWidth = measuredWidth + btnWidth;
	    	}
	    }
	    
		override protected function updateDisplayList(w:Number, h:Number):void {
			super.updateDisplayList(w, h);
			drawBorderAndBackground(w, h);
		}
		
		override protected function layoutChrome(w:Number, h:Number):void {
			super.layoutChrome(w, h);
			if (border) {
				var borderY:Number = titleBar.y + Math.round(titleBar.height / 2);
				var borderH:Number = Math.max(0, h - borderY);
				border.move(0, borderY);
				border.setActualSize(w, borderH);
			}
			if (extraTitleBarButtons.length > 0) {
				var btnWidth:Number = 0;
				var statusRight:Number = statusTextField.x + statusTextField.width;
				var statusTop:Number = statusTextField.y;
				var statusHeight:Number = statusTextField.height;
	    		for each (var btn:UIComponent in extraTitleBarButtons) {
	    			btnWidth += btn.width + 2;
	    			var by:Number = statusTop + ((statusHeight - btn.height) / 2)
	    			btn.move(statusRight - btnWidth, by);
	    		}
    			btnWidth += 4;
				statusTextField.move(Math.max(0, statusTextField.x - btnWidth), statusTextField.y);
			}
		}
		
		/**
		 * Draws the background first, then the border.
		 */
		protected function drawBorderAndBackground(w:Number, h:Number):void {
			if (border) {
				// collect the styles for the background and border
				var bgAlpha:Number = getNumberStyle("backgroundAlpha", 0);
				var bgColor:Number = uint(getNumberStyle("backgroundColor", 0xffffff));
				var borderThickness:int = getNumberStyle("borderThickness", 1);
				var borderColor:uint = uint(getNumberStyle("borderColor", 0x0));
				var borderAlpha:Number = getNumberStyle("borderAlpha", 1);
				var cornerRadius:uint = uint(getNumberStyle("cornerRadius", 0));
				var roundedBottomCorners:Boolean = (getStyle("roundedBottomCorners") != false);

				var borderW:Number = w - borderThickness;
				var borderH:Number = border.height - borderThickness;

				var g:Graphics = (border as Border).graphics;
				g.clear();
				
				// draw the background first
				if ((bgAlpha > 0) && (bgAlpha <= 1)) {
					g.lineStyle(0, 0, 0, true);
					g.beginFill(bgColor, bgAlpha);
					drawBackground(g, borderW, borderH, cornerRadius, roundedBottomCorners);
					g.endFill();
				}
				
				// draw the border
				if ((borderThickness > 0) && (borderAlpha > 0) && (borderAlpha <= 1) && (borderH > 0)) {
					g.lineStyle(borderThickness, borderColor, borderAlpha, true);
					drawBorder(g, borderW, borderH, cornerRadius, roundedBottomCorners);
				}
			}
		}
		
		/**
		 * Draws the background taking into account the cornerRadius and roundedBottomCorners.
		 */
		protected function drawBackground(g:Graphics, borderW:Number, borderH:Number,
							cornerRadius:Number, roundedBottomCorners:Boolean):void {
			if (cornerRadius > 0) {
				if (roundedBottomCorners) {
					g.drawRoundRect(0, 0, borderW, borderH, cornerRadius*2, cornerRadius*2);
				} else {
					g.drawRoundRectComplex(0, 0, borderW, borderH, cornerRadius, cornerRadius, 0, 0);
				}
			} else {
				g.drawRect(0, 0, borderW, borderH); 
			}
		}
		
		/**
		 * Draws the border around the box, taking into account the corner radius and roundedBottomCorners.
		 */
		protected function drawBorder(g:Graphics, borderW:Number, borderH:Number,
					cornerRadius:Number, roundedBottomCorners:Boolean):void {
			
			// find the x locations for the title icon, title, status, and close buttons
			// many of these might not be visible
			// var offfsets:Array = findOffsets();
			
			// find the bounds of all the titlebar's visible children
			var offsets:Array = findTitleBarChildBounds();

			if ((cornerRadius == 0) || (borderH < cornerRadius) || (borderW < cornerRadius)) {
				if (offsets.length == 0) {
					g.drawRect(0, 0, borderW, borderH);
				} else {
					g.moveTo(0, 0);
					g.lineTo(0, borderH);
					g.lineTo(borderW, borderH);
					g.lineTo(borderW, 0);
				}
			} else {
				if (offsets.length == 0) {
					if (roundedBottomCorners) {
						g.drawRoundRect(0, 0, borderW, borderH, 2*cornerRadius, 2*cornerRadius);
					} else {
						g.drawRoundRectComplex(0, 0, borderW, borderH, cornerRadius, cornerRadius, 0, 0);
					}
				} else {
					var leftOffset:Number = Rectangle(offsets[0]).x;
					var rightOffset:Number = Rectangle(offsets[offsets.length - 1]).right;
					g.moveTo(leftOffset, 0);
					if (cornerRadius < leftOffset) {
						g.lineTo(cornerRadius, 0);
					}
					g.curveTo(0, 0, 0, cornerRadius);
					if (roundedBottomCorners) {
						g.lineTo(0, borderH - cornerRadius);
						g.curveTo(0, borderH, cornerRadius, borderH);
						g.lineTo(borderW - cornerRadius, borderH);
						g.curveTo(borderW, borderH, borderW, borderH - cornerRadius);
					} else {
						g.lineTo(0, borderH);
						g.lineTo(borderW, borderH);
					}
					g.lineTo(borderW, cornerRadius);
					g.curveTo(borderW, 0, borderW - Math.min(cornerRadius, (borderW - rightOffset)), 0);
					if (cornerRadius < (borderW - rightOffset)) {
						g.lineTo(rightOffset, 0);
					}
				}
			}
			// draw the border between the titlebar children (icon, title, status, close button, etc)
			if (offsets.length > 0) {
				g.moveTo(cornerRadius, 0);
				var current:Number = cornerRadius;
				var right:Number = borderW - cornerRadius;
				const gap:int = 4;
				for each (var r:Rectangle in offsets) {
					var dx:Number = r.x - current;
					if (dx > gap) {
						g.lineTo(r.x, 0);
					}
					current = r.right;
					g.moveTo(current, 0);
					if (current >= right) {
						break;
					}
				}
				if ((current + gap) < right) {
					g.lineTo(right, 0);
				}
			}						
		}
		
		/**
		 * Iterates through all the children of the titleBar and adds their bounds to an Array.
		 * Each child must be visible, and if the child is a TextField then it must have text.
		 * The children bounds are sorted so that the left most children come first in the Array.
		 * @return Array of Rectangle objects
		 */
		protected function findTitleBarChildBounds():Array {
			var bounds:Array = [];
			var r:Rectangle;
			// add the title icon first - it is not a UIComponent or a TextField
			var titleIconObj:DisplayObject = DisplayObject(titleIconObject); 
			if (titleIconObj && titleIconObj.visible) {
				r = new Rectangle(titleIconObj.x, titleIconObj.y, titleIconObj.width, titleIconObj.height);
				bounds.push(r);
			}

			for (var i:int = 0; i < titleBar.numChildren; i++) {
				var child:DisplayObject = titleBar.getChildAt(i);
				if (child.visible && ((child is UIComponent) || (child is TextField)) && (child != titleIconObj)) {
					r = null;
					if (child is TextField) {
						var tf:TextField = (child as TextField);
						// only add the textfield if it has text
						if (tf.text.length > 0) {
							var tw:Number = Math.min(tf.textWidth + 3, tf.width);
							if (tw > 0) {
								r = new Rectangle(tf.x, tf.y, tw, tf.height);
							}
						}
					} else if (child.width > 0) {
						r = new Rectangle(child.x, child.y, child.width, child.height);
					}
					if (r) {
						bounds.push(r);
					}
				}
			}
			
			// sort the bounds by x value (left to right)
			bounds.sort(function(r1:Rectangle, r2:Rectangle):int {
				if (r1.x < r2.x) return -1;
				if (r1.x > r2.x) return 1;
				if (r1.width > r2.width) return -1;
				if (r1.width < r2.width) return 1;
				return 0;
			});
			
			return bounds;
		}
		
		protected function getNumberStyle(styleName:String, defaultValue:Number):Number {
			var num:Number = getStyle(styleName);
			if (isNaN(num)) {
				num = defaultValue;
			}
			return num;
		}
		
	}
}