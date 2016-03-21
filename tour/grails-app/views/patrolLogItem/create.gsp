

<%@ page import="com.surelution.tour.PatrolLogItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrolLogItem.label', default: 'PatrolLogItem')}" />
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
            <g:hasErrors bean="${patrolLogItemInstance}">
            <div class="errors">
                <g:renderErrors bean="${patrolLogItemInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="answer"><g:message code="patrolLogItem.answer.label" default="Answer" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolLogItemInstance, field: 'answer', 'errors')}">
                                    <g:textField name="answer" value="${fieldValue(bean: patrolLogItemInstance, field: 'answer')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="patrolLogItem.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolLogItemInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${patrolLogItemInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="patrolLog"><g:message code="patrolLogItem.patrolLog.label" default="Patrol Log" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolLogItemInstance, field: 'patrolLog', 'errors')}">
                                    <g:select name="patrolLog.id" from="${com.surelution.tour.PatrolLog.list()}" optionKey="id" value="${patrolLogItemInstance?.patrolLog?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="topic"><g:message code="patrolLogItem.topic.label" default="Topic" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolLogItemInstance, field: 'topic', 'errors')}">
                                    <g:select name="topic.id" from="${com.surelution.tour.PatrolLogTopic.list()}" optionKey="id" value="${patrolLogItemInstance?.topic?.id}"  />
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
