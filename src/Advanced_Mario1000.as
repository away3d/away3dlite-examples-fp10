/*

1000 Sprite3Ds example in Away3D Lite

Demonstrates:

How to create Sprite3D objects and add them to a scene.
How to use the MovieMaterial.
How to mirror a second view to fake multiple 3d objects.
How to use the viewpoint mode of Sprite3D.

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
	import away3dlite.animators.*;
	import away3dlite.cameras.*;
	import away3dlite.containers.*;
	import away3dlite.core.base.*;
	import away3dlite.core.utils.*;
	import away3dlite.debug.*;
	import away3dlite.loaders.*;
	import away3dlite.materials.*;
	import away3dlite.sprites.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.ui.*;
	import flash.utils.*;
	import flash.text.*;
	
	[SWF(backgroundColor="#000000", frameRate="60", quality="LOW", width="800", height="600")]
	
	public class Advanced_Mario1000 extends Sprite
	{
    	//texture for mario
		[Embed(source="assets/mario_tex.jpg")]
		private var Charmap:Class;
		
		//collada file for mario
		[Embed(source="assets/mario_testrun.dae",mimeType="application/octet-stream")]
		private var Charmesh:Class;
		
    	//signature swf
    	[Embed(source="assets/signature_lite_peter.swf", symbol="Signature")]
    	public var SignatureSwf:Class;
    	
    	//engine variables
		private var camera1:HoverCamera3D;
		private var camera2:HoverCamera3D;
		private var view1:View3D;
		private var view2:View3D;
		
		//material variables
		private var marioMaterial:BitmapMaterial;
		private var movieMaterial:MovieMaterial;
		
		//signature variables
		private var Signature:Sprite;
		private var SignatureBitmap:Bitmap;
		
		//object variables
		private var collada:Collada;
		private var model:ObjectContainer3D;
		private var mesh:Mesh;
		private var sprites:Vector.<Sprite3D> = new Vector.<Sprite3D>();
		private var amount:uint = 10;
		private var size:int = 1000;
		
		//animation varibles
		private var skinAnimation:BonesAnimator;
		
		//navigation variables
		private var phase:Number = 0;
		private var frequency:Number = 200;
		private var speed:Number = 0.2;
		private var move:Boolean = false;
		private var lastPanAngle:Number;
		private var lastTiltAngle:Number;
		private var lastMouseX:Number;
		private var lastMouseY:Number;
		
		//misc variables
		private var upFlag:Boolean;
		private var downFlag:Boolean;
		private var animate:Boolean;
		private var text:TextField;
		
		public function Advanced_Mario1000()
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
			initText();
			initListeners();
		}
		
		/**
		 * Initialise the engine
		 */
		private function initEngine():void
		{
			camera1 = new HoverCamera3D();
			camera1.yfactor = 1;
			camera2 = new HoverCamera3D();
			camera2.distance = 2000;
			
			view1 = new View3D();
			view1.camera = camera1;
			view1.visible = false;
			
			view2 = new View3D();
			view2.camera = camera2;
			
			//view.addSourceURL("srcview/index.html");
			addChild(view1);
			addChild(view2);
			
			//add signature
            Signature = Sprite(new SignatureSwf());
            SignatureBitmap = new Bitmap(new BitmapData(Signature.width, Signature.height, true, 0));
            stage.quality = StageQuality.HIGH;
            SignatureBitmap.bitmapData.draw(Signature);
            stage.quality = StageQuality.LOW;
            addChild(SignatureBitmap);
            
            addChild(new AwayStats(view2));
		}
		
		/**
		 * Initialise the materials
		 */
		private function initMaterials():void
		{
			marioMaterial = new BitmapMaterial(Cast.bitmap(Charmap));
			movieMaterial = new MovieMaterial(view1);
			movieMaterial.rect = new Rectangle(-100, -100, 200, 200);
		}
		
		/**
		 * Initialise the scene objects
		 */
		private function initObjects():void
		{
			collada = new Collada();
			collada.scaling = 10;
			model = collada.parseGeometry(Charmesh) as ObjectContainer3D;
			model.materialLibrary.getMaterial("FF_FF_FF_mario1").material = marioMaterial;
			model.y = 50;
			view1.scene.addChild(model);
			
			mesh = model.getChildByName("polySurface1") as Mesh;
			mesh.mouseEnabled = false;
			
			//grabs an instance of the skin animation from the animationLibrary
			skinAnimation = model.animationLibrary.getAnimation("default").animation as BonesAnimator;
			
			var gap:int = size/(amount - 1);
			
			for (var i:int = 0; i < amount; ++i) {
				for (var j:int = 0; j < amount; ++j) {
					for (var k:int =0; k < amount; ++k) {
						var sprite3D:Sprite3D = new Sprite3D(movieMaterial);
						sprite3D.alignmentType = AlignmentType.VIEWPOINT;
						sprite3D.x = gap*i - size/2;
						sprite3D.y = gap*j - size/2;
						sprite3D.z = gap*k - size/2;
						
						//add to scene
						view2.scene.addSprite(sprite3D);
						
						//add to sprite array store
						sprites.push(sprite3D);
					}
				}
			}
		}
		
		/**
		 * Create an instructions overlay
		 */
		private function initText():void
		{
			text = new TextField();
			text.defaultTextFormat = new TextFormat("Verdana", 10, 0xFFFFFF, null, null, null, null, null, TextFormatAlign.RIGHT);
			text.x = 0;
			text.y = 0;
			text.width = 240;
			text.height = 100;
			text.selectable = false;
			text.mouseEnabled = false;
			text.text = "Mouse click and drag - rotate\n" + 
					"Cursor keys Up Down / WS - zoom\n" + 
					"Space - toggle animation\n";
			
			text.filters = [new DropShadowFilter(1, 45, 0x0, 1, 0, 0)];
			
			addChild(text);
		}
		
		/**
		 * Initialise the listeners
		 */
		private function initListeners():void
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(Event.RESIZE, onResize);
			onResize();
		}
		
		/**
		 * Navigation and render loop
		 */
		private function onEnterFrame(event:Event):void
		{
			if (move) {
				camera1.panAngle = camera2.panAngle = 0.3*(stage.mouseX - lastMouseX) + lastPanAngle;
				camera1.tiltAngle = camera2.tiltAngle = 0.3*(stage.mouseY - lastMouseY) + lastTiltAngle;
			}
			
			if (animate) {
				//update phases
				phase += speed;
				//update sprite3d sizes
				var count:uint = 0;
				for (var i:int = 0; i < amount; ++i) {
					for (var j:int = 0; j < amount; ++j) {
						for (var k:int =0; k < amount; ++k) {
							var sprite3D:Sprite3D = sprites[count++];
							
							//modify scale using sin function
							sprite3D.scale = (Math.sin(i*frequency + phase)*0.4 + 0.8)*(Math.cos(k*frequency + phase)*0.4 + 0.8);
							
						}
					}
				}
			}
			
			if (upFlag) {
				camera2.distance -= 20;
				if (camera2.distance <= 100)
					camera2.distance = 100;
			}
			
			if (downFlag) {
				camera2.distance += 20;
				if (camera2.distance >= 3000)
					camera2.distance = 3000;
			}
			
			//update the collada animation
			skinAnimation.update(getTimer()*2/1000);
			
			camera1.hover();
			view1.render();
			
			camera2.hover();
			view2.render();
		}
		
		/**
		 * Mouse down listener for navigation
		 */
		private function onMouseDown(event:MouseEvent):void
        {
            lastPanAngle = camera1.panAngle;
            lastTiltAngle = camera1.tiltAngle;
            lastMouseX = stage.mouseX;
            lastMouseY = stage.mouseY;
        	move = true;
        	stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
        }
		
		/**
		 * Mouse up listener for navigation
		 */
        private function onMouseUp(event:MouseEvent):void
        {
        	move = false;
        	stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);     
        }
        
        /**
        * Key down handler for key controls
        */
        private function onKeyDown(e:KeyboardEvent):void {
			switch(e.keyCode)
			{
				case Keyboard.UP:
				case "W".charCodeAt():
					upFlag = true;
					break;
				case Keyboard.DOWN:
				case "S".charCodeAt():
					downFlag = true;
					break;
				default:
			}
		}
        
        /**
        * Key up handler for key controls
        */
		private function onKeyUp(e:KeyboardEvent):void {
			switch(e.keyCode)
			{
				case Keyboard.UP:
				case "W".charCodeAt():
					upFlag = false;
					break;
				case Keyboard.DOWN:
				case "S".charCodeAt():
					downFlag = false;
					break;
				case Keyboard.SPACE:
					animate = !animate;
					
					if (!animate) {
						var sprite3D:Sprite3D;
						for each (sprite3D in sprites)
							sprite3D.scale = 1;
					}
					break;
				default:
			}
		}
		
		/**
		 * Mouse stage leave listener for navigation
		 */
        private function onStageMouseLeave(event:Event):void
        {
        	move = false;
        	stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);     
        }
		
		/**
		 * stage listener for resize events
		 */
		private function onResize(event:Event = null):void
		{
			view1.x = stage.stageWidth / 2;
            view1.y = stage.stageHeight / 2;
            view2.x = stage.stageWidth / 2;
            view2.y = stage.stageHeight / 2;
            SignatureBitmap.y = stage.stageHeight - Signature.height;
            text.x = stage.stageWidth - text.width;
		}
	}
}