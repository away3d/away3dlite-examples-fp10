package
{
	import away3dlite.materials.*;
	import away3dlite.primitives.*;
	import away3dlite.templates.*;

	[SWF(backgroundColor="#000000", frameRate="30", quality="MEDIUM", width="800", height="600")]
	
	/**
	 * Sphere stress test
	 */
	public class ExSphere extends FastTemplate
	{
		/**
		 * @inheritDoc
		 */
		override protected function onInit():void
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
			var segments:uint = 59;
			
			title += " : Sphere stress test " + segments + "x" + segments + " segments"; 
			
			var sphere:Sphere = new Sphere(new BitmapFileMaterial("assets/earth.jpg"), 100, segments, segments);
			
			scene.addChild(sphere);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onPreRender():void
		{
			scene.rotationY += 0.2;
		}
	}
}