<cfcomponent name="CsvQueryParser" displayname="CsvQueryParser" extends="BaseQueryParser">
	<cffunction name="init" access="public" returntype="factories.model.data.CsvQueryParser" output="false">
		<cfargument name="qryData" type="string" default="" />
		<cfset super.init(argumentCollection=arguments)>
		<cfreturn this />
	</cffunction>

	<cffunction name="getQueryTextAsQuery" access="public" returntype="query" output="false">

		<cfset var qryData = listToArray(getQueryData(),chr(10))>
		<cfset var i = 0>
		<cfset var r = 0>
		<cfset var row = "">
		<cfset var columns = qryData[1]>
		<!--- assumes first row is the column list --->
		<cfset var qry = queryNew(columns)>

		<cfset columns = listToArray(columns,",")>
		<cfloop from="2" to="#arrayLen(qryData)#" index="i">
			<cfset row = listToArray(qryData[i],",")>
			<cfset queryAddRow(qry)>
			<cfloop from="1" to="#arrayLen(row)#" index="r">
				<cfset querySetCell(qry,columns[r],row[r])>
			</cfloop>
		</cfloop>
		<cfreturn qry />
	</cffunction>
</cfcomponent>