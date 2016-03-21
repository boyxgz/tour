
<%@ page import="com.surelution.tour.Poi" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'poi.label', default: 'Poi')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'poi.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="department" title="${message(code: 'poi.department.label', default: 'department')}" />
                            <%--<th><g:message code="poi.department.label" default="Department" /></th>
                        
                            --%><g:sortableColumn property="name" title="${message(code: 'poi.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="sn" title="${message(code: 'poi.sn.label', default: 'Sn')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'poi.description.label', default: 'Description')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${poiInstanceList}" status="i" var="poiInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${poiInstance.id}">${fieldValue(bean: poiInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: poiInstance, field: "department.name")}</td>
                        
                            <td>${fieldValue(bean: poiInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: poiInstance, field: "sn")}</td>
                        
                            <td>${fieldValue(bean: poiInstance, field: "description")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${poiInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
