

<%@ page import="com.surelution.tour.PatrolLogAudit" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrolLogAudit.label', default: 'PatrolLogAudit')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${patrolLogAuditInstance}">
            <div class="errors">
                <g:renderErrors bean="${patrolLogAuditInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="auditTime"><g:message code="patrolLogAudit.auditTime.label" default="Audit Time" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolLogAuditInstance, field: 'auditTime', 'errors')}">
                                    <g:datePicker name="auditTime" precision="day" value="${patrolLogAuditInstance?.auditTime}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="correct"><g:message code="patrolLogAudit.correct.label" default="Correct" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolLogAuditInstance, field: 'correct', 'errors')}">
                                    <g:checkBox name="correct" value="${patrolLogAuditInstance?.correct}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="descript"><g:message code="patrolLogAudit.descript.label" default="Descript" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolLogAuditInstance, field: 'descript', 'errors')}">
                                    <g:textField name="descript" value="${patrolLogAuditInstance?.descript}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="patrolLog"><g:message code="patrolLogAudit.patrolLog.label" default="Patrol Log" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolLogAuditInstance, field: 'patrolLog', 'errors')}">
                                    <g:select name="patrolLog.id" from="${com.surelution.tour.PatrolLog.list()}" optionKey="id" value="${patrolLogAuditInstance?.patrolLog?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="user"><g:message code="patrolLogAudit.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolLogAuditInstance, field: 'user', 'errors')}">
                                    <g:select name="user.id" from="${com.surelution.tour.User.list()}" optionKey="id" value="${patrolLogAuditInstance?.user?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
