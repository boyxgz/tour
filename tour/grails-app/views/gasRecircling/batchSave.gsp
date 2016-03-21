
<%@ page import="com.surelution.tour.GasRecircling" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasRecircling.label', default: 'GasRecircling')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'gasRecircling.id.label', default: 'Id')}" />
                        
                            <th><g:message code="department.label" default="Department" /></th>
                        
                            <th><g:message code="gasRecircling.gun.label" default="Gun" /></th>
                        
                            <th><g:message code="gasRecircling.volume.label" default="Volume" /></th>
                        
                            <g:sortableColumn property="inputTime" title="${message(code: 'gasRecircling.inputTime.label', default: 'Input Time')}" />
                        
                            <g:sortableColumn property="differAmount" title="${message(code: 'gasRecircling.differAmount.label', default: 'Differ Amount')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'gasRecircling.description.label', default: 'Description')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${allInstances}" status="i" var="gasRecirclingInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${gasRecirclingInstance.id}">${fieldValue(bean: gasRecirclingInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: gasRecirclingInstance, field: "gun.tank.department.name")}</td>
                        
                            <td>${fieldValue(bean: gasRecirclingInstance, field: "gun.gunNo")}</td>
                        
                            <td>${fieldValue(bean: gasRecirclingInstance, field: "volume")}</td>
                        
                            <td><g:formatDate date="${gasRecirclingInstance.inputTime}" /></td>
                        
                            <td>${fieldValue(bean: gasRecirclingInstance, field: "differAmount")}</td>
                        
                            <td>${fieldValue(bean: gasRecirclingInstance, field: "description")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
