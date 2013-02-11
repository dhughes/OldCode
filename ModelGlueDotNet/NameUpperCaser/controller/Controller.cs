using System;
using ModelGlue;
using ModelGlue.Core;

namespace NameUpperCaser.controller
{
	/// <summary>
	/// I am a sample model-glue controller.
	/// </summary>
	public class Controller: ModelGlue.Core.Controller
	{
		public Object _config = null;

		public Controller(ModelGlue.ModelGlue modelGlue):base(modelGlue)
		{
			/*
			 * Load a simple config bean from the /Beans folder.
			 * The bean loaded has a getConfigValue(name) method to get at
			 * its settings.  You'll see it used in DoHomepage()
			 */
			_config = (ModelGlue.Bean.CommonBeans.SimpleConfig)modelGlue.GetConfigBean("SampleConfig.xml");
		}

		public new Event OnRequestStart(Event eventObj)
		{
			// You can put stuff here that may be needed by all events
			eventObj.SetValue("datasourceName", "myDatasource");

			// Show off the IoC config beans a little
			// TODO: set complex example

			return eventObj;
		}

		public new Event OnRequestEnd(Event eventObj)
		{
			/*
			 * You can do stuff here, but it won't affect what the user sees.
			 * By the time you've gotten here, the views have been rendered.
			 */

			return eventObj;
		}

		public Event DoHomepage(Event eventObj)
		{
			// Show that arguments get passed along nicely
			eventObj.SetValue("argValue", eventObj.GetArgument("SampleArg"));

			return eventObj;
		}

		public Event DoUpper(Event eventObj)
		{
			/*
			 * Get the name from the event's state collection:
			 * Syntax: arguments.event.SetValue(name, [optional] default value)
			 */
			string name = (string)eventObj.GetValue("name");

			if(name.ToLower() == "doug")
			{
				throw(new Exception("Doug causes more work!"));
			} 
			else if(name.ToLower() == "joe")
			{
				throw(new Exception("Joe? We don't need no stinking Joe!!"));
			} 
			else 
			{
				eventObj.SetValue("uppername", name.ToUpper());
			}

			return eventObj;
		}
	}
}
