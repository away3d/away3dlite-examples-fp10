package
{
	import away3dlite.materials.*;
	import away3dlite.primitives.*;
	import away3dlite.templates.*;
	
	import flash.display.Bitmap;
	import flash.display.BlendMode;

	[SWF(backgroundColor="#000000",frameRate="30",quality="MEDIUM",width="800",height="600")]

	/**
	 * Plane test
	 */
	public class ExPlane extends BasicTemplate
	{
		[Embed(source="assets/earth.jpg")]
		private var Texture:Class;

		private var plane:Plane;

		/**
		 * @inheritDoc
		 */
		override protected function onInit():void
		{
			camera.z = -900;
			
			var earthBitmap:Bitmap = Bitmap(new Texture());
			view.addChild(earthBitmap);
			
			earthBitmap.x = -earthBitmap.width/2;
			earthBitmap.y = -earthBitmap.height/2;
			
			earthBitmap.blendMode = BlendMode.DIFFERENCE;

			var segments:uint = 1;

			title += " : Plane test | " + earthBitmap.width + "x" + earthBitmap.height + " | " + segments + "x" + segments + " segments | zoom : " + camera.zoom + ", focus : " + camera.focus +" |" ;

			plane = new Plane(new BitmapFileMaterial("assets/earth.jpg"), earthBitmap.width, earthBitmap.height, segments, segments);
			plane.bothsides = true;

			scene.addChild(plane);
		}

		/**
		 * @inheritDoc
		 */
		override protected function onPreRender():void
		{
			plane.rotationX++;
		}
	}
}