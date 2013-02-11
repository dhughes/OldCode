<cfset qryData = fileRead(expandPath("lib/data.wddx"))>
<cfset qry = application.QryRdrFactory.getQueryReader(qryData)>
<cfdump var="#qry.getQueryData()#" />
<cfdump var="#qry.getQueryTextAsQuery()#" />

<cfset qryData = fileRead(expandPath("lib/data.txt"))>
<cfset qry = application.QryRdrFactory.getQueryReader(qryData)>
<cfdump var="#qry.getQueryData()#" />
<cfdump var="#qry.getQueryTextAsQuery()#" />