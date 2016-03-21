

<%@ page import="com.surelution.tour.PatrolLog" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrolLog.label', default: 'PatrolLog')}" />
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
            <g:hasErrors bean="${patrolLogInstance}">
            <div class="errors">
                <g:renderErrors bean="${patrolLogInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${patrolLogInstance?.id}" />
                <g:hiddenField name="version" value="${patrolLogInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="logTime"><g:message code="patrolLog.logTime.label" default="Log Time" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolLogInstance, field: 'logTime', 'errors')}">
                                    <g:datePicker name="logTime" precision="day" value="${patrolLogInstance?.logTime}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="patrol"><g:message code="patrolLog.patrol.label" default="Patrol" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolLogInstance, field: 'patrol', 'errors')}">
                                    <g:select name="patrol.id" from="${com.surelution.tour.Patrol.list()}" optionKey="id" value="${patrolLogInstance?.patrol?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="remark"><g:message code="patrolLog.remark.label" default="Remark" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolLogInstance, field: 'remark', 'errors')}">
                                    <g:textField name="remark" value="${patrolLogInstance?.remark}" />
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
