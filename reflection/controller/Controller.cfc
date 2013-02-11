<cfcomponent displayname="SampleController" output="false" hint="I am a sample model-glue controller." extends="ModelGlue.Core.Controller">

	<cffunction name="Init" access="Public" returnType="Controller" output="false" hint="I build a new SampleController">
		<cfargument name="ModelGlue">
		<cfset super.Init(arguments.ModelGlue) />
		
		<cfset variables.reflector = CreateObject("Component", "#getModelGlue().getConfigSetting("applicationMapping")#.model.reflection.reflector") />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="OnRequestStart" access="Public" returnType="ModelGlue.Core.Event" output="false" hint="I am an event handler.">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<!--- add the applicationMapping to the event --->
		<cfset event.setValue("applicationMapping", getModelGlue().getConfigSetting("applicationMapping")) />
		
		<!--- get the list of all packages --->
		<cfset event.setValue("avaliablePackages", variables.reflector.getAllPackageNames()) />
		
		<cfreturn arguments.event />
	</cffunction>
	
	<cffunction name="OnRequestEnd" access="Public" returnType="ModelGlue.Core.Event" output="false" hint="I am an event handler.">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		<cfreturn arguments.event />
	</cffunction>
	
	<cffunction name="DoReflection" access="Public" returnType="ModelGlue.Core.Event" output="false" hint="I am an event handler.">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		<cfset var reflection = 0/>
		
		<!--- check to see if the class exists --->
		<cfif variables.reflector.isClassName(arguments.event.getValue("className"))>
			<cfset arguments.event.setValue("reflection", variables.reflector.getClassInfo(arguments.event.getValue("className"))) />
			<cfset arguments.event.setValue("error", false) />
			<cfset arguments.event.addResult("reflectionSucceeded") />
	
		<cfelse>
			<!--- the class doesn't exist --->
			<cfset arguments.event.setValue("classNameError", true) />
			<cfset arguments.event.addResult("reflectionFailed") />
		</cfif>	
		
		<cfreturn arguments.event />
	</cffunction>
</cfcomponent>

