
<%@ page import="com.surelution.tour.Leave" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'leave.label', default: 'Leave')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'leave.id.label', default: 'Id')}" />
                            <th><g:message code="leave.user.label" default="User" /></th>
                            <th><g:message code="leave.type.label" default="Type" /></th>
                            <g:sortableColumn property="from" title="${message(code: 'leave.from.label', default: 'From')}" />
                            <g:sortableColumn property="to" title="${message(code: 'leave.to.label', default: 'To')}" />
                            <g:sortableColumn property="description" title="${message(code: 'leave.description.label', default: 'Description')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${leaveInstanceList}" status="i" var="leaveInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link action="show" id="${leaveInstance.id}">${fieldValue(bean: leaveInstance, field: "id")}</g:link></td>
                            
                            <td>${fieldValue(bean: leaveInstance, field: "user")}</td>
                            
                            <td>${fieldValue(bean: leaveInstance, field: "type.name")}</td>
                        
                            <td><g:formatDate date="${leaveInstance.from}" format="yyyy年MM月dd日 "/></td>

                            <td><g:formatDate date="${leaveInstance.to}" format="yyyy年MM月dd日"/></td>
                        
                            <td>${fieldValue(bean: leaveInstance, field: "description")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${leaveInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
