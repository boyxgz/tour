
<%@ page import="com.surelution.tour.CommonDensity" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'commonDensity.label', default: 'CommonDensity')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'commonDensity.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="density" title="${message(code: 'commonDensity.density.label', default: 'Density')}" />
                        
                            <g:sortableColumn property="end" title="${message(code: 'commonDensity.end.label', default: 'End')}" />
                        
                            <g:sortableColumn property="start" title="${message(code: 'commonDensity.start.label', default: 'Start')}" />
                        
                            <th><g:message code="commonDensity.type.label" default="Type" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${commonDensityInstanceList}" status="i" var="commonDensityInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${commonDensityInstance.id}">${fieldValue(bean: commonDensityInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: commonDensityInstance, field: "density")}</td>
                        
                            <td><g:formatDate date="${commonDensityInstance.end}" format="yyyy-MM-dd"/></td>
                        
                            <td><g:formatDate date="${commonDensityInstance.start}" format="yyyy-MM-dd"/></td>
                        
                            <td>${fieldValue(bean: commonDensityInstance, field: "type.title")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${commonDensityInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
