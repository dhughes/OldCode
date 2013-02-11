

<cfset reflection = viewState.getValue('reflection') />

<cfoutput>
<h2>Reflection of #viewState.getValue('className')#:</h2>

<table width="100%">
	<tr>
		<td colspan="2" class="label"><h3>General Information</h3></td>
	</tr>
	<tr>
		<td class="label">Package:</td>
		<td width="100%">#reflection.package#</td>
	</tr>
	<tr>
		<td class="label">
			<cfif reflection.isInterface>
				Interface:
			<cfelse>
				Class:
			</cfif>
		</td>
		<td>#reflection.name#</td>
	</tr>
	<tr>
		<td class="label">
			Modifiers:
		</td>
		<td>#reflection.modifiers#</td>
	</tr>
	
	<cfif NOT reflection.isInterface>
		<tr>
			<td class="label">Inheritance:</td>
			<td colspan="2">
				<cfloop from="#ArrayLen(reflection.superclasses)#" to="1" index="x" step="-1">
					<p style="padding-left: #(ArrayLen(reflection.superclasses) - x)*40#px;">
						<a href="index.cfm?event=ReflectClass&className=#reflection.superclasses[x]#">#reflection.superclasses[x]#</a>
					</p>
				</cfloop>
				<p style="padding-left: #(ArrayLen(reflection.superclasses))*40#px;">#reflection.package#.#reflection.name#</p>
			</td>
		</tr>
	</cfif>
	
	<tr>
		<td class="label">Implemented Interfaces:</td>
		<td>
			<cfif ArrayLen(reflection.interfaces)>
				<cfloop from="1" to="#ArrayLen(reflection.interfaces)#" index="x">
					<a href="index.cfm?event=ReflectClass&className=#reflection.interfaces[x]#">#ListLast(reflection.interfaces[x], ".")#</a>
				</cfloop>
			<cfelse>
				<p><i>None</i></p>
			</cfif>
		</td>
	</tr>
	
	<tr>
		<td class="label">
			Inner Classes:
		</td>
		<td>
			<cfif ArrayLen(reflection.NestedClasses)>
				<cfloop from="1" to="#ArrayLen(reflection.NestedClasses)#" index="x">
					<a href="index.cfm?event=ReflectClass&className=#reflection.NestedClasses[x]#">#ListLast(reflection.NestedClasses[x], ".")#</a>
				</cfloop>
			<cfelse>
				<p><i>None</i></p>
			</cfif>
		</td>
	</tr>
	
	<tr>
		<td class="label">
			String Value:

		</td>
		<td>#reflection.stringrepresentation#</td>
	</tr>
	
	
</table>
	
<cfif ArrayLen(reflection.fields)>
	<br>
	<table width="100%">
		<tr>
			<td colspan="2" class="label"><h3>Fields</h3></td>
		</tr>
		
		<tr>
			<td class="label">
				Field
			</td>
			<td class="label">
				Static Value
			</td>
		</tr>
		<cfloop from="1" to="#ArrayLen(reflection.fields)#" index="x">
			<tr>
				<td>
					#reflection.fields[x].modifiers#
					<cfif NOT reflection.fields[x].IsPrimitive>
						<a href="index.cfm?event=ReflectClass&className=#reflection.fields[x].type#">#reflection.fields[x].type#</a>
					<cfelse>
						#reflection.fields[x].type#
					</cfif>
					#reflection.fields[x].name#
				</td>
				<td>
					<cfif StructKeyExists(reflection.fields[x], "staticValue")>
						<cfif IsObject(reflection.fields[x].staticValue)>
							#reflection.fields[x].staticValue.getClass().getName()#
						<cfelse>
							#reflection.fields[x].staticValue#
						</cfif>
					<cfelse>
						<p><i>None</i></p>
					</cfif>
				</td>
			</tr>
		</cfloop>
	</table>
</cfif>
	
<cfif ArrayLen(reflection.constructors)>
	<br>
	<table width="100%">
		<tr>
			<td colspan="2" class="label"><h3>Constructors</h3></td>
		</tr>
		<cfloop from="1" to="#ArrayLen(reflection.constructors)#" index="x">
			<tr>
				<td>
					#reflection.constructors[x].Modifiers# #reflection.constructors[x].name#(
					<cfloop from="1" to="#ArrayLen(reflection.constructors[x].Parameters)#" index="y">
						<cfif Find(".", reflection.constructors[x].parameters[y]) GT 1>
							<a href="index.cfm?event=ReflectClass&className=#reflection.constructors[x].parameters[y]#">#reflection.constructors[x].parameters[y]#</a>
						<cfelse>
							#reflection.constructors[x].parameters[y]#
						</cfif>
						
						<cfif y IS NOT ArrayLen(reflection.constructors[x].Parameters)>, </cfif>
					</cfloop>
					)
				</td>
			</tr>
		</cfloop>
	</table>		
</cfif>
	
<cfif ArrayLen(reflection.methods)>
	<br>
	<table width="100%">
		<tr>
			<td colspan="2" class="label"><h3>Methods</h3></td>
		</tr>
		<tr>
			<td class="label">
				Return Type
			</td>
			<td class="label">
				Method Signature
			</td>
		</tr>
		<cfloop from="1" to="#ArrayLen(reflection.methods)#" index="x">
			<tr>
				<td>
					<cfif Find(".", reflection.methods[x].returnType) GT 1>
						<a href="index.cfm?event=ReflectClass&className=#reflection.methods[x].returnType#">#reflection.methods[x].returnType#</a>
					<cfelse>
						#reflection.methods[x].returnType#
					</cfif>
				</td>
				<td>
					#reflection.methods[x].name#(
						<cfloop from="1" to="#ArrayLen(reflection.methods[x].Parameters)#" index="y">
							<cfif Find(".", reflection.methods[x].parameters[y]) GT 1>
								<a href="index.cfm?event=ReflectClass&className=#reflection.methods[x].parameters[y]#">#reflection.methods[x].parameters[y]#</a>
							<cfelse>
								#reflection.methods[x].parameters[y]#
							</cfif>
							
							<cfif y IS NOT ArrayLen(reflection.methods[x].Parameters)>, </cfif>
						</cfloop>
					)
				</td>
			</tr>
		</cfloop>
	</table>		
</cfif>

</cfoutput>