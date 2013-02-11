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
	///		Summary description for display_name.
	/// </summary>
	public class display_name : ModelGlue.Core.View
	{
		protected System.Web.UI.WebControls.Label lblUcase;

		public override void View_Load()
		{
			lblUcase.Text = (string)modelGlueViewState.GetValue("uppername", "");
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
