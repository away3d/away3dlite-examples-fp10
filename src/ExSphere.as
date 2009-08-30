package
{
	import away3dlite.materials.*;
	import away3dlite.primitives.*;
	import away3dlite.templates.*;

	[SWF(backgroundColor="#000000", frameRate="30", quality="LOW", width="800", height="600")]
	/**
	 * Example : Sphere
	 * @author katopz
	 */
	public class ExSphere extends FastTemplate
	{
		override protected function onInit():void
		{
			// BasicRenderer via single core = 73 segments
			// FastRenderer via single core = 74 segments
			var segments:uint = 74;
			
			title += " : Sphere "+segments+"x"+segments+" segments"; 
			
			// #1 migrate from other engine
			//var sphere:Sphere = new Sphere().create(new BitmapFileMaterial("assets/earth.jpg"), 100, segments, segments);

			// #2 migrate from other away3d
			var sphere:Sphere = new Sphere({radius:100, segmentsW:segments, segmentsH:segments, material:new BitmapFileMaterial("assets/earth.jpg")});

			/* #3 native
			var sphere:Sphere = new Sphere();
			sphere.radius = 100;
			sphere.segmentsW = sphere.segmentsH = segments;
			sphere.material = new BitmapFileMaterial("assets/earth.jpg");
			*/
			
			// #4
			//var sphere:Sphere = new Sphere().init({radius:100, segmentsW:segments, segmentsH:segments, material:new BitmapFileMaterial("assets/earth.jpg")});

			// #5 error test 
			//var sphere:Sphere = new Sphere().init({wtf:100, segmentsW:segments, segmentsH:segments, material:new BitmapFileMaterial("assets/earth.jpg")});

			view.scene.addChild(sphere);
		}

		override protected function onPreRender():void
		{
			view.scene.rotationY += 0.2;
		}
	}
}