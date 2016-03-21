
<%@ page import="com.surelution.tour.DeliveryScoreItemType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'deliveryScoreItemType.label', default: 'DeliveryScoreItemType')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'deliveryScoreItemType.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'deliveryScoreItemType.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="title" title="${message(code: 'deliveryScoreItemType.title.label', default: 'Title')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${deliveryScoreItemTypeInstanceList}" status="i" var="deliveryScoreItemTypeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${deliveryScoreItemTypeInstance.id}">${fieldValue(bean: deliveryScoreItemTypeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: deliveryScoreItemTypeInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: deliveryScoreItemTypeInstance, field: "title")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${deliveryScoreItemTypeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
