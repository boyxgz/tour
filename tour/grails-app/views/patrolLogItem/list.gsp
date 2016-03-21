
<%@ page import="com.surelution.tour.PatrolLogItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrolLogItem.label', default: 'PatrolLogItem')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'patrolLogItem.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="answer" title="${message(code: 'patrolLogItem.answer.label', default: 'Answer')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'patrolLogItem.description.label', default: 'Description')}" />
                        
                            <th><g:message code="patrolLogItem.patrolLog.label" default="Patrol Log" /></th>
                        
                            <th><g:message code="patrolLogItem.topic.label" default="Topic" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${patrolLogItemInstanceList}" status="i" var="patrolLogItemInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${patrolLogItemInstance.id}">${fieldValue(bean: patrolLogItemInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: patrolLogItemInstance, field: "answer")}</td>
                        
                            <td>${fieldValue(bean: patrolLogItemInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: patrolLogItemInstance, field: "patrolLog")}</td>
                        
                            <td>${fieldValue(bean: patrolLogItemInstance, field: "topic")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${patrolLogItemInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
