
<%@ page import="com.surelution.tour.PatrolLogAudit" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrolLogAudit.label', default: 'PatrolLogAudit')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrolLogAudit.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: patrolLogAuditInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrolLogAudit.auditTime.label" default="Audit Time" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${patrolLogAuditInstance?.auditTime}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrolLogAudit.correct.label" default="Correct" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${patrolLogAuditInstance?.correct}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrolLogAudit.descript.label" default="Descript" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: patrolLogAuditInstance, field: "descript")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrolLogAudit.patrolLog.label" default="Patrol Log" /></td>
                            
                            <td valign="top" class="value"><g:link controller="patrolLog" action="show" id="${patrolLogAuditInstance?.patrolLog?.id}">${patrolLogAuditInstance?.patrolLog?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrolLogAudit.user.label" default="User" /></td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${patrolLogAuditInstance?.user?.id}">${patrolLogAuditInstance?.user?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
