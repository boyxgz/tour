
<%@ page import="com.surelution.tour.DeliveryScoreItemOption" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'deliveryScoreItemOption.label', default: 'DeliveryScoreItemOption')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'deliveryScoreItemOption.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="score" title="${message(code: 'deliveryScoreItemOption.score.label', default: 'Score')}" />
                        
                            <g:sortableColumn property="title" title="${message(code: 'deliveryScoreItemOption.title.label', default: 'Title')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${deliveryScoreItemOptionInstanceList}" status="i" var="deliveryScoreItemOptionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${deliveryScoreItemOptionInstance.id}">${fieldValue(bean: deliveryScoreItemOptionInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: deliveryScoreItemOptionInstance, field: "score")}</td>
                        
                            <td>${fieldValue(bean: deliveryScoreItemOptionInstance, field: "title")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${deliveryScoreItemOptionInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
