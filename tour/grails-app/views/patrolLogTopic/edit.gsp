

<%@ page import="com.surelution.tour.PatrolLogTopic" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrolLogTopic.label', default: 'PatrolLogTopic')}" />
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
            <g:hasErrors bean="${patrolLogTopicInstance}">
            <div class="errors">
                <g:renderErrors bean="${patrolLogTopicInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${patrolLogTopicInstance?.id}" />
                <g:hiddenField name="version" value="${patrolLogTopicInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="index"><g:message code="patrolLogTopic.index.label" default="Index" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolLogTopicInstance, field: 'index', 'errors')}">
                                    <g:textField name="index" value="${fieldValue(bean: patrolLogTopicInstance, field: 'index')}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="shortTitle"><g:message code="patrolLogTopic.shortTitle.label" default="shortTitle" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolLogTopicInstance, field: 'shortTitle', 'errors')}">
                                    <g:textField name="shortTitle" value="${patrolLogTopicInstance?.shortTitle}" style='width:300px;' />
                                </td>
                            </tr>
                                                    
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="title"><g:message code="patrolLogTopic.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolLogTopicInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${patrolLogTopicInstance?.title}" style='width:500px;' />
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
