<%@ Control Language="c#" AutoEventWireup="false" Codebehind="exception.ascx.cs" Inherits="NameUpperCaser.views.exception" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<h3>Oops!</h3>
<table>
	<tr>
		<td valign="top"><b>Message</b></td>
		<td valign="top">
			<asp:Label id="lblMessage" runat="server"></asp:Label></td>
	</tr>
	<tr>
		<td valign="top"><b>Type</b></td>
		<td valign="top">
			<asp:Label id="lblType" runat="server"></asp:Label></td>
	</tr>
	<tr>
		<td valign="top"><b>Stack Trace</b></td>
		<td valign="top">
			<%--
			<cfset tagCtxArr="exception.TagContext" />
			<cfloop index="i" from="1" to="#ArrayLen(tagCtxArr)#">
				<cfset tagCtx="tagCtxArr[i]" />
				#tagCtx['template']# (#tagCtx['line']#)<br>
			</cfloop>
			--%>
			<asp:Label id="lblStack" runat="server"></asp:Label>
		</td>
	</tr>
</table>
