
<%@ page import="com.surelution.tour.Wand" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'wand.label', default: 'Wand')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'wand.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="sn" title="${message(code: 'wand.sn.label', default: 'Sn')}" />
                        
                            <g:sortableColumn property="User" title="${message(code: 'wand.user.label', default: 'user')}" />
                            <%--<th><g:message code="wand.user.label" default="User" /></th>
                        
                            --%><g:sortableColumn property="description" title="${message(code: 'wand.description.label', default: 'Description')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${wandInstanceList}" status="i" var="wandInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${wandInstance.id}">${fieldValue(bean: wandInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: wandInstance, field: "sn")}</td>
                        
                            <td>${fieldValue(bean: wandInstance, field: "user.username")}</td>
                        
                            <td>${fieldValue(bean: wandInstance, field: "description")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${wandInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
