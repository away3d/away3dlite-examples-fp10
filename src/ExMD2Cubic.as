/*

Basic scene setup example in Away3d

Demonstrates:

How to setup your own camera and scene, and apply it to a view.
How to add 3d objects to a scene.
How to update the view every frame.

Code by Rob Bateman
rob@infiniteturtles.co.uk
http://www.infiniteturtles.co.uk

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
	import away3dlite.animators.*;
	import away3dlite.cameras.*;
	import away3dlite.containers.*;
	import away3dlite.core.render.*;
	import away3dlite.events.*;
	import away3dlite.loaders.*;
	import away3dlite.materials.*;
	
	import net.hires.debug.Stats;
	
	import flash.display.*;
	import flash.events.*;
	
	[SWF(backgroundColor="#000000", frameRate="30", quality="LOW", width="800", height="600")]
	
	public class ExMD2Cubic extends Sprite
	{
    	//signature swf
    	[Embed(source="assets/signature.swf", symbol="Signature")]
    	public static var SignatureSwf:Class;
    	
    	//sphere texture jpg
		[Embed(source="assets/blue.jpg")]
		private var Blue:Class;
		
		//torus texture jpg
		[Embed(source="assets/red.jpg")]
		private var Red:Class;
		
		//engine variables
		private var stats:Stats;
		private var camera:Camera3D;
		private var renderer:GroupRenderer;
		private var view:View3D;
		
		//signature variables
		private var Signature:Sprite;
		private var SignatureBitmap:Bitmap;
		
		//material objects
		//private var material:LineMaterial;
		private var material:BitmapMaterial;
		
		/**
		 * Constructor
		 */
		public function ExMD2Cubic() 
		{
			init();
		}
		
		/**
		 * Global initialise function
		 */
		private function init():void
		{
			initEngine();
			initMaterials();
			initObjects();
			initListeners();
		}
		
		/**
		 * Initialise the engine
		 */
		private function initEngine():void
		{
			stats = new Stats();
			addChild(stats);
			
			//camera = new Camera3D({z:-1000});
			camera = new Camera3D();
			camera.z = -1500;
			
			renderer = new GroupRenderer();
			
			//view = new View3D({scene:scene, camera:camera});
			view = new View3D();
			view.camera = camera;
			view.renderer = renderer;
			
			//view.addSourceURL("srcview/index.html");
			addChild(view);
			
			//add signature
            Signature = Sprite(new SignatureSwf());
            SignatureBitmap = new Bitmap(new BitmapData(Signature.width, Signature.height, true, 0));
            stage.quality = StageQuality.HIGH;
            SignatureBitmap.bitmapData.draw(Signature);
            stage.quality = StageQuality.LOW;
            addChild(SignatureBitmap);
		}
		
		/**
		 * Initialise the materials
		 */
		private function initMaterials():void
		{
			//material = new LineMaterial(0xCC0000);
			material = new BitmapMaterial((new Red() as Bitmap).bitmapData);
		}
		
		/**
		 * Initialise the scene objects
		 */
		private function initObjects():void
		{
			var amount:uint = 3;
			var radius:uint = 80;
			var gap:uint = amount;

			for (var i:int = -amount / 2; i < amount / 2; ++i) {
				for (var j:int = -amount / 2; j < amount / 2; ++j) {
					for (var k:int = -amount / 2; k < amount / 2; ++k) {
						var md2:Md2 = new Md2();
						md2.material = new BitmapFileMaterial("assets/pg.png");
						md2.scaling = 10;
						
						var loader:Loader3D = new Loader3D(); 
						loader.loadGeometry("assets/pg.md2", md2);
						loader.addOnSuccess(onSuccess);
						
						loader.x = gap * radius * i;
						loader.y = gap * radius * j;
						loader.z = gap * radius * k;
						
						view.scene.addChild(loader);
					}
				}
			}
			
			view.scene.rotationX = 30;
		}
		
		/**
		 * Initialise the listeners
		 */
		private function initListeners():void
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(Event.RESIZE, onResize);
			onResize();
		}
		
		/**
		 * Navigation and render loop
		 */
		private function onEnterFrame( e:Event ):void
		{
			view.scene.rotationX = (mouseX - stage.stageWidth / 2) / 5;
			view.scene.rotationZ = (mouseY - stage.stageHeight / 2) / 5;
			view.scene.rotationY++;
			view.render();
		}
						
		/**
		 * Listener function for loading complete event on loader
		 */
		private function onSuccess(event:Loader3DEvent):void
		{
			var model:MovieMesh = event.loader.handle as MovieMesh;
			model.play("walk");
		}
		
		/**
		 * stage listener for resize events
		 */
		private function onResize(event:Event = null):void
		{
			view.x = stage.stageWidth / 2;
            view.y = stage.stageHeight / 2;
            SignatureBitmap.y = stage.stageHeight - Signature.height;
		}
	}
}