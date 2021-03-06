

<cfcomponent displayname="Fortune" hint="I am a web services version of the popular BSD/Linux amusement/game Fortune.">

	<cfparam name="application.inited" default="0" />
	<cfparam name="application.data" default="#StructNew()#" />
	<cfparam name="application.dataCache" default="#StructNew()#" />
	<cfset construct() />
	
	<cffunction name="construct"  hint="I am a pseudo constructor called by the object on initialization." access="private" output="false" returntype="void">
		<cfargument name="reload" hint="Indicates if reload should occur." type="boolean" required="no" default="0" />
		<cfset var pathToIni = GetDirectoryFromPath(getCurrentTemplatePath()) & "/fortune.ini" />
		
		<cfif NOT application.inited OR NOT GetProfileString(pathToIni, "config", "production")>
			<!--- load "topics" --->
			<cfset application.data = LoadData(GetProfileString(pathToIni, "config", "pathToData")) />
			
			<!--- clear the cache --->
			<cfset application.dataCache = StructNew() />
			
			<cfset application.inited = 1 />
		</cfif>
	</cffunction>
	
	<cffunction name="LoadData" access="private" hint="I load the topics into the application scope and return a combined XML structure." output="false" returntype="struct">
		<cfargument name="pathToTopics" hint="I am the path to the topics directory." required="yes" type="string" />
		<cfset var topicFiles = 0 />
		<cfset var fortuneData = StructNew() />
		<cfset var topicName = "" />
		
		<cfdirectory action="list" directory="#arguments.pathToTopics#" name="topicFiles" />

		<cfloop query="topicFiles">
			<cfset fortuneData[topicFiles.name] = ArrayNew(1) />
			<cfset fortuneData[topicFiles.name] = LoadDataFile(arguments.pathToTopics, topicFiles.name) />
		</cfloop>
		
		<cfreturn fortuneData />
	</cffunction>
	
	<cffunction name="LoadDataFile" hint="I load the fortune data from a file" access="private" output="false" returntype="query">
		<cfargument name="pathToTopics" hint="I am the path to the topics directory." required="yes" type="string" />
		<cfargument name="topicFile" hint="I am the topic file to read." required="yes" type="string" />
		<cfset var fortuneData = 0 />
		<cfset var fortuneQuery = QueryNew("stub") />
		<cfset var fortuneLen = ArrayNew(1) />
		
		<!--- read the data file --->
		<cffile action="read"
			file="#arguments.pathToTopics#\#arguments.topicFile#"
			variable="fortuneData" />
		
		<cfset fortuneData = fixAscii(fortuneData) />

		<!--- replace all instances of {cr}{lf}%{cr}{lf} with + and this split the resulting list into an array --->
		<cfset fortuneData = ReplaceNoCase(fortuneData, "#chr(13)##chr(10)#%#chr(13)##chr(10)#" , "+", "all") />
		<cfset fortuneData = ListToArray(fortuneData, "+") />
		<!--- add the data into teh fortune Query ---->
		<cfset QueryAddColumn(fortuneQuery, "data", fortuneData) />
		
		<!--- loop over the query and get the length of each row and store in an array.  Use array to create another column in the query --->
		<cfloop query="fortuneQuery">
			<cfset fortuneLen[fortuneQuery.CurrentRow] = len(fortuneQuery.data) />
		</cfloop>
		<cfset QueryAddColumn(fortuneQuery, "length", fortuneLen) />
		
		<!--- delete the stub column --->
		<cfquery name="fortuneQuery" dbtype="query">
			SELECT data, length
			FROM fortuneQuery
		</cfquery>
			
		<cfreturn fortuneQuery />
	</cffunction>
	
	<cffunction name="getTopicsList" hint="I return a comma delimited list of avaliable topics." access="remote" output="false" returntype="string">
		<cfreturn StructKeyList(application.data)  />
	</cffunction>
	
	<cffunction name="getTopicsArray" hint="I return an array of avaliable topics." access="remote" output="false" returntype="array">
		<cfreturn ListToArray(getTopicsList()) />
	</cffunction>
	
	<cffunction name="getFortune" hint="I return a fortune." access="remote" output="false" returntype="string">
		<cfargument name="topics" hint="I am a comma delimited list of topics to restrict the fortunes to.  If not provided or empty I use all possible topics." required="no" type="string" default="" />
		<cfargument name="minLength" hint="I am the minimum length of the quote to return." required="no" type="numeric" default="0" />
		<cfargument name="maxLength" hint="I am the maximum length of the quote to return." required="no" type="numeric" default="0" />
		<cfset var topicSet = getTopicSet(arguments.topics, arguments.minLength, arguments.maxLength) />
		<cfreturn topicSet.data[RandRange(0, topicSet.recordCount)] />
	</cffunction>
	
	<cffunction name="getFortuneByPattern" hint="I return a fortune based on a provided regular expression" access="remote" output="false" returntype="string">
		<cfargument name="regex" hint="I am the regular expression to match" required="yes" type="string" />
		<cfargument name="caseSensitive" hint="I indicate if the regex is case sensitive" required="no" type="boolean" default="" />
		<cfargument name="topics" hint="I am a comma delimited list of topics to restrict the fortunes to.  If not provided or empty I use all possible topics." required="no" type="string" default="" />
		<cfargument name="minLength" hint="I am the minimum length of the quote to return." required="no" type="numeric" default="0" />
		<cfargument name="maxLength" hint="I am the maximum length of the quote to return." required="no" type="numeric" default="0" />
		<cfset var topicSet = getFortunesByPattern(arguments.regex, arguments.caseSensitive, arguments.topics, arguments.minLength, arguments.maxLength) />
		
		<cfreturn topicSet[RandRange(0, ArrayLen(topicSet))] />
	</cffunction>
	
	<cffunction name="getFortunesByPattern" hint="I return an array of fortunes based on a provided regular expression" access="remote" output="false" returntype="array">
		<cfargument name="regex" hint="I am the regular expression to match" required="yes" type="string" />
		<cfargument name="caseSensitive" hint="I indicate if the regex is case sensitive" required="no" type="boolean" default="" />
		<cfargument name="topics" hint="I am a comma delimited list of topics to restrict the fortunes to.  If not provided or empty I use all possible topics." required="no" type="string" default="" />
		<cfargument name="minLength" hint="I am the minimum length of the quote to return." required="no" type="numeric" default="0" />
		<cfargument name="maxLength" hint="I am the maximum length of the quote to return." required="no" type="numeric" default="0" />
		<cfset var topicSet = getTopicSet(arguments.topics, arguments.minLength, arguments.maxLength) />
		<cfset var returnArray = ArrayNew(1) />
		<cfset var key = hash(arguments.regex & arguments.caseSensitive & arguments.topics & arguments.minLength & arguments.maxLength) />		

		<cfif NOT cashedDataExists(key)>
			<!--- we're going get the data, cache it, and then return it ---> 
			<cfloop query="topicSet">
				<cfif (arguments.caseSensitive AND REFind(arguments.regex, topicSet.data)) OR (NOT arguments.caseSensitive AND REFindNoCase(arguments.regex, topicSet.data))>
					<cfset ArrayAppend(returnArray, topicSet.data) />
				</cfif>
			</cfloop>
		</cfif>
		
		<cfset returnArray = getOrCacheData(key, returnArray) />
		
		<cfreturn returnArray />
	</cffunction>
	
	<cffunction name="getTopicSet" hint="I return structure of topics based on the provided topic list" access="private" output="false" returntype="query">
		<cfargument name="topics" hint="I am a comma delimited list of topics to restrict the fortunes to.  If not provided or empty I use all possible topics." required="yes" type="string" />
		<cfargument name="minLength" hint="I am the minimum length of the quote to return." required="yes" type="numeric" />
		<cfargument name="maxLength" hint="I am the maximum length of the quote to return." required="yes" type="numeric" />
		<cfset var tables = ArrayNew(1) />
		<cfset var topic = "" />
		<cfset var topicSet = QueryNew("data") />
		<cfset var key = hash(arguments.topics & arguments.minLength & arguments.maxLength) />		

		<cfif arguments.minLength AND arguments.maxLength AND arguments.minLength GT arguments.maxLength>
			<cfthrow type="fortune.invalidlengths"
				message="The minLength argument can not be larger than the maxLength argument." />
		</cfif>
		
		<cfif NOT cashedDataExists(key)>
			<cfif Len(arguments.topics)>
				<!--- if topics are specified return only from that set --->
				<cfloop list="#arguments.topics#" index="topic">
					<cfset ArrayAppend(tables, topic) />
				</cfloop>
				
			<cfelse>
				<!--- if no topics specified return all topics --->
				<cfset tables = StructKeyArray(application.data) />
				
			</cfif>
			
			<!--- check to see if the tables array has a length --->
			<cfif ArrayLen(tables)>			
				<cfquery name="topicSet" dbtype="query">
					<cfloop from="1" to="#ArrayLen(tables)#" index="x">
						<CFIF x IS NOT 1>
							UNION
						</CFIF>
						SELECT data
						FROM application.data.#tables[x]#
						<cfif arguments.minLength OR arguments.maxLength>
							WHERE 
								<cfif arguments.minLength>
									length >= #arguments.minLength#
								</cfif>
								<cfif arguments.minLength AND arguments.maxLength>
									AND
								</cfif>
								<cfif arguments.maxLength>
									length <= #arguments.maxLength#
								</cfif>
						</cfif>
					</cfloop> 
				</cfquery>
			</cfif>
		</cfif>
		
		<cfset topicSet = getOrCacheData(key, topicSet) />
				
		<cfreturn topicSet />
	</cffunction>
	
	<cffunction name="fixAscii" hint="I fix bad ascii chars" access="private" output="false" returntype="string">
		<cfargument name="string" hint="The string to inspect and fix." required="yes" type="string" />
		
		<!--- fix linebreak characters --->
		<cfset arguments.string = ReReplace(arguments.string, "[\n]" , "#chr(13)##chr(10)#", "all") />		
		<cfset arguments.string = ReReplace(arguments.string, "[\r][\r]" , "#chr(13)#", "all") />		

		<cfreturn ReReplace(arguments.string, "#chr(8)#|____" , "", "all") />
	</cffunction>
	
	<cffunction name="cashedDataExists" hint="I indicate if data is cached for a particular request" access="private" output="false" returntype="boolean">
		<cfargument name="key" hint="I am the key used to store stuff in the cache." required="yes" type="string" />
		<cfreturn StructKeyExists(application.dataCache, arguments.key) />		
	</cffunction>
	
	<cffunction name="cacheData" hint="I cache data into the application scope." access="private" output="false" returntype="void">
		<cfargument name="key" hint="I am the key used to store data in the cache." required="yes" type="string" />
		<cfargument name="data" hint="I am the data to store in the cache." required="yes" type="any" />
		<cfset application.dataCache[arguments.key] = arguments.data />		
	</cffunction>
	
	<cffunction name="getCacheData" hint="I return cached data from the application scope." access="private" output="false" returntype="any">
		<cfargument name="key" hint="I am the key used to store data in the cache." required="yes" type="string" />
		<cfreturn application.dataCache[arguments.key] />		
	</cffunction>
	
	<cffunction name="getOrCacheData" hint="I the provided key exists I return the data for it.  Otherwise, I cache the provided data with the provided key." access="private" output="false" returntype="any">
		<cfargument name="key" hint="I am the key used to store data in the cache." required="yes" type="string" />
		<cfargument name="data" hint="I am the data to store in the cache." required="yes" type="any" />
		
		<cfif cashedDataExists(arguments.key)>
			<cfset arguments.data = getCacheData(arguments.key) />		
		<cfelse>
			<cfset cacheData(arguments.key, arguments.data) />
		</cfif>
		
		<cfreturn arguments.data />
	</cffunction>

</cfcomponent>