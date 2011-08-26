package org.osflash.net.server
{
	import org.osflash.logger.logs.info;
	import org.osflash.net.httpserver.parser.HTTPRequestLexer;
	import org.osflash.net.httpserver.parser.HTTPRequestParser;
	import org.osflash.net.httpserver.parser.expressions.HTTPRequestBreakExpression;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="640", height="480")]
	public class HTTPServerTest extends Sprite
	{

		public function HTTPServerTest()
		{
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
			
			const source : String = "GET / HTTP/1.1\r\n\
\r\n\
Host: 0.0.0.0:8888\r\n\
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en) AppleWebKit/531.9 (KHTML, like Gecko) AdobeAIR/2.6\r\n\
Accept: application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5\r\n\
Accept-Language: en,en\r\n\
Referer: app:/HTTPServerTest.swf\r\n\
x-flash-version: 10,2,153,1\r\n\
Accept-Encoding: gzip, deflate\r\n\
Connection: keep-alive\r\n\
";
			const lexer : HTTPRequestLexer = new HTTPRequestLexer(source);
			const parser : HTTPRequestParser = new HTTPRequestParser(lexer);
			
			info(HTTPRequestBreakExpression(parser.parseExpression()).right);
		}
	}
}
