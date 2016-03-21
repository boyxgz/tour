

<%@ page import="com.surelution.tour.DeliveryScore" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'deliveryScore.label', default: 'DeliveryScore')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${deliveryScoreInstance}">
            <div class="errors">
                <g:renderErrors bean="${deliveryScoreInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${deliveryScoreInstance?.id}" />
                <g:hiddenField name="version" value="${deliveryScoreInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="driverName"><g:message code="deliveryScore.driverName.label" default="Driver Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deliveryScoreInstance, field: 'driverName', 'errors')}">
                                    <g:textField name="driverName" value="${deliveryScoreInstance?.driverName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="reportDate"><g:message code="deliveryScore.reportDate.label" default="Report Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deliveryScoreInstance, field: 'reportDate', 'errors')}">
                                    <g:datePicker name="reportDate" precision="day" value="${deliveryScoreInstance?.reportDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="reportUser"><g:message code="deliveryScore.reportUser.label" default="Report User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deliveryScoreInstance, field: 'reportUser', 'errors')}">
                                    <g:select name="reportUser.id" from="${com.surelution.tour.User.list()}" optionKey="id" value="${deliveryScoreInstance?.reportUser?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="supercargoName"><g:message code="deliveryScore.supercargoName.label" default="Supercargo Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deliveryScoreInstance, field: 'supercargoName', 'errors')}">
                                    <g:textField name="supercargoName" value="${deliveryScoreInstance?.supercargoName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="trunckNo"><g:message code="deliveryScore.trunckNo.label" default="Trunck No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deliveryScoreInstance, field: 'trunckNo', 'errors')}">
                                    <g:textField name="trunckNo" value="${deliveryScoreInstance?.trunckNo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="unloading"><g:message code="deliveryScore.unloading.label" default="Unloading" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deliveryScoreInstance, field: 'unloading', 'errors')}">
                                    <g:select name="unloading.id" from="${com.surelution.tour.GasUnloading.list()}" optionKey="id" optionValue="formNo" value="${deliveryScoreInstance.unloading.id}"  />
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
