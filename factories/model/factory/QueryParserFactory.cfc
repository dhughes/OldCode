<cfcomponent name="QueryParserFactory" displayname="QueryParserFactory">

	<cffunction name="init" access="public" returntype="factories.model.data.QueryParserFactory" output="false">
		<cfreturn this />
	</cffunction>

	<cffunction name="getQueryReader" access="public" returntype="factories.model.data.BaseQueryParser" output="false">
		<cfargument name="qryData" type="string" required="true" />

		<cfset var reader = 0>

		<cftry>
			<cfif find("wddx",arguments.qryData)>
				<cfset reader = createObject("component","factories.model.data.WddxQueryParser").init(arguments.qryData)>
			<cfelse>
				<cfset reader = createObject("component","factories.model.data.CsvQueryParser").init(arguments.qryData)>
			</cfif>

			<cfcatch>
				<cfrethrow />
			</cfcatch>

		</cftry>

		<cfreturn reader />

	</cffunction>
</cfcomponent>