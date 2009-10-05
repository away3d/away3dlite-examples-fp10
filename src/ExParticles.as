package
{
	import away3dlite.containers.Particles;
	import away3dlite.core.base.Particle;
	import away3dlite.materials.*;
	import away3dlite.primitives.*;
	import away3dlite.templates.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix;
	import flash.geom.Vector3D;

	[SWF(backgroundColor="#000000",frameRate="30",quality="MEDIUM",width="800",height="600")]
	/**
	 * Particles Example
	 * @author katopz
	 */
	public class ExParticles extends BasicTemplate
	{
		private var particles:Particles;
		private var materials:ParticleMaterial;

		private const radius:uint = 200;
		private const max:int = 1000;
		private const size:uint = 10;

		private const numFrames:uint = 30;

		private var step:Number = 0;
		private var segment:Number;
		 
		override protected function onInit():void
		{
			title = "Away3DLite | Particles : " + max + " | Click to toggle Particles Layer + BlendMode.INVERT | ";

			// speed up
			view.mouseEnabled = false;

			// create materials
			materials = createMaterial();

			// create particles
			particles = new Particles(true);

			segment = size + 2 * Math.PI / (size * 1.25);

			var i:Number = 0;
			for (var j:int = 0; j < max; j++)
			{
				particles.addParticle(new Particle(radius * Math.cos(segment * j), 0.5 * (-max / 2) + i, radius * Math.sin(segment * j), materials));
				i += 0.5;
			}

			scene.addChild(particles);

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

			// layer test
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}

		private function createMaterial():ParticleMaterial
		{
			var _materials:ParticleMaterial = new ParticleMaterial();

			for (var i:int = 0; i < numFrames; i++)
			{
				var shape:Shape = new Shape();
				drawDot(shape.graphics, size / 2, size / 2, size / 2, 0xFFFFFF - 0xFFFFFF * Math.sin(Math.PI * i / 30), 0xFFFFFF);

				var bitmapData:BitmapData = new BitmapData(size, size, true, 0x00000000);
				bitmapData.draw(shape);

				_materials.addFrame(bitmapData);
			}

			return _materials;
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

		private function onClick(event:MouseEvent):void
		{
			if (!particles.layer)
			{
				particles.layer = new Sprite();
				particles.layer.blendMode = BlendMode.INVERT;
				view.addChild(particles.layer);
			}
			else
			{
				view.removeChild(particles.layer);
				particles.layer = null;
			}
		}
		
		override protected function onPostRender():void
		{
			scene.rotationX += .5;
			scene.rotationY += .5;
			scene.rotationZ += .5;

			camera.x = 1000 * Math.cos(step);
			camera.y = 10 * (300 - mouseY);
			camera.z = 1000 * Math.sin(step);
			camera.lookAt(new Vector3D(0, 0, 0));
			
			step += .01
		}
	}
}