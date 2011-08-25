package org.osflash.net.server
{
	import org.osflash.net.httprouter.IHTTPRouter;
	import org.osflash.net.httprouter.actions.IHTTPRouterAction;
	import org.osflash.net.httprouter.actions.sync.HTTPRouterXMLAction;
	import org.osflash.net.httprouter.services.HTTPRouterService;
	import org.osflash.net.httpserver.HTTPServer;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="640", height="480")]
	public class HTTPServerTest extends Sprite
	{

		public function HTTPServerTest()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			const server : HTTPServer = new HTTPServer();
			const router : IHTTPRouter = server.router;
			
			const action0 : IHTTPRouterAction = new HTTPRouterXMLAction(<h1>Home</h1>);
			router.add(new HTTPRouterService(/\/home/, action0));
			
			server.connect();
			
			const loader : HTMLLoader = new HTMLLoader();
			loader.width = 200;
			loader.height = 200;
			loader.load(new URLRequest('http://' + server.address + ':' + server.port));
			addChild(loader);
		}
	}
}
