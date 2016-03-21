
<%@ page import="com.surelution.tour.PatrolLogAudit" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrolLogAudit.label', default: 'PatrolLogAudit')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'patrolLogAudit.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="correct" title="${message(code: 'patrolLogAudit.correct.label', default: 'Correct')}" />
                        
                            <g:sortableColumn property="descript" title="${message(code: 'patrolLogAudit.descript.label', default: 'Descript')}" />
                        
                            <th><g:message code="patrolLogAudit.patrolLog.label" default="Patrol Log" /></th>
                        
                            <th><g:message code="patrol.user.label" default="User" /></th>
                        
                            <th><g:message code="patrolLogAudit.user.label" default="User" /></th>
                        
                            <g:sortableColumn property="auditTime" title="${message(code: 'patrolLogAudit.auditTime.label', default: 'Audit Time')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${patrolLogAuditInstanceList}" status="i" var="patrolLogAuditInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${patrolLogAuditInstance.id}">${fieldValue(bean: patrolLogAuditInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatBoolean boolean="${patrolLogAuditInstance.correct}" /></td>
                        
                            <td>${fieldValue(bean: patrolLogAuditInstance, field: "descript")}</td>
                        
                            <td>${fieldValue(bean: patrolLogAuditInstance, field: "patrolLog.remark")}</td>
                        
                            <td>${fieldValue(bean: patrolLogAuditInstance, field: "patrolLog.patrol.user")}</td>
                        
                            <td>${fieldValue(bean: patrolLogAuditInstance, field: "user")}</td>
                        
                            <td><g:formatDate date="${patrolLogAuditInstance.auditTime}" format="yyyy年MM月dd日 " /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${patrolLogAuditInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
