package
{
	import away3dlite.core.base.*;
	import away3dlite.materials.*;
	import away3dlite.primitives.*;
	import away3dlite.templates.*;
	
	import flash.events.MouseEvent;

	[SWF(backgroundColor="#000000", frameRate="30", quality="MEDIUM", width="800", height="600")]

	/**
	 * ExLookAt
	 * @author katopz
	 */
	public class ExLookAt extends BasicTemplate
	{
		private var sphere0:Sphere;
		private var sphere1:Sphere;
		private var step:Number = 0;
		private var target:Object3D;
		private var isLookAt:Boolean = false;
		
		override protected function onInit():void
		{
			title += " : LookAt 2 Spheres, Click to switch target."; 
			
			var segment:uint = 20;

			sphere0 = new Sphere();
			sphere0.radius = 100;
			sphere0.segmentsW = sphere0.segmentsH = segment;
			sphere0.material = new BitmapFileMaterial("assets/earth.jpg");
			sphere0.name = "sphere0";
			view.scene.addChild(sphere0);
			
			sphere1 = new Sphere();
			sphere1.radius = 100;
			sphere1.segmentsW = sphere1.segmentsH = segment;
			sphere1.material = new WireframeMaterial();
			sphere1.name = "sphere1";
			view.scene.addChild(sphere1);
			
			stage.addEventListener(MouseEvent.CLICK, onMouse);
		}
		
		override protected function onPreRender():void
		{
			sphere1.x = 200*Math.sin(step);
			
			step += 0.1;
			
			target = isLookAt? sphere0 : sphere1;
			
			camera.lookAt(target.transform.matrix3D.position);
		}
		
		protected function onMouse(event:MouseEvent):void
		{
			isLookAt = !isLookAt;
		}
	}
}