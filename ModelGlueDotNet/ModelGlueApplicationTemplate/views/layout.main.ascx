<%@ Control Language="c#" AutoEventWireup="false" Codebehind="layout.main.ascx.cs" Inherits="ModelGlueApplicationTemplate.views.layout_main" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<h1>Model-Glue Application</h1>
<asp:Label id="lblBody" runat="server" Visible="false"></asp:Label>
<p>Model-Glue is copyright
	<%= String.Format("{0}/{1}/{2}", DateTime.Now.Month, DateTime.Now.Day, DateTime.Now.Year) %>
	, Joe Rinehart, http://clearsoftware.net.</p>
