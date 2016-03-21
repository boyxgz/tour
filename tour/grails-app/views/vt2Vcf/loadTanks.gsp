<%@ page %>
	<g:form action="saveVcfRatio" name="vcfRatioForm">
		<g:hiddenField name="department.id" value="${department.id}"/>
		<g:hiddenField name="month" value="${params.month}"/>
		<table>
			<g:each in="${tanks }" var="tank">
				<tr>
					<td style="text-align: right">${message(code: 'gasTank.label', default: 'Gas Tank')}${tank.tankNo }(${tank.gasType.title }):</td>
					<td style="text-align: left"><g:textField name="gasTank_${tank.id}"/></td>
				</tr>
			</g:each>
			<tr>
				<td style="text-align: center" colspan="2"><g:submitButton name="create" class="save" value="${message(code: 'default.button.save.label', default: 'Create')}" onclick="return confirm('${message(code: 'default.button.save.confirm.message', default: 'Are you sure?')}');" /></td>
			</tr>
		</table>
	</g:form>