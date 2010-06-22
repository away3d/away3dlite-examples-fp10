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
	 * Camera translate example
	 */
	public class ExCameraMove extends BasicTemplate
	{
		/**
		 * @inheritDoc
		 */
		override protected function onInit():void
		{
			title += " : Camera W,S=Forward,Backward | A,D=Left,Right | C,V=Up,Down";

			var sphere:Sphere = new Sphere(new BitmapFileMaterial("assets/earth.jpg"), 100, 32, 32);
			scene.addChild(sphere);

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
		}

		private function keyHandler(event:KeyboardEvent):void
		{
			switch (event.type)
			{
				case KeyboardEvent.KEY_DOWN:
					switch (event.keyCode)
					{
						case "W".charCodeAt():
							camera.moveForward(1);
							break;
						case "S".charCodeAt():
							camera.moveBackward(1);
							break;
						case "A".charCodeAt():
							camera.moveLeft(1);
							break;
						case "D".charCodeAt():
							camera.moveRight(1);
							break;
						case "C".charCodeAt():
							camera.moveUp(1);
							break;
						case "V".charCodeAt():
							camera.moveDown(1);
							break;
					}
					break;
			}
		}
	}
}