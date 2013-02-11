<cfcomponent name="WddxQueryParser" displayname="WddxQueryParser" extends="BaseQueryParser">
	<cffunction name="init" access="public" returntype="factories.model.data.WddxQueryParser" output="false">
		<cfargument name="qryData" type="string" default="" />
		<cfset super.init(argumentCollection=arguments)>
		<cfreturn this />
	</cffunction>

	<cffunction name="getQueryTextAsQuery" access="public" returntype="query" output="false">
		<cfset var qryData = getQueryData()>
		<cfset var qry = 0>
		<cfwddx action="wddx2cfml" input="#qryData#" output="qry" />
		<cfreturn qry />
	</cffunction>
</cfcomponent>