
<%@ page import="com.surelution.tour.StockTakingItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'stockTakingItem.label', default: 'StockTakingItem')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'stockTakingItem.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="saleAmount" title="${message(code: 'stockTakingItem.saleAmount.label', default: 'Sale Amount')}" />
                        
                            <g:sortableColumn property="stockAmount" title="${message(code: 'stockTakingItem.stockAmount.label', default: 'Stock Amount')}" />
                        
                            <th><g:message code="stockTakingItem.taking.label" default="Taking" /></th>
                        
                            <th><g:message code="stockTakingItem.tank.label" default="Tank" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${stockTakingItemInstanceList}" status="i" var="stockTakingItemInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${stockTakingItemInstance.id}">${fieldValue(bean: stockTakingItemInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: stockTakingItemInstance, field: "saleAmount")}</td>
                        
                            <td>${fieldValue(bean: stockTakingItemInstance, field: "stockAmount")}</td>
                        
                            <td>${fieldValue(bean: stockTakingItemInstance, field: "taking")}</td>
                        
                            <td>${fieldValue(bean: stockTakingItemInstance, field: "tank")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${stockTakingItemInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
