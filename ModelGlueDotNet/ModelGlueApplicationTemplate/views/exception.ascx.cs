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
	///		Summary description for exception.
	/// </summary>
	public class exception : ModelGlue.Core.View
	{
		protected System.Web.UI.WebControls.Label lblMessage;
		protected System.Web.UI.WebControls.PlaceHolder PlaceHolder1;
		protected System.Web.UI.WebControls.Label lblType;
		protected System.Web.UI.WebControls.Label lblStack;

		public override void View_Load()
		{
			Exception exception = (Exception)modelGlueViewState.GetValue("exception");

			if(exception.GetType().ToString() == "System.Reflection.TargetInvocationException")
			{
				exception = exception.InnerException;
			}

			lblMessage.Text = exception.Message;
			lblType.Text = exception.GetType().ToString();
			lblStack.Text = exception.StackTrace.Replace(Environment.NewLine, "<br>");
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
