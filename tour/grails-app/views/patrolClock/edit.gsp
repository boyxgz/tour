

<%@ page import="com.surelution.tour.PatrolClock" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrolClock.label', default: 'PatrolClock')}" />
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
            <g:hasErrors bean="${patrolClockInstance}">
            <div class="errors">
                <g:renderErrors bean="${patrolClockInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${patrolClockInstance?.id}" />
                <g:hiddenField name="version" value="${patrolClockInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="clock"><g:message code="patrolClock.clock.label" default="Clock" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolClockInstance, field: 'clock', 'errors')}">
                                    <g:textField name="clock" value="${fieldValue(bean: patrolClockInstance, field: 'clock')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="minute"><g:message code="patrolClock.minute.label" default="Minute" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolClockInstance, field: 'minute', 'errors')}">
                                    <g:textField name="minute" value="${fieldValue(bean: patrolClockInstance, field: 'minute')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="delay"><g:message code="patrolClock.delay.label" default="Delay" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolClockInstance, field: 'delay', 'errors')}">
                                    <g:textField name="delay" value="${fieldValue(bean: patrolClockInstance, field: 'delay')}" />
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
