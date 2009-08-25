package
{
	import away3dlite.loaders.MQO;
	import away3dlite.templates.SimpleView;

	[SWF(width=800,height=600,backgroundColor=0x666666,frameRate=30)]

	/**
	 * ExMQO
	 * @author katopz
	 *
	 */
	public class ExMQO extends SimpleView
	{
		private var mqo:MQO;

		override protected function create():void
		{
			title += " : Metasequoia Example."
			
			mqo = new MQO("assets/Messerschmitt_Bf_109.mqo");
			view.scene.addChild(mqo);
		}

		override protected function draw():void
		{
			mqo.rotationX++;
			mqo.rotationY++;
			mqo.rotationZ++;
		}
	}
}