package
{
	import away3dlite.core.base.*;
	import away3dlite.events.*;
	import away3dlite.lights.*;
	import away3dlite.loaders.*;
	import away3dlite.materials.*;
	import away3dlite.templates.*;

	import flash.display.*;
	import flash.geom.Vector3D;

	[SWF(backgroundColor="#000000", frameRate="30", quality="MEDIUM", width="800", height="600")]
	public class ExLight extends BasicTemplate
	{
		[Embed(source="../src/assets/torso_marble256.jpg")]
		private var Texture:Class;

		[Embed(source="../src/assets/torso_normal_256.jpg")]
		private var Normal:Class;

		private var model:Object3D;

		override protected function onInit():void
		{
			var rLight:DirectionalLight3D = new DirectionalLight3D();
			rLight.direction = new Vector3D(1, 0, 0);
			rLight.color = 0xFF0000;
			rLight.ambient = 0.1;
			scene.addLight(rLight);

			var gLight:DirectionalLight3D = new DirectionalLight3D();
			gLight.direction = new Vector3D(0, 1, 0);
			gLight.color = 0x00FF00;
			gLight.ambient = 0.1;
			scene.addLight(gLight);

			var bLight:DirectionalLight3D = new DirectionalLight3D();
			bLight.direction = new Vector3D(0, 0, 1);
			bLight.color = 0x0000FF;
			bLight.ambient = 0.1;
			scene.addLight(bLight);

			var _texture:Bitmap = new Texture;
			var _bitmap:BitmapData = new BitmapData(_texture.width, _texture.height, false);
			_bitmap.draw(_texture);

			var _normalMap:Bitmap = new Normal;
			var material:BitmapMaterial = new Dot3BitmapMaterial(_bitmap, _normalMap.bitmapData);
			material.smooth = true;

			var md2:MD2 = new MD2();
			md2.material = material;
			md2.centerMeshes = true;

			var loader:Loader3D = new Loader3D();
			loader.loadGeometry("../src/assets/torsov2.MD2", md2);
			loader.addEventListener(Loader3DEvent.LOAD_SUCCESS, onSuccess);
			scene.addChild(loader);

			camera.z = -200;
		}

		private function onSuccess(event:Loader3DEvent):void
		{
			model = event.loader.handle;
			model.rotationX = 90;
		}

		override protected function onPreRender():void
		{
			scene.rotationY++;
		}
	}
}