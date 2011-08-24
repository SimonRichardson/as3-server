package org.osflash.net.router
{
	import org.osflash.logger.logs.info;
	import org.osflash.net.httprouter.HTTPRouter;
	import org.osflash.net.httprouter.actions.HTTPRouterCallbackAction;
	import org.osflash.net.httprouter.actions.HTTPRouterXMLAction;
	import org.osflash.net.httprouter.actions.IHTTPRouterAction;
	import org.osflash.net.httprouter.actions.IHTTPRouterAsyncAction;
	import org.osflash.net.httprouter.services.HTTPRouterService;
	import org.osflash.net.net_namespace;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;


	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="640", height="480")]
	public class RouterTest extends Sprite
	{

		use namespace net_namespace;
		
		public function RouterTest()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			const router : HTTPRouter = new HTTPRouter();
			
			const action0 : IHTTPRouterAction = new HTTPRouterXMLAction(<h1>Home</h1>);
			router.add(new HTTPRouterService(/\/home/, action0));
			
			const action1 : IHTTPRouterAsyncAction = new HTTPRouterCallbackAction(handlerCallback);
			action1.resultSignal.add(handleResultSignal);
			router.add(new HTTPRouterService(/\/callback/, action1));
			
			info(router.contains(/\/home/));
			info(router.contains(/\/callback/));
			info(router.length);
			
			router.removeByPattern(/\/home/);
			
			info(router.length);
			
			IHTTPRouterAsyncAction(router.getAt(0).action).execute();
		}
		
		private final function handlerCallback() : String
		{
			return '<h1>Callback</h1>';
		}
		
		private function handleResultSignal(value : String) : void
		{
			info('Result:', value);
		}
	}
}
