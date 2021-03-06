/*

Basic Metasequoia loading in Away3dLite

Demonstrates:

How to load a Metasequoia file.
How to load a texture from an external image.
How to clone a laoded model.

Code by Rob Bateman & Katopz
rob@infiniteturtles.co.uk
http://www.infiniteturtles.co.uk
katopz@sleepydesign.com
http://sleepydesign.com/

This code is distributed under the MIT License

Copyright (c)  

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

package
{
	import away3dlite.core.base.*;
	import away3dlite.events.*;
	import away3dlite.loaders.*;
	import away3dlite.templates.*;
	
	import flash.display.*;

	[SWF(backgroundColor="#000000", frameRate="30", quality="MEDIUM", width="800", height="600")]

	/**
	 * Metasequoia example.
	 */
	public class ExMQO extends BasicTemplate
	{
    	//signature swf
    	[Embed(source="assets/signature_lite_katopz.swf", symbol="Signature")]
    	private var SignatureSwf:Class;
		
		//signature variables
		private var Signature:Sprite;
		private var SignatureBitmap:Bitmap;
		
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
		
		/**
		 * @inheritDoc
		 */
		override protected function onInit():void
		{
			title += " : Metasequoia Example.";
			
			mqo = new MQO();
			//mqo.centerMeshes = true;
			
			loader = new Loader3D();
			loader.loadGeometry("assets/Messerschmitt_Bf_109.mqo", mqo);
			loader.addEventListener(Loader3DEvent.LOAD_SUCCESS, onSuccess);
			scene.addChild(loader);
			
			//add signature
            Signature = Sprite(new SignatureSwf());
            SignatureBitmap = new Bitmap(new BitmapData(Signature.width, Signature.height, true, 0));
            SignatureBitmap.y = stage.stageHeight - Signature.height;
            stage.quality = StageQuality.HIGH;
            SignatureBitmap.bitmapData.draw(Signature);
            stage.quality = StageQuality.MEDIUM;
			addChild(SignatureBitmap);
		}
		
		/**
		 * @inheritDoc
		 */
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