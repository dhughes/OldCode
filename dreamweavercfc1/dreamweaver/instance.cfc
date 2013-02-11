<cfcomponent displayname="Template" hint="I am a CFC representing a Dreamweaver template.">

	<cfset variables.instance = "" />
	
	<!--- readInstanceFromFile --->
	<cffunction name="readInstanceFromFile" access="public" hint="I read a DWT template from a file." output="false" returntype="void">
		<cfargument name="file" hint="I am the DWT file to read." required="yes" type="string" />
		<cfset var html = "" />
		
		<cffile action="read"
			file="#arguments.file#"
			variable="html" />
			
		<cfset setInstance(html) />
	</cffunction>
	
	<!--- writeInstanceToFile --->
	<cffunction name="writeInstanceToFile" access="public" hint="I write a DWT temlpate to a file." output="false" returntype="void">
		<cfargument name="file" hint="I am the DWT file to write." required="yes" type="string" />
		
		<cffile action="write"
			file="#arguments.file#"
			output="#getInstance()#" />
			
	</cffunction>
	
	<!--- getRegionNames --->
	<cffunction name="getRegionNames" access="public" hint="I return the template's region names." output="false" returntype="array">
		<cfset var regions = getRegions() />
		<cfset var names = ArrayNew(1) />
		<cfset var x = 0 />
		
		<cfloop from="1" to="#ArrayLen(regions)#" index="x">
			<cfset names[x] = regions[x].name />
		</cfloop>
		
		<cfreturn names>
	</cffunction>
	
	<!--- getRegions --->
	<cffunction name="getRegions" access="public" hint="I return a structure of region information." output="false" returntype="array">
		<cfset var html = getInstance() />
		<cfset var start = 1>
		<cfset var regions = ArrayNew(1)>
		
		<!--- loop over the document for each editable region --->
		<cfloop condition="#hasNextEditableRegion(start)#">
			<cfset ArrayAppend(regions, findNextEditableRegion(start))>
			<cfset start = regions[ArrayLen(regions)].end>
		</cfloop>
		
		<cfreturn regions>
	</cffunction>
	
	<!--- hasNextEditableRegion --->
	<cffunction name="hasNextEditableRegion" access="private" output="false" returntype="boolean" hint="I find out if there is another editable region in the template.">
		<cfargument name="startSearch" hint="The character to start looking from." required="yes" type="numeric" />
		<cfset var html = getInstance() />
		
		<!--- determine if there's an editable region --->
		<cfreturn Find("<!" & "-- InstanceBeginEditable",  html, arguments.startSearch)>
	</cffunction>
	
	<!--- findNextEditableRegion --->
	<cffunction name="findNextEditableRegion" access="private" output="false" returntype="struct" hint="I find the next editable region in a dwt.">
		<cfargument name="startSearch" hint="The character to start looking from." required="yes" type="numeric" />
		<cfset var html = getInstance() />
		<cfset var region = StructNew()>
		<cfset var left = 0>
		<cfset var right = 0>
		
		<!--- begining at start, find the next InstanceBeginEditable starting point --->
		<cfset region.start = ReFind("<!" & "-- InstanceBeginEditable [=""a-zA-Z]+ -->", html, arguments.startSearch)>
		<cfset region.end = ReFind("<!" & "-- InstanceEndEditable -->", html, region.start) + len("<!" & "-- InstanceEndEditable -->")>
		
		<!--- grab the entire region --->
		<cfset region.content = mid(html, region.start, region.end - region.start)>
		<cfset region.name = mid(region.content, 34, Find(""" -->", region.content, 34) - 34)>
		
		<!--- grab the contents of the region --->
		<cfset left = Find(" -->", region.content, 1) + 4>
		<cfset right = Find("<!" & "-- InstanceEndEditable -->", region.content, left)>
		<cfset region.defaultValue = Mid(region.content, left, right-left)>
		
		<cfreturn region>
	</cffunction>
	
	<!--- setRegionValue --->
	<cffunction name="setRegionValue" access="public" hint="I set a region's values." output="false" returntype="void">
		<cfargument name="region" hint="I am the name of the region we're setting the value of." required="yes" type="string" />
		<cfargument name="value" hint="I am the value for this region." required="yes" type="string" />
		<cfset var html = getInstance() />
		<cfset var rexpression = "<!--[\s]+InstanceBeginEditable[\s]+name[\s]*=[\s]*['""]#arguments.region#['""][\s]+-->.*?<!--[\s]+InstanceEndEditable[\s]+-->" />
		
		<cfset html = REReplaceNoCase(html, rexpression, '<!' & '-- InstanceBeginEditable name="#arguments.region#" -->#arguments.value#<!' & '-- InstanceEndEditable -->') />
		
		<cfset setInstance(html) />
	</cffunction>
	
	<!--- getRegionValue --->
	<cffunction name="getRegionValue" access="public" hint="I return a region's value." output="false" returntype="string">
		<cfargument name="region" hint="I am the name of the region we're setting the value of." required="yes" type="string" />
		<cfset var regions = getRegions() />
		<cfset var value = "" />
		<cfset var found = false />
		<cfset var x = 0 />
		
		<cfloop from="1" to="#ArrayLen(regions)#" index="x">
			<cfoutput>#regions[x].name#</cfoutput>
			<cfif regions[x].name IS arguments.region>
				<cfset value = regions[x].defaultvalue />
				<cfset found = true />
				<cfbreak />
			</cfif>
		</cfloop>
		
		<cfif NOT found>
			<cfthrow
				type="dreamweaver.instance.regionNotFound"
				message="A region named '#arguments.region#' could not be found in the template instance." />
		</cfif>
		
		<cfreturn value />
	</cffunction>
	
	<!--- template --->
    <cffunction name="setInstance" access="public" output="false" returntype="void">
        <cfargument name="template" hint="I am the html for the DWT" required="yes" type="string" />
        <cfset variables.template = arguments.template />
    </cffunction>
    <cffunction name="getInstance" access="public" output="false" returntype="string">
        <cfreturn variables.template />
    </cffunction>
</cfcomponent>