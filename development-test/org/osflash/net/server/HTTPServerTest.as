package org.osflash.net.server
{
	import org.osflash.logger.logs.warn;
	import org.osflash.net.httpserver.headers.request.HTTPRequestHeader;
	import org.osflash.net.httpserver.headers.request.HTTPRequestHeaders;
	import org.osflash.net.httpserver.headers.request.HTTPRequestMethodHeader;
	import org.osflash.net.httpserver.types.HTTPRequestMethodType;
	import org.osflash.net.httpserver.types.HTTPRequestProtocolType;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.ByteArray;

	
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
		
			const byteArray : ByteArray = new ByteArray();
			byteArray.writeUTF(source);
			
			byteArray.position = 2;
			
			const headers : HTTPRequestHeaders = new HTTPRequestHeaders();
			var buffer : String = '';
			
			const total : int = byteArray.length;
			while(byteArray.position < total)
			{
				const byte : int = byteArray.readByte();
				if(byte >= 33 && byte <= 126)
				{
					buffer += String.fromCharCode(byte);
				}
				else if(byte == 13)
				{
					if(buffer.length > 0) 
					{
						const colonIndex : int = buffer.indexOf(":");
						if(colonIndex > 0)
						{
							const name : String = buffer.substr(0, colonIndex);
							const value : String = buffer.substr(colonIndex + 1);
							
							headers.add(new HTTPRequestHeader(name, value));
						}
						else
						{
							// try and see if it's a method
							const spaceIndex0 : int = buffer.indexOf(' ');
							const spaceIndex1 : int = buffer.lastIndexOf(' ');
							const method : HTTPRequestMethodType = HTTPRequestMethodType.create(buffer.substr(0, spaceIndex0));
							const url : String = buffer.substr(spaceIndex0 + 1, spaceIndex0 - spaceIndex1);
							const protocol : HTTPRequestProtocolType = HTTPRequestProtocolType.create(buffer.substr(spaceIndex1 + 1));
							
							headers.add(new HTTPRequestMethodHeader(method, url, protocol));
						}
					}
					
					buffer = '';
				}
			}
			
			for(var i : int = 0; i<headers.length; i++)
			{
				warn(headers.getAt(i).name);
			}
		}
	}
}
