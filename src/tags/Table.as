package tags
{
	import components.InputLabel;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFormatAlign;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.containers.Grid;
	import mx.containers.GridItem;
	import mx.containers.GridRow;
	import mx.controls.Alert;
	import mx.controls.Label;
	import mx.controls.TextInput;
	import mx.events.FlexEvent;
	import mx.managers.CursorManager;
	import mx.states.Transition;
	
	import spark.components.TextArea;
	
	import tools.TableTool;
	
	public class Table extends Grid
	{
		private var _rows:int;
		private var _cols:int;
		private var _drawflag:Boolean;
		private var drawStartPoint:Point;
		private var drawEndPoint:Point;
		private var aPoint:Point;
		private var bPoint:Point;
		public var selectedTd:Array;
		public var maxRowSpan:int;
		public var maxColSpan:int;
		
		private var startSelectedRowIndex:int=-1;
		private var endSelectedRowIndex:int=-1;
		private var startSelectedColIndex:int=-1;
		private var endSelectedColIndex:int=-1;
		
		public var maxSelectedWidth:int;
		private var maxSelectedHeight:int;
		private var canvas:Canvas;
		private var tableTool :TableTool;
		private var _htmlDesign:Canvas;
		private var _tableId:String;
		private var _selectedTdOne:Td;
		private var _isDataGrid:Boolean;
		private var _source:String;
		public function Table(rows:int,cols:int)
		{
			super();
			this._rows=rows;
			this._cols=cols;
			this.init();
			this.event();
			
		}
		/**
		 * 初始化面板时动作
		 * */
		private function init():void{
			var tr:Tr;
			for(var i:int=0;i<rows;i++){
				tr = new Tr();
				tr.height=30;
				for(var n:int=0;n<cols;n++){
					//addTd(tr);
					var td:Td = tr.addTd();
					tdEvent(td);
				}
				this.addChild(tr);
			}
		}
		//添加面板
		private function addLabel(td:Td):void{
			/*var label:InputLabel;
			label = new InputLabel();
			label.text="123";
			label.width=100;
			label.height=23;
			canvas.addChild(label);*/
		}
		//添加事件
		private function event():void{
			var me:Table=this;
			this.addEventListener(MouseEvent.MOUSE_DOWN,function(event:MouseEvent):void{
				drawflag=true;
			});
			this.addEventListener(MouseEvent.MOUSE_UP,function(event:MouseEvent):void{
				drawflag=false;
			});;
			/*this.addEventListener(MouseEvent.MOUSE_OVER,function(event:MouseEvent):void{
				//drawTools(event);
			});
			this.addEventListener(MouseEvent.MOUSE_OUT,function(event:MouseEvent):void{
				//removeTools(event);
			});*/
			
			this.addEventListener(FlexEvent.UPDATE_COMPLETE,function():void{
				
				//改变父TD尺寸
				changeTdWH(me);
			});
		}
		
		//改变尺寸
		private function changeTdWH(table:Table):void{
			if(table.parent.parent is Td){
				var td:Td = table.parent.parent as Td;
				var tr:Tr = table.parent.parent.parent as Tr;
				if(td.width<table.width+table.x){
					td.width = table.width+table.x+20;
				}
				if(tr.height<table.height+table.y){
					tr.height = table.height+table.y+20;
				}
				this.changeTdWH(td.parent.parent as Table);
			}
			
		}
		
		/**
		 * 列事件
		 * */
		public function tdEvent(td:Td):void{
			
			td.addEventListener(MouseEvent.MOUSE_DOWN,function(event:MouseEvent):void{
				drawStartPoint = new Point(td.x,td.parent.y);
				clearSelected();
				td.setStyle("backgroundColor","gray");
				selectedTdOne = td;
			});
			td.addEventListener(MouseEvent.MOUSE_MOVE,function(event:MouseEvent):void{
				drawEndPoint = new Point(td.x,td.parent.y);
				if(drawflag){
					drawSelected();
				}
			});
			
		}
		
		private function drawSelected():void{
			if(bPoint==null){
				
				aPoint = drawStartPoint;
				bPoint = drawEndPoint;
				if(drawStartPoint==null){
					return;
				}
				if(drawStartPoint.x>drawEndPoint.x ||  drawStartPoint.y>drawEndPoint.y){
					aPoint = drawEndPoint;
					bPoint = drawStartPoint;
				}
				
				if(drawStartPoint.x>drawEndPoint.x && drawStartPoint.y<drawEndPoint.y){
					aPoint = new Point(drawEndPoint.x,drawStartPoint.y);
					bPoint = new Point(drawStartPoint.x,drawEndPoint.y);
				}
				
				if(drawStartPoint.x<drawEndPoint.x && drawStartPoint.y>drawEndPoint.y){
					aPoint =new Point(drawStartPoint.x,drawEndPoint.y);
					bPoint =  new Point(drawEndPoint.x,drawStartPoint.y);
				}
			}
			var tr:Tr ;
			var td:Td ;
			selectedTd = new Array();
			maxSelectedWidth=0;
			maxRowSpan=0;
			var trChangeFlag:Boolean;
			var tdWidth:Number=0;
			startSelectedRowIndex=-1;
			endSelectedRowIndex=-1;
			startSelectedColIndex=-1;
			endSelectedColIndex=-1;
			var cols:int;
			var firstS:Boolean=true;
			for(var i:int=0;i<this.numChildren;i++){
				tr = this.getChildAt(i) as Tr;
				trChangeFlag=true;
				tdWidth=0;
				cols=0;
				for(var n:int=0;n<tr.numChildren;n++){
					td = tr.getChildAt(n) as Td;
					if(td!=null){
						
						if(td.backgroundColor==null || td.backgroundColor=="null"|| td.backgroundColor==""){			
							td.setStyle("backgroundColor","white");
						}else{				
							td.setStyle("backgroundColor",td.backgroundColor);
						}
						cols += td.colSpan;
						if(aPoint!=null && bPoint!=null && aPoint.x+aPoint.y!=bPoint.x+bPoint.y){
							
							
							if(td.x<aPoint.x && td.x+td.width-3>=aPoint.x  && tr.y>=aPoint.y  && tr.y<=bPoint.y){
								aPoint.x = td.x;
								this.drawSelected();
								return;
							}
							//
							//trace(aPoint.y+"---"+tr.y)
							if(aPoint.y>tr.y && aPoint.x<=td.x && bPoint.x>=td.x &&  aPoint.y<tr.y+td.height-3 && bPoint.y>=tr.y+td.height-3){
								aPoint.y = tr.y;
								this.drawSelected();
								return;
							}
							
							if(tr.y<=aPoint.y && aPoint.x<=td.x && bPoint.x>=td.x && bPoint.y < tr.y+td.height-3){
								bPoint.y=tr.y+td.height-3;
								this.drawSelected();
								return;
							}
							if(td.x>=aPoint.x && tr.y>=aPoint.y && td.x<=bPoint.x && tr.y<=bPoint.y ){
								selectedTd[selectedTd.length]=td;
								td.setStyle("backgroundColor","gray");
								if(startSelectedRowIndex==-1){
									startSelectedRowIndex=i;
								}
								if(endSelectedRowIndex<i){
									endSelectedRowIndex=i+td.rowSpan-1;
								}
								if(firstS){
									var tmpCols:int = cols-td.colSpan+1;
									var tCols:int=0;
									var maxCols:int=0;
									for( var TRlen:int =0;TRlen<this.numChildren;TRlen++){
										var tmptr:Tr = this.getChildAt(TRlen) as Tr;
										tCols=0;
										for( var len:int =0;len<tmpCols;len++){
											try{
												
												var temtd:Td = tmptr.getChildAt(len) as Td;
												if(temtd.colSpan>1){
													tCols += temtd.colSpan;
												}
											}catch(e){
											}
										}
										if(maxCols<tCols){
											maxCols = tCols;
										}
									}
									cols+=maxCols; 
									startSelectedColIndex=cols-td.colSpan+1;
									firstS=false;
								}
								if(endSelectedColIndex==-1){
									endSelectedColIndex=cols;
								}
								if(endSelectedColIndex<cols){
									endSelectedColIndex=cols;
								}
								
								tdWidth +=td.width;
								
								
								
								if(aPoint.x>td.x){
									aPoint.x=td.x;
									this.drawSelected();
									return;
								}
								
								if(bPoint.x<td.x+td.width-3){
									bPoint.x=td.x+td.width-3;
									this.drawSelected();
									return;
								}	
								if(bPoint.y<tr.y+td.height-3){
									bPoint.y=tr.y+td.height-3;
									this.drawSelected();
									return;
								}
								
							}
						}
					}
					
				}
				
				if(maxSelectedWidth<tdWidth){
					maxSelectedWidth = tdWidth;
				}
			}
			//trace(startSelectedColIndex+"---"+endSelectedColIndex);
			maxColSpan = endSelectedColIndex-startSelectedColIndex+1;
			maxRowSpan = endSelectedRowIndex-startSelectedRowIndex+1;
			aPoint=null;
			bPoint=null;
		}
		private function clearSelected():void{
			try{
				selectedTd=new Array();
				var tr:Tr ;
				var td:Td ;
				for(var i:int=0;i<this.numChildren;i++){
					tr = this.getChildAt(i) as Tr;
					for(var n:int=0;n<tr.numChildren;n++){
						td = tr.getChildAt(n) as Td;
						if(td.backgroundColor==null || td.backgroundColor=="null"|| td.backgroundColor==""){	
							td.setStyle("backgroundColor","white");
						}else{
							td.setStyle("backgroundColor",td.backgroundColor);
						}
					}
				}
			}catch(e:*){
			}
		}
		//合并
		public function merge():void{
			if(selectedTd.length>0){
				var td:Td=selectedTd[0] as Td;
				//Alert.show(maxSelectedWidth+"--"+maxColSpan);
				td.rowSpan = maxRowSpan;
				td.width = maxSelectedWidth;
				td.colSpan = maxColSpan;
				var tr:Tr ;
				maxSelectedHeight=0;
				if(endSelectedRowIndex!=-1){
					for(var i:int=startSelectedRowIndex;i<=endSelectedRowIndex;i++){
						tr = this.getChildAt(i) as Tr;
						if(tr!=null){
							maxSelectedHeight += tr.height;
						}
					}
				}
				if(maxSelectedHeight>0){
					td.height = maxSelectedHeight-td.rowSpan;
				}
				for(var i:int=1;i<selectedTd.length;i++){
					selectedTd[i].parent.removeChild(selectedTd[i]);
				}
				selectedTd=new Array();
				this.clearSelected();
			}
		}
		//拆分单元格
		public function split(tdSplitcell:Td):void{
			try{
				if(tdSplitcell!=null){
					var girdrow:Tr ;
					var girditem:Td ;
					//var addgriditem:GridItem;
					for(var i:int=0;i<numChildren;i++){
						girdrow = this.getChildAt(i) as Tr;
						for(var n:int=0;n<girdrow.numChildren;n++){
							girditem =  girdrow.getChildAt(n) as Td;
							if(girditem==tdSplitcell){
								
								for(var j:int=0;j<girditem.rowSpan;j++){
									for(var k:int=0;k<girditem.colSpan;k++){
										var tr:Tr = this.getChildAt(j+i) as Tr
										var td:Td = tr.addTd(k+n); 
										tdEvent(td);
										//addTd(this.getChildAt(j+i) as Tr,k+n);
										
									}
									
								}
								girdrow.removeChild(girditem);
								//selectedTdOne= null;
								return;
							}
						}
					}
				}
			
			}catch(e:*){
			}
		}
		private function getTdMaxHeight(tr:Tr):Number{
			var height:Number=0;
			for(var i:int=0;i<tr.numChildren;i++){
				if(height<tr.getChildAt(i).height){
					height=tr.getChildAt(i).height;
				}
			}
			return height;
		}
		//插入行
		public function addRowFun(event:MouseEvent):void{
			if(selectedTdOne==null || selectedTdOne.parent==null){
				return;
			}
			
			var upData:ArrayCollection = new ArrayCollection();
			var downData:ArrayCollection = new ArrayCollection();
			var maxTdCount:Number=0
			for(var i:int=0;i<numChildren;i++){
				var tr:Tr = this.getChildAt(i) as Tr; 
				for(var n:int=0;n<tr.numChildren;n++){
					var td:Td=tr.getChildAt(n) as Td;
					if(n+td.colSpan>maxTdCount){
						maxTdCount=n+td.colSpan;
					}
					if(tr.y==selectedTdOne.parent.y
						|| (tr.y<selectedTdOne.parent.y && tr.y+td.height-1>selectedTdOne.parent.y) 
					){
						upData.addItem({td:td,trIndex:i,tdIndex:n,newflag:tr.y==selectedTdOne.parent.y});
						
					}
					if(tr.y==selectedTdOne.parent.y+selectedTdOne.height-1
						|| (tr.y<selectedTdOne.parent.y+selectedTdOne.height-1 && tr.y+td.height-1>selectedTdOne.parent.y+selectedTdOne.height-1) 
					){
						downData.addItem({td:td,trIndex:i,tdIndex:n,newflag:tr.y==selectedTdOne.parent.y+selectedTdOne.height-1});
					}
				}
			}
			if(event.target.parent.id=="addrowup"){
				var tr:Tr ;		
				var trAddFlag:Boolean=false;
				for(var i:int=0;i<upData.length;i++){
					
					
					try{
						trace("upData:rowSpan:"+(upData[i].td as Td).rowSpan+"-colSpan:"+(upData[i].td as Td).colSpan +"-trIndex:"+upData[i].trIndex+"-tdIndex"+upData[i].tdIndex+"-newflag:"+upData[i].newflag);
						if(upData[i].newflag){		
							if(!trAddFlag){
								tr = new Tr();
								tr.height=30;
								this.addChildAt(tr,upData[i].trIndex);
								trAddFlag=true;
							} 
							var td:Td = tr.addTd(upData[i].tdIndex); 
							td.colSpan = (upData[i].td as Td).colSpan
							this.split(td);
							tdEvent(td);
						}else{
							var td:Td = upData[i].td as Td;
							td.rowSpan++;
						}
					}catch(e:*){
					}
				}
			}
			if(event.target.parent.id=="addrowdown"){
				var tr:Tr ;		
				var trAddFlag:Boolean=false;
				for(var i:int=0;i<downData.length;i++){
					
					
					try{
						trace("downData:rowSpan:"+(downData[i].td as Td).rowSpan+"-colSpan:"+(downData[i].td as Td).colSpan +"-trIndex:"+downData[i].trIndex+"-tdIndex"+downData[i].tdIndex+"-newflag:"+downData[i].newflag);
						if(downData[i].newflag){
							
							if(!trAddFlag){
								tr = new Tr();
								tr.height=30;
								this.addChildAt(tr,downData[i].trIndex);
								trAddFlag=true;
							}
							var td:Td = tr.addTd(downData[i].tdIndex); 
							td.colSpan = (downData[i].td as Td).colSpan;
							this.split(td);
							tdEvent(td);
						}else{
							var td:Td = downData[i].td as Td;
							td.rowSpan++;
						}
					}catch(e:*){
					}
				}
				if(downData.length==0){
					
					tr = new Tr();
					tr.height=30;
					this.addChildAt(tr,this.numChildren);
					for(var i:int=0;i<maxTdCount;i++){
						var td:Td = tr.addTd(); 
						tdEvent(td);
					}
				}
			}
		}
		//插入列
		public function addCellFun(event:MouseEvent):void{
			if(selectedTdOne==null || selectedTdOne.parent==null){
				return;
			}
			var leftData:ArrayCollection = new ArrayCollection();
			var rightData:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<numChildren;i++){
				var tr:Tr = this.getChildAt(i) as Tr; 
				for(var n:int=0;n<tr.numChildren;n++){
					var td:Td=tr.getChildAt(n) as Td;
					if(td.x==selectedTdOne.x
						|| (td.x<selectedTdOne.x && td.x+td.width-1>selectedTdOne.x) 
					){
						leftData.addItem({td:td,trIndex:i,tdIndex:n,newflag:td.x==selectedTdOne.x});
						
					}
					if(td.x==selectedTdOne.x+selectedTdOne.width-1
						|| (td.x<selectedTdOne.x+selectedTdOne.width-1 && td.x+td.width-1>selectedTdOne.x+selectedTdOne.width-1) 
					){
						rightData.addItem({td:td,trIndex:i,tdIndex:n,newflag:td.x==selectedTdOne.x+selectedTdOne.width-1});
					}
				}
			}
			if(event.target.parent.id=="addcellleft"){
				for(var i:int=0;i<leftData.length;i++){
					try{
						
						trace("left:"+(leftData[i].td as Td).colSpan +"-"+leftData[i].trIndex+"-"+leftData[i].tdIndex+"-newflag:"+leftData[i].newflag);
						if(leftData[i].newflag){
							var tr:Tr = this.getChildAt(leftData[i].trIndex) as Tr; 
							var td:Td = tr.addTd(leftData[i].tdIndex); 
							td.rowSpan = (leftData[i].td as Td).rowSpan
							//this.split(td);
							tdEvent(td);
						}else{
							var td:Td = leftData[i].td as Td;
							td.colSpan++;
						}
					}catch(e:*){
					}
				}
			}
			if(event.target.parent.id=="addcellright"){
				for(var i:int=0;i<rightData.length;i++){
					try{
						trace("right:"+(rightData[i].td as Td).colSpan +"-"+rightData[i].trIndex+"-"+rightData[i].tdIndex+"-newflag:"+rightData[i].newflag);
						if(rightData[i].newflag){
							var tr:Tr = this.getChildAt(rightData[i].trIndex) as Tr; 
							var td:Td = tr.addTd(rightData[i].tdIndex+1); 
							td.rowSpan = (rightData[i].td as Td).rowSpan
							this.split(td);
							tdEvent(td);
						}else{
							var td:Td = rightData[i].td as Td;
							td.colSpan++;
						}
					}catch(e:*){
					}
				}
				if(rightData.length==0){
					for(var i:int=0;i<this.numChildren;i++){
						var tr:Tr = this.getChildAt(i) as Tr; 
						var td:Td = tr.addTd(); 
						tdEvent(td);
					}
				}
			}
			
		}
		//删除行
		public function RemoveRowFun(event:MouseEvent):void{
			
			if(selectedTdOne==null || selectedTdOne.parent==null){
				return;
			}
			
			var upData:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<numChildren;i++){
				var tr:Tr = this.getChildAt(i) as Tr; 
				for(var n:int=0;n<tr.numChildren;n++){
					var td:Td=tr.getChildAt(n) as Td;
					if(tr.y==selectedTdOne.parent.y
						|| (tr.y<selectedTdOne.parent.y && tr.y+td.height-1>selectedTdOne.parent.y) 
					){
						upData.addItem({td:td,trIndex:i,tdIndex:n,deleteflag:tr.y==selectedTdOne.parent.y});
						
					}
				}
			}
			var tr:Tr;
			for(var i:int=0;i<upData.length;i++){				
				try{
					var td:Td = upData[i].td as Td;
					if(upData[i].deleteflag){	
						tr = td.parent as Tr;
						td.parent.removeChild(td);
					}else{
						td.rowSpan--;
					}
				}catch(e:*){
				}
			}
			this.removeChild(tr);
		}
		//删除列
		public function RemoveCellFun(event:MouseEvent):void{
			
			if(selectedTdOne==null || selectedTdOne.parent==null){
				return;
			}
			var leftData:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<numChildren;i++){
				var tr:Tr = this.getChildAt(i) as Tr; 
				for(var n:int=0;n<tr.numChildren;n++){
					var td:Td=tr.getChildAt(n) as Td;
					if(td.x==selectedTdOne.x
						|| (td.x<selectedTdOne.x && td.x+td.width-1>selectedTdOne.x) 
					){
						leftData.addItem({td:td,trIndex:i,tdIndex:n,deleteflag:td.x==selectedTdOne.x});
						
					}
				}
			}
			for(var i:int=0;i<leftData.length;i++){
				try{
					var td:Td = leftData[i].td as Td;					
					if(leftData[i].deleteflag){
						td.parent.removeChild(td);
					}else{
						td.colSpan--;
					}
				}catch(e:*){
				}
			}
		}
		private function getTrTdIndex():Object{
			var obj:Object = new Object();
			for(var i:int=0;i<numChildren;i++){
				if(this.getChildAt(i) as Tr == selectedTdOne.parent as Tr){
					obj.trIndex = i;
				}
			}
			var tdCount:int=0;
			for(var i:int=0;i<(selectedTdOne.parent as Tr).numChildren;i++){
				var td:Td = (selectedTdOne.parent as Tr).getChildAt(i) as Td ;
				if(td== selectedTdOne){
					obj.tdIndex = tdCount;
				}
				tdCount +=td.colSpan;
			}
			obj.tdCount  = tdCount;
			return obj;
		}
		/**
		 * 工具箱
		 * **/
		private function drawTools(event:MouseEvent):void{
			if(tableTool==null ){
				tableTool  = new TableTool();
			}else{
				tableTool.ChangePoint(event);
			}
			if(this.selectedTd!=null && this.selectedTd.length>0){
				tableTool.mergecellBtnDisable=false;
			}else{				
				tableTool.mergecellBtnDisable=true;	
			}
			tableTool.table = this;
				
			tableTool.x = this.x;
			tableTool.y = this.y;
			//trace(this.y);
			this.parent.addChild(tableTool);
			/*}else if(!(event.target.parent.parent is TableTool) && !(event.target.parent is TableTool)){
				trace(obj);
				this.removeTools();
			}*/
		}
		/**
		 * 删除工具箱
		 * **/
		private function removeTools(event:MouseEvent):void{
			//移动时删除工具箱
			if(tableTool!=null){
				if(htmlDesign.getChildByName(tableTool.name)!=null){
					htmlDesign.removeChild(tableTool);
				}
			}
		}
		//设定属性
		public function setPropertie(pro:Object):void{
			var ui:String = pro.ui;
			var id:String = pro.id;
			var value:String = pro.value;
			if(ui=="table"){
				switch(id){
					case "id":
						this.tableId = value;
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
					case "isDataGrid":
						
						if(value=="true"){
							this.isDataGrid =true;
						}else{
							this.isDataGrid =false;
						}
						break;
					case "source":
						this.source =value;
						break;
					default:
						break;
				
				}
			}
			else if(ui=="tr"){
				var tr:Tr = selectedTdOne.parent as Tr;
				switch(id){
					case "id":
						tr.trId = value;
						break;
					case "width":
						//tr.width = new Number(value);
						break;
					case "height":
						tr.height = new Number(value);
						break;
					case "isDataGridDetail":
						if(value=="true"){
							tr.isDataGridDetail =true;
						}else{
							tr.isDataGridDetail =false;
						}
						break;
					default:
						break;
					
				}
			}
			else if(ui=="td"){
				var td:Td = selectedTdOne;
				switch(id){
					case "id":
						td.tdId = value;
						break;
					case "width":
						td.width = new Number(value);
						break;
					case "height":
						//td.height = new Number(value);
						break;
					default:
						break;
					
				}
			}
		}
		/**
		 * 设定颜色
		 * */
		public function set selectedTdColor(color:String):void{
			if(selectedTd!=null && selectedTd.length>0){
				for(var i:int=0;i<selectedTd.length;i++){
					var td:Td = selectedTd[i] as Td;
					td.backgroundColor = color;
				}
			}else if(selectedTdOne!=null){
				selectedTdOne.backgroundColor = color;
				
			}
			
		}
		override public function set width(value:Number):void{
			var addWidth:Number =value- width;
			if(this.numChildren>0){
				var tr:GridRow = this.getChildAt(0) as GridRow;
				if(this.horizontalScrollBar!=null){
					value = tr.width;
				}else{
					
					var t_width:Number = addWidth/tr.numChildren;
					if((t_width+"").split(".").length==1){
						for(var i=0;i<tr.numChildren;i++){
							var td:GridItem = tr.getChildAt(i) as GridItem;
							if( td.width+t_width>=0){
								td.width = td.width+t_width;
							}
						}
					}else{
						value= width;
					}
				}
				
			}
				
			super.measure();
			
		}
		override public function set height(value:Number):void{
			var addHeight:Number =value- height;
			
			if(this.numChildren>0){
				
				var t_height:Number = addHeight/this.numChildren;
				
				if((t_height+"").split(".").length==1){
					for(var i=0;i<this.numChildren;i++){
						var tr:GridRow = this.getChildAt(i) as GridRow;
						if(tr.height+t_height>=0){
							tr.height = tr.height+t_height;
						}
					}
				}else{
					
					value = height;
				}	
				
			}
			super.measure();
		}
		public function go_measure():void{
			
			super.measure();
		}
		public function get rows():int
		{
			return _rows;
		}
		
		public function set rows(value:int):void
		{
			_rows = value;
		}
		
		public function get cols():int
		{
			return _cols;
		}
		
		public function set cols(value:int):void
		{
			_cols = value;
		}
		
		public function get drawflag():Boolean
		{
			return _drawflag;
		}
		
		public function set drawflag(value:Boolean):void
		{
			_drawflag = value;
		}

		public function get htmlDesign():Canvas
		{
			return _htmlDesign;
		}

		public function set htmlDesign(value:Canvas):void
		{
			_htmlDesign = value;
		}

		public function get tableId():String
		{
			if(_tableId==null || _tableId==""){
				_tableId=this.name
			}
			return _tableId;
		}

		public function set tableId(value:String):void
		{
			_tableId = value;
		}

		public function get selectedTdOne():Td
		{
			return _selectedTdOne;
		}

		public function set selectedTdOne(value:Td):void
		{
			_selectedTdOne = value;
		}

		public function get isDataGrid():Boolean
		{
			return _isDataGrid;
		}

		public function set isDataGrid(value:Boolean):void
		{
			_isDataGrid = value;
		}

		public function get source():String
		{
			return _source==null?"":_source;
		}

		public function set source(value:String):void
		{
			_source = value;
		}
		
		
		
	}
}