<%@ Control Language="c#" AutoEventWireup="false" Codebehind="form_name.ascx.cs" Inherits="NameUpperCaser.views.form_name" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<form action="index.aspx?event=UpperCaseTheName" method="post">
	<P><asp:TextBox id="name" runat="server"></asp:TextBox>
		<asp:Button id="Button1" runat="server" Text="Go"></asp:Button></P>
</form>
