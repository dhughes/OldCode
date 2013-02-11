<cfcomponent>
	<cfset variables.setupVal = "">
	<cfset variables.testVal = "">
	<cfset setup() />
	
	<cffunction name="setup" access="remote">
		<cfset variables.setupVal = expandpath('/coldspring')>	
	</cffunction>
	
	<cffunction name="test" access="remote" returntype="string">
		<cfset var str = "" />		
		<cfset variables.testVal = expandpath('/coldspring')>
		<cfset str = "setup = "&variables.setupval&chr(10)&"test = "&variables.testVal>
		<cfreturn  str/>
	</cffunction>
</cfcomponent>