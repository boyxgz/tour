
<%@ page import="com.surelution.tour.SystemMessage" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:set var="entityName" value="${message(code: 'systemMessage.label', default: 'SystemMessage')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'systemMessage.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="detail" title="${message(code: 'systemMessage.detail.label', default: 'Detail')}" />
                        
                            <g:sortableColumn property="key" title="${message(code: 'systemMessage.key.label', default: 'Key')}" />
                        
                            <g:sortableColumn property="occuredWhen" title="${message(code: 'systemMessage.occuredWhen.label', default: 'Occured When')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${systemMessageInstanceList}" status="i" var="systemMessageInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${systemMessageInstance.id}">${fieldValue(bean: systemMessageInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: systemMessageInstance, field: "detail")}</td>
                        
                            <td>${fieldValue(bean: systemMessageInstance, field: "key")}</td>
                        
                            <td><g:formatDate date="${systemMessageInstance.occuredWhen}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${systemMessageInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
