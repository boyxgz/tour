
<%@ page import="com.surelution.tour.PatrolClock" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrolClock.label', default: 'PatrolClock')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'patrolClock.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="clock" title="${message(code: 'patrolClock.clock.label', default: 'Clock')}" />
                        
                            <g:sortableColumn property="minute" title="${message(code: 'patrolClock.minute.label', default: 'Minute')}" />
                        
                            <g:sortableColumn property="delay" title="${message(code: 'patrolClock.delay.label', default: 'Delay')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${patrolClockInstanceList}" status="i" var="patrolClockInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${patrolClockInstance.id}">${fieldValue(bean: patrolClockInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: patrolClockInstance, field: "clock")}</td>
                        
                            <td>${fieldValue(bean: patrolClockInstance, field: "minute")}</td>
                        
                            <td>${fieldValue(bean: patrolClockInstance, field: "delay")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${patrolClockInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
