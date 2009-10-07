package
{
	import away3dlite.materials.*;
	import away3dlite.primitives.*;
	import away3dlite.templates.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.geom.Vector3D;

	[SWF(backgroundColor="#000000",frameRate="30",quality="MEDIUM",width="800",height="600")]
	/**
	 * Canvas Example
	 * @author katopz
	 */
	public class ExCanvas extends BasicTemplate
	{
		private var step:Number = 0;
		
		override protected function onInit():void
		{
			// it's off for speed via BasicRenderer, make it true it when you need to sort canvas
			renderer.sortObjects = true;
			
			// center (canvas = null), so no sort with objects here
			scene.addChild(new Sphere(null, 100, 6, 6));
			
			// canvas with Filters
			var sphere1:Sphere = scene.addChild(new Sphere(null, 50, 6, 6)) as Sphere;
			sphere1.x = 150;
			sphere1.canvas = view.addChild(new Sprite()) as Sprite;
			sphere1.canvas.filters = [new GlowFilter(0xFF0000,1,16,16,2)];

			// canvas with Filters + BlendMode
			var sphere2:Sphere = scene.addChild(new Sphere(null, 50, 6, 6)) as Sphere;
			sphere2.x = -150;
			sphere2.canvas = view.addChild(new Sprite()) as Sprite;
			sphere2.canvas.filters = [new GlowFilter(0xFF0000,1,16,16,2)];
			sphere2.canvas.blendMode = BlendMode.ADD;
			
			// orbit canvas
			var i:int = 0;
			for (var j:int = 0; j < 6; j++)
			{
				var _sphere:Sphere = new Sphere(null, 25, 6, 6);
				_sphere.canvas = view.addChild(new Sprite()) as Sprite;
				_sphere.canvas.filters = [new GlowFilter(0xFFFFFF/2+0xFFFFFF*Math.random()/2,1,16,16,2)];
				scene.addChild(_sphere);
				_sphere.x = (300) * Math.cos(i);
				_sphere.z = (300) * Math.sin(i);
				i += 2 * Math.PI / 6;
			}

			// canvas test
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}

		private function onClick(event:MouseEvent):void
		{
			renderer.sortObjects = !renderer.sortObjects;
		}
		
		override protected function onPreRender():void
		{
			title = "Away3DLite | Canvas | Click to toggle sort object ("+ renderer.sortObjects + ") | (center sphere is not sort, no canvas)";
			
			scene.rotationX += .5;
			scene.rotationY += .5;
			scene.rotationZ += .5;

			camera.x = 1000 * Math.cos(step);
			camera.y = 10 * (300 - mouseY);
			camera.z = 1000 * Math.sin(step);
			camera.lookAt(new Vector3D(0, 0, 0));
			
			step += .01;
		}
	}
}