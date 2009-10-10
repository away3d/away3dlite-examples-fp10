package
{
	import flash.geom.Matrix;
	import away3dlite.core.utils.Cast;
	import away3dlite.materials.*;
	import away3dlite.primitives.*;
	import away3dlite.sprites.Sprite3D;
	import away3dlite.templates.*;
	
	import flash.display.*;
	import flash.events.*;

	[SWF(backgroundColor="#000000", frameRate="60", quality="MEDIUM", width="800", height="600")]
	/**
	 * Sprite3D Example
	 * @author katopz
	 */
	public class ExSprite3D extends BasicTemplate
	{
		[Embed(source="assets/green.jpg")]
		public var Green:Class;
		
		private var material:BitmapMaterial;
		
		private const radius:uint = 200;
		private const max:int = 2000;
		private const size:uint = 10;

		private const numFrames:uint = 30;

		private var step:Number = 0;
		private var segment:Number;
		 
		override protected function onInit():void
		{
			title = "Away3DLite | Sprite3D " + max + " | ";

			// speed up
			view.mouseEnabled = false;

			segment = (size+5) + 2*Math.PI/size;
			
			var shape:Shape = new Shape();
			drawDot(shape.graphics, size / 2, size / 2, size / 2, 0x000000, 0xFFFFFF);
			var bitmap:BitmapData = new BitmapData(size + 2, size + 2, true, 0x00FFFFFF);
			bitmap.draw(shape, new Matrix(1, 0, 0, 1, 1, 1), null, null, null, true);
			material = new BitmapMaterial(bitmap);
			material.repeat = false;
			var i:Number = 0;
			for (var j:int = 0; j < max; j++)
			{
				var sprite3D:Sprite3D = new Sprite3D(material)
				sprite3D.width = sprite3D.height = size;
				sprite3D.x = radius * Math.cos(segment * j);
				sprite3D.y = 0.25 * (-max / 2) + i;
				sprite3D.z = radius * Math.sin(segment * j);
				scene.addSprite(sprite3D);
				i += 0.25;
			}

			// center
			scene.addChild(new Sphere(null, 100, 6, 6));

			// orbit
			for (j = 0; j < 6; j++)
			{
				var sphere:Sphere = new Sphere(null, 25, 6, 6);
				scene.addChild(sphere);
				sphere.x = (radius + 50) * Math.cos(i);
				sphere.z = (radius + 50) * Math.sin(i);
				i += 2 * Math.PI / 6;
			}
		}
		
		private function drawDot(_graphics:Graphics, x:Number, y:Number, size:Number, colorLight:uint, colorDark:uint):void
		{
			var colors:Array = [colorLight, colorDark, colorLight];
			var alphas:Array = [1.0, 1.0, 1.0];
			var ratios:Array = [0, 200, 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(size * 2, size * 2, 0, x - size, y - size);

			_graphics.lineStyle();
			_graphics.beginGradientFill(GradientType.RADIAL, colors, alphas, ratios, matrix);
			_graphics.drawCircle(x, y, size);
			_graphics.endFill();
		}
		
		override protected function onPreRender():void
		{
			//scene.rotationX += .5;
			scene.rotationY += .5;
			//scene.rotationZ += .5;

			//camera.x = 1000 * Math.cos(step);
			//camera.y = 10 * (300 - mouseY);
			//camera.z = 1000 * Math.sin(step);
			//camera.lookAt(new Vector3D(0, 0, 0));
			
			//step += .01
		}
	}
}