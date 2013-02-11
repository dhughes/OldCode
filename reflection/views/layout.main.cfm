<html>
	<head>
		<cfoutput>
			<link href="#viewState.getValue("applicationMapping")#/styles/styles.css" rel="stylesheet" type="text/css">
		</cfoutput>
	</head>
	<body>
	
	<h1>Java Object Reflector</h1>

	<cfif viewCollection.exists("body")>
		<cfoutput>#viewCollection.getView("body")#</cfoutput>
	</cfif>
	
	<p class="footer">
		<cfoutput>
			Java Object Reflector is copyright #datePart("yyyy", now())#, Doug Hughes, <a href="http://www.doughughes.net">http://www.doughughes.net</a> and <a href="http://www.alagad.com">http://www.alagad.com</a>.
		</cfoutput>
	</p>
	
	</body>
</html>


