

<%@ page import="com.surelution.tour.StockTakingItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'stockTakingItem.label', default: 'StockTakingItem')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${stockTakingItemInstance}">
            <div class="errors">
                <g:renderErrors bean="${stockTakingItemInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${stockTakingItemInstance?.id}" />
                <g:hiddenField name="version" value="${stockTakingItemInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="saleAmount"><g:message code="stockTakingItem.saleAmount.label" default="Sale Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: stockTakingItemInstance, field: 'saleAmount', 'errors')}">
                                    <g:textField name="saleAmount" value="${fieldValue(bean: stockTakingItemInstance, field: 'saleAmount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="stockAmount"><g:message code="stockTakingItem.stockAmount.label" default="Stock Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: stockTakingItemInstance, field: 'stockAmount', 'errors')}">
                                    <g:textField name="stockAmount" value="${fieldValue(bean: stockTakingItemInstance, field: 'stockAmount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="taking"><g:message code="stockTakingItem.taking.label" default="Taking" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: stockTakingItemInstance, field: 'taking', 'errors')}">
                                    <g:select name="taking.id" from="${com.surelution.tour.StockTaking.list()}" optionKey="id" value="${stockTakingItemInstance?.taking?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tank"><g:message code="stockTakingItem.tank.label" default="Tank" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: stockTakingItemInstance, field: 'tank', 'errors')}">
                                    <g:select name="tank.id" from="${com.surelution.tour.GasTank.list()}" optionKey="id" value="${stockTakingItemInstance?.tank?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
