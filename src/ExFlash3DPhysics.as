package
{
	import away3dlite.materials.ColorMaterial;
	import away3dlite.materials.WireframeMaterial;
	import away3dlite.templates.PhysicsTemplate;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	import jiglib.math.*;
	import jiglib.physics.*;
	import jiglib.physics.constraint.*;
	import jiglib.plugin.away3dlite.Away3DLiteMesh;

	[SWF(backgroundColor="#666666",frameRate="30",quality="MEDIUM",width="800",height="600")]
	/**
	 * Example : Flash3D Physics
	 * @see http://away3d.googlecode.com/svn/branches/JigLibLite/src
	 * @author bartekd
	 * @author katopz
	 */
	public class ExFlash3DPhysics extends PhysicsTemplate
	{
		private var ballBody:Dictionary;
		private var boxBody:Array;

		private var _ball:RigidBody;

		private var keyRight:Boolean = false;
		private var keyLeft:Boolean = false;
		private var keyForward:Boolean = false;
		private var keyReverse:Boolean = false;
		private var keyUp:Boolean = false;

		override protected function build():void
		{
			title += " : JigLibLite Physics, Use Key up, down, left, right"; 
			
			camera.y = 1000;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);

			init3D();
		}

		private function init3D():void
		{
			ballBody = new Dictionary(true);
			var color:uint;
			for (var i:int = 0; i < 3; i++)
			{
				color = (i == 0) ? 0xff8888 : 0xeeee00;
				var ball:RigidBody = physics.createSphere(new WireframeMaterial(),25);
				ball.mass = 5;
				ball.moveTo(new JNumber3D(-100, 500 + (100 * i + 100), -100));

				_ball = ballBody[Away3DLiteMesh(ball.skin).mesh] = ball;
			}

			boxBody = [];
			for (i = 0; i < 6; i++)
			{
				boxBody[i] = physics.createCube(new WireframeMaterial(0xFFFFFF*Math.random()), 25, 25, 25);
				boxBody[i].moveTo(new JNumber3D(0, 500 + (100 * i + 100), 0));
			}
		}
		
		// TODO : moveTo KeyUtils
		private function keyDownHandler(event:KeyboardEvent):void
		{
			switch (event.keyCode)
			{
				case Keyboard.UP:
					keyForward = true;
					keyReverse = false;
					break;

				case Keyboard.DOWN:
					keyReverse = true;
					keyForward = false;
					break;

				case Keyboard.LEFT:
					keyLeft = true;
					keyRight = false;
					break;

				case Keyboard.RIGHT:
					keyRight = true;
					keyLeft = false;
					break;
				case Keyboard.SPACE:
					keyUp = true;
					break;
			}
		}
		
		// TODO : moveTo KeyUtils
		private function keyUpHandler(event:KeyboardEvent):void
		{
			switch (event.keyCode)
			{
				case Keyboard.UP:
					keyForward = false;
					break;

				case Keyboard.DOWN:
					keyReverse = false;
					break;

				case Keyboard.LEFT:
					keyLeft = false;
					break;

				case Keyboard.RIGHT:
					keyRight = false;
					break;
				case Keyboard.SPACE:
					keyUp = false;
			}
		}

		override protected function onPreRender():void
		{
			if (keyLeft)
			{
				_ball.addWorldForce(new JNumber3D(100, 0, 0), _ball.currentState.position);
			}
			if (keyRight)
			{
				_ball.addWorldForce(new JNumber3D(-100, 0, 0), _ball.currentState.position);
			}
			if (keyForward)
			{
				_ball.addWorldForce(new JNumber3D(0, 0, 100), _ball.currentState.position);
			}
			if (keyReverse)
			{
				_ball.addWorldForce(new JNumber3D(0, 0, -100), _ball.currentState.position);
			}
			if (keyUp)
			{
				_ball.addWorldForce(new JNumber3D(0, 100, 0), _ball.currentState.position);
			}

			physics.step();

			camera.lookAt(Away3DLiteMesh(_ball.skin).mesh.position, new Vector3D(0,1,0));
		}
	}
}