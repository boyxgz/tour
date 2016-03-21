
<%@ page import="com.surelution.tour.Patrol" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrol.label', default: 'Patrol')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'patrol.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="postScript" title="${message(code: 'patrol.postScript.label', default: 'Post Script')}" />
                        
                            <th><g:message code="patrol.clock.label" default="Clock" /></th>
                        
                            <th><g:message code="patrol.department.label" default="Department" /></th>
                        
                            <g:sortableColumn property="patrolDate" title="${message(code: 'patrol.patrolDate.label', default: 'Patrol Date')}" />
                        
                            <g:sortableColumn property="patrolDay" title="${message(code: 'patrol.patrolDay.label', default: 'Patrol Day')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${patrolInstanceList}" status="i" var="patrolInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${patrolInstance.id}">${fieldValue(bean: patrolInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: patrolInstance, field: "postScript")}</td>
                        
                            <td>${fieldValue(bean: patrolInstance, field: "clock")}</td>
                        
                            <td>${fieldValue(bean: patrolInstance, field: "department")}</td>
                        
                            <td><g:formatDate date="${patrolInstance.patrolDate}" /></td>
                        
                            <td>${fieldValue(bean: patrolInstance, field: "patrolDay")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${patrolInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
