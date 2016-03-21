
<%@ page import="com.surelution.tour.DeliveryScoreItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'deliveryScoreItem.label', default: 'DeliveryScoreItem')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'deliveryScoreItem.id.label', default: 'Id')}" />
                        
                            <th><g:message code="deliveryScoreItem.deliveryScore.label" default="Delivery Score" /></th>
                        
                            <g:sortableColumn property="score" title="${message(code: 'deliveryScoreItem.score.label', default: 'Score')}" />
                        
                            <th><g:message code="deliveryScoreItem.type.label" default="Type" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${deliveryScoreItemInstanceList}" status="i" var="deliveryScoreItemInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${deliveryScoreItemInstance.id}">${fieldValue(bean: deliveryScoreItemInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: deliveryScoreItemInstance, field: "deliveryScore")}</td>
                        
                            <td>${fieldValue(bean: deliveryScoreItemInstance, field: "score")}</td>
                        
                            <td>${fieldValue(bean: deliveryScoreItemInstance, field: "type")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${deliveryScoreItemInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
