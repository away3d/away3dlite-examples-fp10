package
{
	import away3dlite.materials.BitmapFileMaterial;
	import away3dlite.primitives.Sphere;
	import away3dlite.templates.SimpleView;

	[SWF(backgroundColor="#000000", frameRate="30", quality="LOW", width="800", height="600")]
	/**
	 * ExSphere
	 * @author katopz
	 */
	public class ExSphere extends SimpleView
	{
		override protected function create():void
		{
			title += " : Sphere 40x40 segments"; 
			
			var sphere:Sphere = new Sphere();
			sphere.radius = 100;
			sphere.segmentsW = sphere.segmentsH = 40;
			sphere.material = new BitmapFileMaterial("assets/earth.jpg");
			view.scene.addChild(sphere);
		}

		override protected function draw():void
		{
			view.scene.rotationY+=Math.PI/10;
		}
	}
}