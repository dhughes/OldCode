namespace ModelGlueApplicationTemplate.views
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using ModelGlue.Core;
	
	/// <summary>
	///		Summary description for layout_main.
	/// </summary>
	public class layout_main : ModelGlue.Core.View
	{
		protected System.Web.UI.WebControls.Label lblBody;
		
		public override void View_Load()
		{
			// Put user code to initialize the page here
			if(modelGlueViewCollection.Exists("body"))
			{
				lblBody.Text = modelGlueViewCollection.GetView("body");
				lblBody.Visible = true;
			}
			//lblBody
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
