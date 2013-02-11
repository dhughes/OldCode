using System;
using ModelGlue;
using ModelGlue.Core;

namespace ModelGlueApplicationTemplate.controller
{
	/// <summary>
	/// I am a sample model-glue controller." extends="ModelGlue.Core.Controller
	/// </summary>
	public class Controller: ModelGlue.Core.Controller
	{
		/// <summary>
		/// I configure the Controller
		/// </summary>
		/// <param name="modelGlue"></param>
		public Controller(ModelGlue.ModelGlue modelGlue):base(modelGlue)
		{
			/*
			 * Configure your controller here.  This is a great place to load config beans.
			 */
		}

		/// <summary>
		/// I am an event handler.
		/// </summary>
		/// <param name="eventObj">I am the Event object</param>
		/// <returns></returns>
		public new Event OnRequestStart(Event eventObj)
		{
			// You can put stuff here that may be needed by all events
			return eventObj;
		}

		/// <summary>
		/// I am an event handler.
		/// </summary>
		/// <param name="eventObj">I am the Event object</param>
		/// <returns></returns>
		public new Event OnRequestEnd(Event eventObj)
		{
			/*
			 * You can do stuff here, but it won't affect what the user sees.
			 * By the time you've gotten here, the views have been rendered.
			 */

			return eventObj;
		}

	}
}
