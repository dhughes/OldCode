<cfcomponent name="Image Service" displayname="Image Service" output="false">
    <cffunction name="saveImage" access="remote" output="false" returntype="string">
		<cfargument name="data" type="binary" required="true" />
		<cfset var imageName = createUUID() />
		<cfset imagePath = "/images/"&imageName&".jpg" />
		<cffile action="write" file="#expandPath(imagePath)#" output="#arguments.data#"/>
		<cfreturn imagePath />
    </cffunction>
	<cffunction name="saveImageAndMailIt" access="remote" output="false" returntype="boolean">
		<cfargument name="data" type="binary" required="true" />
		<cfset var imagePath = saveImage(arguments.data) />
		<cftry>
			<cfmail to="sstroz@alagad.com" from="sstroz@alagad.com" subject="Check this out!!!" type="html">
				<p>Hey, checkthis out!</p>
				<img src="http://imageswithflex.preso/#imagePath#" />
			</cfmail>
			<cfreturn true />
			<cfcatch>
				<cfreturn false />
			</cfcatch>
		</cftry>
		
	</cffunction>
</cfcomponent>