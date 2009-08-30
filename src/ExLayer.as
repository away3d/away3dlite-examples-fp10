package
{
	import away3dlite.containers.Layer;
	import away3dlite.materials.*;
	import away3dlite.primitives.*;
	import away3dlite.templates.*;
	
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;

	[SWF(backgroundColor="#000000", frameRate="30", quality="MEDIUM", width="800", height="600")]
	/**
	 * Example : Layer
	 * @author katopz
	 */
	public class ExLayer extends FastTemplate
	{
		override protected function onInit():void
		{
			title += " : Layer, 3rd plane always on top, Click 2nd, 3rd plane to change filters"; 
			
			for(var i:int=0;i<4;i++)
			{
				var plane:Plane = new Plane().create(new BitmapFileMaterial("assets/earth.jpg"), 256, 128);
				plane.yUp = false;
				plane.bothsides = true;
				plane.rotationX = 30;
				plane.y = i*50;
				scene.addChild(plane);
				
				// separates by Layer
				var layer:Layer = new Layer();
				addChild(layer);
				plane.layer = layer;
				plane.layer.addEventListener(MouseEvent.CLICK, onClick);
			}
		}
		
		private function onClick(event:MouseEvent):void
		{
			trace("! onClick : " +event);
			
			var layer:Layer = event.target as Layer;
			
			if(layer.filters.length==0)
			{
				layer.filters = [new GlowFilter(0xFF0000, 1, 4, 4, 16, 1)];
			}else{
				layer.filters = null;
			}
		}
		
		override protected function onPreRender():void
		{
			scene.rotationY++;
		}
	}
}