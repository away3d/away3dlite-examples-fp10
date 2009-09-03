package
{
	import away3dlite.materials.ColorMaterial;
	import away3dlite.materials.WireframeMaterial;
	import away3dlite.primitives.SimpleCube;
	import away3dlite.templates.PhysicsTemplate;

	import flash.events.MouseEvent;
	import flash.geom.Vector3D;

	import jiglib.physics.RigidBody;

	[SWF(backgroundColor="#666666", frameRate = "30", quality = "MEDIUM", width = "800", height = "600")]
	/**
	 * Example : Falling Balls
	 * @see http://away3d.googlecode.com/svn/branches/JigLibLite/src
	 * @author bartekd
	 * @author katopz
	 */
	public class ExFallingBalls extends PhysicsTemplate
	{
		private var cubes:Vector.<RigidBody>;

		override protected function build():void
		{
			title += " : Falling Balls, Click to reset";

			// move camera to top view
			camera.y = 1000;

			// random decor
			cubes = new Vector.<RigidBody>(20, true);
			for (var i:int = 0; i < 20; i++)
			{
				var cube:RigidBody = physics.createCube(new WireframeMaterial(0xFFFFFF * Math.random()), 25, 25, 25);
				cube.material.restitution = .1;
				cubes[i] = cube;
			}

			// debug cube
			var length:int = 300;
			var oCube:SimpleCube = new SimpleCube(10, new ColorMaterial(0xFFFFFF));
			scene.addChild(oCube);

			var xCube:SimpleCube = new SimpleCube(10, new ColorMaterial(0xFF0000));
			xCube.x = length;
			scene.addChild(xCube);

			var yCube:SimpleCube = new SimpleCube(10, new ColorMaterial(0x00FF00));
			yCube.y = length;
			scene.addChild(yCube);

			var zCube:SimpleCube = new SimpleCube(10, new ColorMaterial(0x0000FF));
			zCube.z = length;
			scene.addChild(zCube);

			//reset
			reset();
			stage.addEventListener(MouseEvent.CLICK, reset);
		}

		private function reset(e:* = null):void
		{
			for each (var cube:RigidBody in cubes)
			{
				cube.x = Math.random() * 500 - Math.random() * 500;
				cube.y = 500 + Math.random() * 1000;
				cube.z = Math.random() * 500 - Math.random() * 500;
				cube.rotationX = 360 * Math.random();
				cube.rotationY = 360 * Math.random();
				cube.rotationZ = 360 * Math.random();
				cube.setActive();
			}
		}

		override protected function onPreRender():void
		{
			physics.step();
			camera.lookAt(new Vector3D(), new Vector3D(0, 1, 0));
		}
	}
}