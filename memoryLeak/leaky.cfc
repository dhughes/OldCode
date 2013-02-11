<!--- file: leaky.cfc --->
<cfcomponent name="test">
   <cfset variables.holderArray = arrayNew(1)>
   
   <cffunction name="init">
      <cfreturn this>
   </cffunction>
   
   <cffunction name="doSomething">
      <cfset var idx = "">

      <cfloop from="1" to="100" index="idx">
         <cfset arrayAppend(variables.holderArray, createObject("component","leaky").init() ) />
      </cfloop>
   </cffunction>
</cfcomponent>