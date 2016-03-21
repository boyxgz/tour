
<%@ page import="com.surelution.tour.GasGunChecking" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasGunChecking.label', default: 'GasGunChecking')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'gasGunChecking.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'gasGunChecking.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="differAmount" title="${message(code: 'gasGunChecking.differAmount.label', default: 'Differ Amount')}" />
                        
                            <th><g:message code="gasGunChecking.gun.label" default="Gun" /></th>
                        
                            <th><g:message code="gasGunChecking.user.label" default="User" /></th>
                        
                            <g:sortableColumn property="volume" title="${message(code: 'gasGunChecking.volume.label', default: 'Volume')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${gasGunCheckingInstanceList}" status="i" var="gasGunCheckingInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${gasGunCheckingInstance.id}">${fieldValue(bean: gasGunCheckingInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: gasGunCheckingInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: gasGunCheckingInstance, field: "differAmount")}</td>
                        
                            <td>${fieldValue(bean: gasGunCheckingInstance, field: "gun")}</td>
                        
                            <td>${fieldValue(bean: gasGunCheckingInstance, field: "user")}</td>
                        
                            <td>${fieldValue(bean: gasGunCheckingInstance, field: "volume")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${gasGunCheckingInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
