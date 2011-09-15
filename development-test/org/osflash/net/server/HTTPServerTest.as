package org.osflash.net.server
{
	import org.osflash.logger.logs.info;
	import org.osflash.logger.logs.warn;
	import org.osflash.net.httpserver.parser.HTTPRequestLexer;
	import org.osflash.net.httpserver.parser.HTTPRequestParser;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="640", height="480")]
	public class HTTPServerTest extends Sprite
	{

		public function HTTPServerTest()
		{
			info('Start');
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
//			const server : HTTPServer = new HTTPServer();
//			const router : IHTTPRouter = server.router;
//			
//			const action0 : IHTTPRouterAction = new HTTPRouterXMLAction(<h1>Home</h1>);
//			router.add(new HTTPRouterService(/\/home/, action0));
//			
//			server.connect();
//			
//			const loader : HTMLLoader = new HTMLLoader();
//			loader.width = 200;
//			loader.height = 200;
//			loader.load(new URLRequest('http://' + server.address + ':' + server.port));
//			addChild(loader);

			const source : String = "\
Host: 0.0.0.0:8888\n\
Accept-Language: en-GB,en\n\
Accept: application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5\n\
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB) AppleWebKit/531.9 (KHTML, like Gecko) AdobeAIR/2.6\n\
Referer: app:/HTTPServerTest.swf\n\
X-Flash-Version: 10,2,153,1\n\
Accept-Encoding: gzip, deflate\n\
Connection: keep-alive\n\
";

			const lexer : HTTPRequestLexer = new HTTPRequestLexer(source);
			const parser : HTTPRequestParser = new HTTPRequestParser(lexer);
			
			warn(parser.parseExpression()['name']);
		}
	}
}
