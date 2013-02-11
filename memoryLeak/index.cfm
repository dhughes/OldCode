<!-- file index.cfm -->

<cfdump var="#application#" />

<cfset request.leaky = application.leaky />
<cfset request.leaky.doSomething() />