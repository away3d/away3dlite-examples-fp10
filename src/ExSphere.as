package
{
	import away3dlite.materials.*;
	import away3dlite.primitives.*;
	import away3dlite.templates.*;
	
	import flash.display.StageQuality;

	[SWF(backgroundColor="#000000", frameRate="30", quality="MEDIUM", width="800", height="600")]
	/**
	 * Example : Sphere
	 * @author katopz
	 */
	public class ExSphere extends FastTemplate
	{
		/*
			Test with quality MEDIUM, at 30/30FPS steady
			--------------------------------------------
			[Single Core]
				BasicRenderer = 59x59 segments = 6,844 faces
				FastRenderer  = 60x60 segments = 7,080 faces
				
			[Quad Core]
				BasicRenderer = 100x100 segments = 19,800 faces
				FastRenderer  = 101x101 segments = 20,200 faces
		*/
		
		private var sphere:Sphere;
		
		override protected function onInit():void
		{
			var segments:uint = 100;
			
			title += " : Sphere "+segments+"x"+segments+" segments";
			
			sphere = new Sphere(100, segments, segments);
			sphere.material = new BitmapFileMaterial("assets/earth.jpg");
			scene.addChild(sphere);
			
			scene.mouseEnabled = false;
		}

		override protected function onPreRender():void
		{
			sphere.rotationY++;
		}
	}
}