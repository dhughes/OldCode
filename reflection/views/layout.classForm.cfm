
<table border="1" cellpadding="10" cellspacing="0">
	<tr>
		<td>
			<p>Enter the name of a class or interface to reflect.  Note that the class name is case sensitive.</p>
			<cfform action="index.cfm?event=ReflectClass" method="post">
				<cfif viewState.getValue('classNameError', false)>
					<cfoutput>
						<p class="error">The class '#viewState.getValue('className','')#' could not be found.</p>
					</cfoutput>
				</cfif>
				
				<cfinput type="text" name="className" value="#viewState.getValue('className','')#" />
				
				<input type="submit" value="Reflect!">
			</cfform>
		</td>
	</tr>

</table>




	