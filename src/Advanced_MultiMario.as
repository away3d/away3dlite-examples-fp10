/*

Collada bones example in away3dlite

Demonstrates:

How to import an animated collada file that uses bones.
How to posiiton a mouse cursor that hovers over a plane.
how to duplicate animated geometry with the minimum processing overhead.

Code by Rob Bateman
rob@infiniteturtles.co.uk
http://www.infiniteturtles.co.uk

Models by Peter Kapelyan
flashnine@gmail.com
http://www.flashten.com/

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
	import away3dlite.events.MouseEvent3D;
	import away3dlite.core.base.MeshSortType;
	import away3dlite.animators.BonesAnimator;
	import away3dlite.cameras.*;
	import away3dlite.containers.*;
	import away3dlite.core.base.Mesh;
	import away3dlite.core.utils.*;
	import away3dlite.loaders.*;
	import away3dlite.materials.*;
	import away3dlite.primitives.*;
	
	import net.hires.debug.Stats;
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	[SWF(backgroundColor="#000000", frameRate="60", quality="LOW", width="800", height="600")]
	
	public class Advanced_MultiMario extends Sprite
	{
		//grass texure for floor
		[Embed(source="assets/floor.jpg")]
    	public var Floor:Class;
    	
    	//shadow texture for under mario
    	[Embed(source="assets/shadow.png")]
    	public var Shade:Class;
    	
    	//crosshair texture for mouse pointer
    	[Embed(source="assets/position.png")]
    	public var Position:Class;
    	
    	//texture for mario
		[Embed(source="assets/mario_tex.jpg")]
		private var Charmap:Class;
		
		//collada file for mario
		[Embed(source="assets/mario_testrun.dae",mimeType="application/octet-stream")]
		private var Charmesh:Class;
		
    	//signature swf
    	[Embed(source="assets/signature_peter.swf", symbol="Signature")]
    	public var SignatureSwf:Class;
    	
    	//engine variables
    	private var stats:Stats;
		private var camera:Camera3D;
		private var view:View3D;
		private var scene:Scene3D;
		
		//material variables
		private var material:BitmapMaterial;
		private var shadeMaterial:BitmapMaterial;
		private var positionMaterial:BitmapMaterial;
		private var floorMaterial:BitmapMaterial;
		
		//signature variables
		private var Signature:Sprite;
		private var SignatureBitmap:Bitmap;
		
		//objectvariables
		private var collada:Collada;
		private var model1:ObjectContainer3D;
		private var mesh:Mesh;
		private var model2:ObjectContainer3D;
		private var model3:ObjectContainer3D;
		private var model4:ObjectContainer3D;
		private var model5:ObjectContainer3D;
		private var model6:ObjectContainer3D;
		private var model7:ObjectContainer3D;
		private var model8:ObjectContainer3D;
		private var model9:ObjectContainer3D;
		private var position:Plane;
		private var shade1:Plane;
		private var shade2:Plane;
		private var shade3:Plane;
		private var shade4:Plane;
		private var shade5:Plane;
		private var shade6:Plane;
		private var shade7:Plane;
		private var shade8:Plane;
		private var shade9:Plane;
		private var floor:Plane;
		
		//animation varibles
		private var skinAnimation:BonesAnimator;
		
		//navigation variables
		private var rotate:Number;
		private var scrollX:Number;
		private var scrollY:Number;
		
		public function Advanced_MultiMario()
		{
			Debug.active = true;
			init();
		}
		
		/**
		 * Global initialise function
		 */
		private function init():void
		{
			//Debug.active = true;
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
			
			scene = new Scene3D();
			camera = new Camera3D();
			
			//view = new View3D({camera:camera, scene:scene});
			view = new View3D();
			view.camera = camera;
			view.scene = scene;
			
			//view.addSourceURL("srcview/index.html");
			view.mouseZeroMove = true;
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
			material = new BitmapMaterial(Cast.bitmap(Charmap));
			
			//floorMaterial = new TransformBitmapMaterial(Cast.bitmap(Floor), {repeat:true,scaleX:3,scaleY:3, precision:2});
			floorMaterial = new BitmapMaterial(Cast.bitmap(Floor));
			floorMaterial.repeat = true;
			//floorMaterial.scaleX = 3;
			//floorMaterial.scaleY = 3;
			//floorMaterial.precision = 2;
			
			shadeMaterial = new BitmapMaterial(Cast.bitmap(Shade));
			
			positionMaterial = new BitmapMaterial(Cast.bitmap(Position));
		}
		
		/**
		 * Initialise the scene objects
		 */
		private function initObjects():void
		{
			collada = new Collada();
			collada.scaling = 10;
			model1 = collada.parseGeometry(Charmesh) as ObjectContainer3D;
			model1.materialLibrary.getMaterial("FF_FF_FF_mario1").material = material;
			
			scene.addChild(model1);
			
			mesh = model1.getChildByName("polySurface1") as Mesh;
			mesh.mouseEnabled = false;
			
			model2 = new ObjectContainer3D();
			model2.addChild(mesh.clone());
			model2.x = 150;
			
			scene.addChild(model2);
			
			model3 = new ObjectContainer3D();
			model3.addChild(mesh.clone());
			model3.x = -150;
			
			scene.addChild(model3);
			
			model4 = new ObjectContainer3D();
			model4.addChild(mesh.clone());
			model4.z = 150;
			
			scene.addChild(model4);
			
			model5 = new ObjectContainer3D();
			model5.addChild(mesh.clone());
			model5.z = -150;
						
			scene.addChild(model5);
			
			model6 = new ObjectContainer3D();
			model6.addChild(mesh.clone());
			model6.z = -150;
			model6.x = -150;
			
			scene.addChild(model6);
			
			model7 = new ObjectContainer3D();
			model7.addChild(mesh.clone());
			model7.z = 150;
			model7.x = -150;
			
			scene.addChild(model7);
			
			model8 = new ObjectContainer3D();
			model8.addChild(mesh.clone());
			model8.z = 150;
			model8.x = 150;
			
			scene.addChild(model8);
			
			model9 = new ObjectContainer3D();
			model9.addChild(mesh.clone());
			model9.z = -150;
			model9.x = 150;
			
			scene.addChild(model9);
			
			position = new Plane();
			position.width = 50;
			position.height = 50;
			position.material = positionMaterial;
			position.mouseEnabled = false;
			
			scene.addChild(position);
			
			shade1 = new Plane();
			shade1.material = shadeMaterial;
			shade1.sortType = MeshSortType.BACK;
			shade1.mouseEnabled = false;
			
			scene.addChild(shade1);
			
			shade2 = shade1.clone() as Plane;
			shade2.x = 150;
			
			scene.addChild(shade2);
			
			shade3 = shade1.clone() as Plane;
			shade3.x = -150;
			
			scene.addChild(shade3);
			
			shade4 = shade1.clone() as Plane;
			shade4.z = 150;
			
			scene.addChild(shade4);
			
			shade5 = shade1.clone() as Plane;
			shade5.z = -150;
			
			scene.addChild(shade5);
			
			shade6 = shade1.clone() as Plane;
			shade6.z = -150;
			shade6.x = -150;
			
			scene.addChild(shade6);
			
			shade7 = shade1.clone() as Plane;
			shade7.z = 150;
			shade7.x = -150;
			
			scene.addChild(shade7);
			
			shade8 = shade1.clone() as Plane;
			shade8.z = 150;
			shade8.x = 150;
			
			scene.addChild(shade8);
			
			shade9 = shade1.clone() as Plane;
			shade9.z = -150;
			shade9.x = 150;
			
			scene.addChild(shade9);
			
			floor = new Plane();
			floor.width = 600;
			floor.height = 600;
			floor.material = floorMaterial;
			//floor.ownCanvas = true;
			floor.sortType = MeshSortType.BACK;
			scene.addChild(floor);
			
			//grabs an instance of the skin animation from the animationLibrary
			skinAnimation = model1.animationLibrary.getAnimation("default").animation as BonesAnimator;
		}
		
		/**
		 * Initialise the listeners
		 */
		private function initListeners():void
		{
			scene.addEventListener(MouseEvent3D.MOUSE_MOVE, onMouseMove);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(Event.RESIZE, onResize);
			onResize();
		}
		
		/**
		 * Navigation and render loop
		 */
		private function onEnterFrame(event:Event):void
		{
			//calculate the polar coordinate rotation for the cursor position on the floor plane
			rotate = (Math.floor(Math.atan2(-position.x, -position.z)*(180/Math.PI)) + 180);
			
			//calculate scroll values for the floor material
			scrollY = Math.sin((rotate + 90)/180*Math.PI)*5;
			scrollX = Math.cos((rotate + 90)/180*Math.PI)*5;
			
			//apply scroll values to the floor material
			//floorMaterial.offsetX += scrollX;
			//floorMaterial.offsetY += scrollY;
			
			//update the rotation of each mario model
			model1.rotationY = rotate;
			model2.rotationY = rotate;
			model3.rotationY = rotate;
			model4.rotationY = rotate;
			model5.rotationY = rotate;
			model6.rotationY = rotate;
			model7.rotationY = rotate;
			model8.rotationY = rotate;
			model9.rotationY = rotate;
			
			//update the camera position
			camera.x = 0;
			camera.y = -70;
			camera.z = -10;
			camera.rotationX = -mouseY/20;
			camera.transform.matrix3D.prependTranslation(0, 0, mouseY/2 - 700);
			
			//update the collada animation
			skinAnimation.update(getTimer()*2/1000);
			
			//render scene
			view.render();
		}
		
		/**
		 * scene listener for crosshairs plane
		 */
		private function onMouseMove(e:MouseEvent3D):void {
			position.x = e.scenePosition.x;
			position.z = e.scenePosition.z;
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