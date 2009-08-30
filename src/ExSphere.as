package
{
	import away3dlite.materials.*;
	import away3dlite.primitives.*;
	import away3dlite.templates.*;

	[SWF(backgroundColor="#000000", frameRate="30", quality="MEDIUM", width="800", height="600")]
	/**
	 * Example : Sphere
	 * @author katopz
	 */
	public class ExSphere extends FastTemplate
	{
		override protected function onInit():void
		{
			/*
				Test with single core, quality MEDIUM, at 30/30FPS steady
				BasicRenderer = 59x59 segments = 6,844 faces
				FastRenderer  = 60x60 segments = 7,080 faces
			*/
			var segments:uint = 59;
			
			title += " : Sphere "+segments+"x"+segments+" segments"; 

			// #1 away3d
			var sphere:Sphere = new Sphere({radius:100, segmentsW:segments, segmentsH:segments, material:new BitmapFileMaterial("assets/earth.jpg")});
			
			// #2 other engine
			//var sphere:Sphere = new Sphere().create(new BitmapFileMaterial("assets/earth.jpg"), 100, segments, segments);

			// #3 native
			/*
			var sphere:Sphere = new Sphere();
			sphere.radius = 100;
			sphere.segmentsW = sphere.segmentsH = segments;
			sphere.material = new BitmapFileMaterial("assets/earth.jpg");
			*/
			
			// #4
			//var sphere:Sphere = new Sphere().init({radius:100, segmentsW:segments, segmentsH:segments, material:new BitmapFileMaterial("assets/earth.jpg")});

			// #5 error test 
			//var sphere:Sphere = new Sphere().init({wtf:100, segmentsW:segments, segmentsH:segments, material:new BitmapFileMaterial("assets/earth.jpg")});

			scene.addChild(sphere);
		}

		override protected function onPreRender():void
		{
			scene.rotationY += 0.2;
		}
	}
}