package
{
	import away3dlite.materials.*;
	import away3dlite.primitives.*;
	import away3dlite.templates.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;

	[SWF(backgroundColor="#000000", frameRate="30", quality="MEDIUM", width="800", height="600")]
	/**
	 * Example : Layer
	 * @author katopz
	 */
	public class ExLayer extends BasicTemplate
	{
    	//signature swf
    	[Embed(source="assets/signature_lite_katopz.swf", symbol="Signature")]
    	private var SignatureSwf:Class;
		
		//signature variables
		private var Signature:Sprite;
		private var SignatureBitmap:Bitmap;
		
		private function onClick(event:MouseEvent):void
		{
			trace("! onClick : " +event);
			
			var layer:Sprite = event.target as Sprite;
			
			if(layer.filters.length==0)
				layer.filters = [new GlowFilter(0xFF0000, 1, 4, 4, 16, 1)];
			else
				layer.filters = null;
		}
		
		override protected function onInit():void
		{
			title += " : Layer, Click plane to change filters"; 
			
			// index layer
			var plane:Plane;
			for(var i:int=0;i<4;i++)
			{
				// Plane
				plane = new Plane(new BitmapFileMaterial("assets/earth.jpg"), 256, 128,1,1);
				plane.bothsides = true;
				plane.rotationX = 45;
				plane.y = i*50 - 4*50/2;
				scene.addChild(plane);
				
				// Layer
				var layer:Sprite = new Sprite();
				layer.name = String(i);
				view.addChild(layer);
				plane.layer = layer;
				
				// Event
				plane.layer.addEventListener(MouseEvent.CLICK, onClick);
			}
			
			// no layer test
			var earth:Sphere = new Sphere(new BitmapFileMaterial("assets/earth.jpg"), 100, 10, 10);
			scene.addChild(earth);
			
			// on top layer
			var moon:Sphere = new Sphere(new BitmapFileMaterial("assets/moon.jpg"), 25, 10, 10);
			scene.addChild(moon);
			moon.layer = new Sprite();
			view.addChild(moon.layer);
			
			// test filters
			moon.layer.filters = [new GlowFilter(0xFFFF00, 1, 4, 4, 16, 1)];
			
			//add signature
            Signature = Sprite(new SignatureSwf());
            SignatureBitmap = new Bitmap(new BitmapData(Signature.width, Signature.height, true, 0));
            SignatureBitmap.y = stage.stageHeight - Signature.height;
            stage.quality = StageQuality.HIGH;
            SignatureBitmap.bitmapData.draw(Signature);
            stage.quality = StageQuality.MEDIUM;
			addChild(SignatureBitmap);
		}
		
		
		/**
		 * @inheritDoc
		 */
		override protected function onPreRender():void
		{
			scene.rotationY++;
		}
	}
}