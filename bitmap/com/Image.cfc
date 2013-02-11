<cfcomponent name="Image Servcie" displayname="Image Service" output="false">
    <cffunction name="saveImage" access="remote" output="false" returntype="any">
       <cfargument name="data" type="binary" required="true" />
	<cfset imgName = createUUID() />
       <cffile action="write" file="#expandPath("../images/")#/#imgName#.jpg" output="#arguments.data#"/>
	<cfreturn imgName />
    </cffunction>
</cfcomponent>