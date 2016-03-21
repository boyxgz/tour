
<%@ page import="com.surelution.tour.PageEntry" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pageEntry.label', default: 'PageEntry')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'pageEntry.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="controllerName" title="${message(code: 'pageEntry.controllerName.label', default: 'Controller Name')}" />
                        
                            <g:sortableColumn property="actionName" title="${message(code: 'pageEntry.actionName.label', default: 'Action Name')}" />
                        
                            <th><g:message code="pageEntry.parent.label" default="Parent" /></th>
                        
                            <g:sortableColumn property="isLeaf" title="${message(code: 'pageEntry.isLeaf.label', default: 'Is Leaf')}" />
                        
                            <g:sortableColumn property="label" title="${message(code: 'pageEntry.label.label', default: 'Label')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${pageEntryInstanceList}" status="i" var="pageEntryInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${pageEntryInstance.id}">${fieldValue(bean: pageEntryInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: pageEntryInstance, field: "controllerName")}</td>
                        
                            <td>${fieldValue(bean: pageEntryInstance, field: "actionName")}</td>
                        
                            <td>${fieldValue(bean: pageEntryInstance, field: "parent")}</td>
                        
                            <td><g:formatBoolean boolean="${pageEntryInstance.isLeaf}" /></td>
                        
                            <td>${fieldValue(bean: pageEntryInstance, field: "label")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${pageEntryInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
