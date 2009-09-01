package
{
	import away3dlite.materials.WireframeMaterial;
	import away3dlite.templates.PhysicsTemplate;

	import flash.events.MouseEvent;

	import jiglib.physics.RigidBody;
	import jiglib.plugin.away3dlite.Away3DLiteMesh;

	[SWF(backgroundColor="#666666",frameRate="30",quality="MEDIUM",width="800",height="600")]
	/**
	 * Example : Falling Balls
	 * @author bartekd
	 * @author katopz
	 */
	public class ExFallingBalls extends PhysicsTemplate
	{
		private var cubes:Vector.<RigidBody>;

		override protected function build():void
		{
			cubes = new Vector.<RigidBody>(20, true);
			for (var i:int = 0; i < 20; i++)
			{
				var cube:RigidBody = physics.createCube(new WireframeMaterial(), 50, 50, 50);
				cube.material.restitution = .1;
				cubes[i] = cube;
			}

			reset();

			stage.addEventListener(MouseEvent.CLICK, reset);
		}

		private function reset(e:* = null):void
		{
			for each (var cube:RigidBody in cubes)
			{
				cube.x = Math.random() * 900 - Math.random() * 900;
				cube.y = 2000 + Math.random() * 3000;
				cube.z = Math.random() * 900 - Math.random() * 900;
				cube.rotationX = 360 * Math.random();
				cube.rotationY = 360 * Math.random();
				cube.rotationZ = 360 * Math.random();
				cube.setActive();
			}
		}

		override protected function onPreRender():void
		{
			physics.step();
			//camera.lookAt(Away3DLiteMesh(RigidBody(cubes[0]).skin).mesh.transform.matrix3D.position);
			camera.lookAt(Away3DLiteMesh(RigidBody(ground).skin).mesh.transform.matrix3D.position);
		}
	}
}