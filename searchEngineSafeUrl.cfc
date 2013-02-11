<cfcomponent displayname="searchEngineSafeUrl" hint="This component can decode search engine safe urls.">
	<cfset variables.ignoreList = "" />
	
	<cffunction name="parseURL" hint="I parse the current search engine safe url and set url variables accordingly." returntype="void" access="public" output="false">
		<cfargument name="seperator" hint="I am the sepeartor character which sepearates key/value pairs.  I replace the typical '&amp;'." required="no" default="/" type="string" />
		<cfargument name="equal" hint="I am the equals character which indicates a key's value.  I replace the typical '='.  When parsing the url I am always the first of these characters." required="no" default="-" type="string" />
		<cfset var varAndVal = "" />
		<cfset var varName = "" />
		<cfset var varValue = "" />
		<cfset var urlString = "" />
		
		<!--- make sure both sepeartor and equal are 1 char long --->
		<cfif Len(arguments.seperator) IS NOT 1>
			<cfthrow
				message="Invalid sepeator argument value."
				detail="The seperator argument must be only one character long." />
		</cfif>
		<cfif Len(arguments.equal) IS NOT 1>
			<cfthrow
				message="Invalid equal argument value."
				detail="The equal argument must be only one character long." />
		</cfif>
		<cfif arguments.seperator IS arguments.equal>
			<cfthrow
				message="Invalid seperator and equal argument values."
				detail="The seperator and equal must be different characters." />
		</cfif>
		
		<!---
			Make sure that the CGI.PATH_INFO var is longer than CGI.SCRIPT_NAME + 1.
			If not, then we don't have any url variables.
			I add one to the length of CGI.SCRIPT_NAME because of the / after the 
			file path.  IE: "/index.cfm/"
		--->
		<cfif Len(CGI.PATH_INFO) GT Len(CGI.SCRIPT_NAME) + 1>
			<!--- we have SES URL vars --->
			<cfset urlString = Right(CGI.PATH_INFO, Len(CGI.PATH_INFO) - Len(CGI.SCRIPT_NAME) - 1) />
		
			<!---
				urlString is now a list of name value pairs (separated  by url.seperator)
				loop over the list and extract them 
			--->
			<cfloop list="#urlString#" index="varAndVal" delimiters="#arguments.seperator#">
				<!--- grab the variable name and value --->
				<cfset varName = ListFirst(varAndVal, arguments.equal) />
				<cfset varValue = ListDeleteAt(varAndVal, 1, arguments.equal) />
				<!--- set the url variable --->
				<cfset "URL.#varName#" = varValue />
			</cfloop>
		</cfif>
	</cffunction>
</cfcomponent>
