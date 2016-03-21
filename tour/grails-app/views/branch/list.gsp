
<%@ page import="com.surelution.tour.Branch" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'branch.label', default: 'Branch')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'branch.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="address" title="${message(code: 'branch.address.label', default: 'Address')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'branch.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="tel" title="${message(code: 'branch.tel.label', default: 'Tel')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${branchInstanceList}" status="i" var="branchInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${branchInstance.id}">${fieldValue(bean: branchInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: branchInstance, field: "address")}</td>
                        
                            <td>${fieldValue(bean: branchInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: branchInstance, field: "tel")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${branchInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
