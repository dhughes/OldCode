<cfcomponent output="false">
	<cfscript>
		this.name = "ApplicationName";
		this.applicationTimeout = createTimeSpan(0,2,0,0);
		this.clientManagement = false;
		this.loginStorage = "session";
		this.sessionManagement = true;
		this.sessionTimeout = createTimeSpan(0,0,20,0);
		this.setClientCookies = true;
		this.setDomainCookies = false;
		this.scriptProtect = false;
	</cfscript>

	<!--- Application --->
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfset application.QryRdrFactory = createObject("component","factories.model.factory.QueryReaderFactory").init()>
		<cfreturn true>
	</cffunction>

	<cffunction name="onApplicationEnd" returnType="void" output="false">
		<cfargument name="applicationScope" required="true">
	</cffunction>

	<!--- Session --->
	<cffunction name="onSessionStart" returnType="void" output="false">
	</cffunction>

	<cffunction name="onSessionEnd" returnType="void" output="false">
		<cfargument name="sessionScope" type="struct" required="true">
		<cfargument name="appScope" type="struct" required="false">
	</cffunction>

	<!--- Request --->
	<cffunction name="onRequestStart" returnType="boolean" output="false">
		<cfargument name="thePage" type="string" required="true">
		<cfset onApplicationStart()>
		<cfreturn true>
	</cffunction>

	<!--- Error --->
	<cffunction name="onError" returnType="void" output="true">
		<cfargument name="exception" required="true">
		<cfargument name="eventname" type="string" required="true">
		<cfdump var="#arguments#" />
	</cffunction>
</cfcomponent>