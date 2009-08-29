package
{
	import away3dlite.materials.BitmapFileMaterial;
	import away3dlite.primitives.Sphere;
	import away3dlite.templates.FastTemplate;

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
			
			var sphere:Sphere = new Sphere();
			sphere.radius = 100;
			sphere.segmentsW = sphere.segmentsH = segments;
			sphere.material = new BitmapFileMaterial("assets/earth.jpg");
			
			view.scene.addChild(sphere);
		}

		override protected function onPreRender():void
		{
			view.scene.rotationY+=Math.PI/10;
		}
	}
}