<cfcomponent name="BaseQueryParser" displayname="BaseQueryParser">
	<cffunction name="init" access="public" returntype="factories.model.data.BaseQueryParser" output="false">
		<cfargument name="qryData" type="string" default="" />
		<cfif len(arguments.qryData) GT 0>
			<cfset setQueryData(arguments.qryData)>
		<cfelse>
			<cfthrow message="Argument qryData cannot be an empty string!" detail="#qryData#" />
		</cfif>
		<cfreturn this />
	</cffunction>

	<cffunction name="getQueryTextAsQuery" access="public" returntype="query" output="false">
		<cfthrow message="This is a base class." detail="You must extend BaseQueryReader and implement a working version of getQueryDataAsQuery()." />
	</cffunction>

	<cffunction name="setQueryData" access="public" returntype="void" output="false">
		<cfargument name="qryData" type="string" required="true">
		<cfset variables.qryData = arguments.qryData >
	</cffunction>
	<cffunction name="getQueryData" access="public" returntype="string" output="false">
		<cfreturn variables.qryData />
	</cffunction>
</cfcomponent>