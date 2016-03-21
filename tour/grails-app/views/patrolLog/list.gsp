
<%@ page import="com.surelution.tour.PatrolLog" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrolLog.label', default: 'PatrolLog')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <label style="font-size:12px;font-weight:normal;color:black;">&nbsp;&nbsp;<g:message code="patrolLog.label.note"/></label>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
    	<div class="content">
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'patrol.id.label', default: 'Id')}" />
                                               
                            <th><g:message code="patrol.clock.label" default="Clock" /></th>
                        
                            <th><g:message code="patrol.department.label" default="Department" /></th>
                        
                            <g:sortableColumn property="patrolDate" title="${message(code: 'patrol.patrolDate.label', default: 'Patrol Date')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${patrolInstanceList}" status="i" var="patrolInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><a href="create?patrolId=${patrolInstance.id }"  >${fieldValue(bean: patrolInstance, field: "id")}</a></td>
                        
	    				<g:if  test="${patrolInstance.clock==null}">
                            <td>无</td>
						</g:if>		  
		  				<g:if  test="${patrolInstance.clock}">
                            <td>${patrolInstance.clock.clock}:${fieldValue(bean: patrolInstance, field: "clock.minute")}</td>
						</g:if>	                        
                            <td>${fieldValue(bean: patrolInstance, field: "department.name")}</td>
                        
                            <td><g:formatDate date="${patrolInstance.patrolDate}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
		</div>            
        </div>
    </body>
</html>
