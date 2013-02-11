namespace NameUpperCaser.views
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using ModelGlue.Core;

	/// <summary>
	///		Summary description for form_name1.
	/// </summary>
	public class form_name : ModelGlue.Core.View
	{
		protected System.Web.UI.WebControls.TextBox name;
		protected System.Web.UI.WebControls.Button Button1;

		public override void View_Load()
		{
			name.Text = (string)modelGlueViewState.GetValue("name", "");
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
