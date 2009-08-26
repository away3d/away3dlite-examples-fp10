package
{
	import away3dlite.loaders.MQO;
	import away3dlite.templates.SimpleView;

	[SWF(backgroundColor="#000000", frameRate="30", quality="LOW", width="800", height="600")]

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