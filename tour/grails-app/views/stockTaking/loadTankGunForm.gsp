<%@ page import="com.surelution.tour.StockTaking" %>
	<g:form action="saveStockTakingItemOfTank" name="stockTakingItemForm">
		<g:hiddenField name="stockTakingItemId" value="${takingItemId}"/>
		<table>
			<tr>
				<td style="text-align: right">${message(code: 'stockTakingItem.stockAmount.label', default: 'Stock Amount')}:</td>
				<td style="text-align: left"><g:textField name="stockAmount" onkeyup='keyup_s(event)'/></td>
			</tr>
			<g:each in="${guns }" var="gun">
				<tr>
					<td style="text-align: right">${message(code: 'stockTakingItem.saleAmount.label', default: 'Sale Amount')}(${message(code: 'gasGun.label', default: 'Gas Gun')}${gun.gunNo }):</td>
					<td style="text-align: left"><g:textField name="gun_saleAmount_${gun.id}" onkeyup='keyup_s(event)'/></td>
				</tr>
			</g:each>
			<tr>
				<td style="text-align: center" colspan="2"><g:submitButton name="create" class="save" value="${message(code: 'default.button.save.label', default: 'Create')}" onclick="return confirm('${message(code: 'default.button.save.confirm.message', default: 'Are you sure?')}');" /></td>
			</tr>
		</table>
	</g:form>