<cfinvoke
	webservice="http://local.scratch/fortune/fortune.cfc?wsdl"
 	method="getTopicsList"
   	returnvariable="foo">
</cfinvoke>

<cfdump var="#foo#">