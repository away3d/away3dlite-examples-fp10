package
{
	import away3dlite.materials.*;
	import away3dlite.primitives.*;
	import away3dlite.templates.*;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;

	[SWF(backgroundColor="#000000", frameRate="30", quality="MEDIUM", width="800", height="600")]
	/**
	 * Camera pitch, yaw, roll example
	 */
	public class ExCamera extends BasicTemplate
	{
		private var _degrees:Vector3D = new Vector3D;
		
		/**
		 * @inheritDoc
		 */
		override protected function onInit():void
		{
			title += " : Camera W,S=yaw | A,D=picth | Q,E=roll";

			var sphere:Sphere = new Sphere(new BitmapFileMaterial("assets/earth.jpg"), 100, 32, 32);
			scene.addChild(sphere);

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
		}

		private function keyHandler(event:KeyboardEvent):void
		{
			_degrees = new Vector3D;
			
			switch (event.type)
			{
				case KeyboardEvent.KEY_DOWN:	
					switch (event.keyCode)
					{
						case "W".charCodeAt():
							_degrees.y--;
							break;
						case "S".charCodeAt():
							_degrees.y++;
							break;
						case "A".charCodeAt():
							_degrees.x++;
							break;
						case "D".charCodeAt():
							_degrees.x--;
							break;
						case "Q".charCodeAt():
							_degrees.z++;
							break;
						case "E".charCodeAt():
							_degrees.z--;
							break;
					}
					break;
			}
		}

		/**
		 * @inheritDoc
		 */
		override protected function onPreRender():void
		{
			camera.pitch(_degrees.y);
			camera.yaw(_degrees.x);
			camera.roll(_degrees.z);
		}
	}
}