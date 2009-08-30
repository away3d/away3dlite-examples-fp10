package
{
	import away3dlite.core.base.*;
	import away3dlite.events.*;
	import away3dlite.loaders.*;
	import away3dlite.templates.*;

	[SWF(backgroundColor="#000000", frameRate="30", quality="LOW", width="800", height="600")]

	/**
	 * ExMQO
	 * @author katopz
	 *
	 */
	public class ExMQO extends BasicTemplate
	{
		private var mqo:MQO;
		private var loader:Loader3D;
		private var loaded:Boolean = false;
		private var model1:Object3D;
		private var model2:Object3D;
		private var model3:Object3D;
		private var model4:Object3D;
		private var model5:Object3D;
		
		private function onSuccess(event:Loader3DEvent):void
		{
			loaded = true;
			model1 = loader.handle;
			
			model2 = model1.clone();
			model3 = model1.clone();
			model4 = model1.clone();
			model5 = model1.clone();
			
			model2.x = -300;
			model3.x = 300;
			model4.y = -220;
			model5.y = 220;
			
			scene.addChild(model2);
			scene.addChild(model3);
			scene.addChild(model4);
			scene.addChild(model5);
		}
		
		override protected function onInit():void
		{
			title += " : Metasequoia Example.";
			
			mqo = new MQO();
			//mqo.centerMeshes = true;
			
			loader = new Loader3D();
			loader.loadGeometry("assets/Messerschmitt_Bf_109.mqo", mqo);
			loader.addOnSuccess(onSuccess);
			scene.addChild(loader);
		}
		
		override protected function onPreRender():void
		{
			if (loaded) {
				model1.rotationX++;
				model1.rotationY++;
				model1.rotationZ++;
				
				model2.rotationX++;
				model2.rotationY++;
				model2.rotationZ++;
				
				model3.rotationX++;
				model3.rotationY++;
				model3.rotationZ++;
				
				model4.rotationX++;
				model4.rotationY++;
				model4.rotationZ++;
				
				model5.rotationX++;
				model5.rotationY++;
				model5.rotationZ++;
			}
		}
	}
}