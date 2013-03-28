package sys
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import ru.yelbota.flex.as3jobs.Job;
	import ru.yelbota.flex.as3jobs.libs.JobUrlLoader;

	public class Config
	{
		private var  _webURL:String;
		private var configXML:XML;
		private var XML_URL:String = "config.xml";
		private var XMLURL:URLRequest = new URLRequest(XML_URL);
		private var _sourceData: XMLList;//ArrayCollection = new ArrayCollection();
		public function Config()
		{
			Job.start(function():void {
				configXML = XML(JobUrlLoader.loadText(XMLURL));
				webURL = configXML.webURL;
				_sourceData  = configXML.child("sources").children();
				//Alert.show(configXML.child("sources").children()+"");
			});
			
		}
		public function get webURL():String
		{
			return _webURL;
		}

		public function set webURL(value:String):void
		{
			_webURL = value;
		}

		public function get sourceData():XMLList
		{
			return _sourceData;
		}

		public function set sourceData(value:XMLList):void
		{
			_sourceData = value;
		}


	}
}