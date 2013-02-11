<cfsilent><cfapplication name="Reflection" sessionmanagement="true"/>

<!--- 
  If your path to ModelGlue.xml is custom, change it here.  Otherwise,
  it will default to Config/ModelGlue.xml
	<cfset ModelGlue_CONFIG_PATH = expandPath(".") & "/config/ModelGlue.xml" />
--->

<!--- If your path to ModelGlue.cfm is different, you'll need to change this line. --->
</cfsilent><cfinclude template="/ModelGlue/ModelGlue.cfm" />