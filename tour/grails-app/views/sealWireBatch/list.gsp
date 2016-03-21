
<%@ page import="com.surelution.tour.SealWireBatch" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'sealWireBatch.label', default: 'SealWireBatch')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="list" action="list" controller="sealWire"><g:message code="default.sealWireList.label" /></g:link></span>
            
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form action="list" >
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    所属油站
                                </td>
                                <td valign="top" class="value">
                                	<g:set var="username" value="${sec.loggedInUserInfo(field:'username').toString()}"/>
                                	<g:select name="department.id" from="${com.surelution.tour.UserDepartment.getUserDepartments(username)}" noSelection="${['':''] }" optionKey="id" optionValue="name" value="${params['department.id'] }" />
                                	<span class="button"><g:submitButton name="search" class="search" value="${message(code: 'default.button.search.label', default: 'Search')}" /></span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </g:form>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'sealWireBatch.id.label', default: 'Id')}" />
                        
                            <th><g:message code="sealWireBatch.department.label" default="Department" /></th>
                        
                            <g:sortableColumn property="importDate" title="${message(code: 'sealWireBatch.importDate.label', default: 'Import Date')}" />
                        
                            <th><g:message code="sealWireBatch.importUser.label" default="Import User" /></th>
                        
                            <g:sortableColumn property="prefix" title="${message(code: 'sealWireBatch.prefix.label', default: 'Prefix')}" />
                        
                            <g:sortableColumn property="start" title="${message(code: 'sealWireBatch.start.label', default: 'start')}" />
                        
                            <g:sortableColumn property="end" title="${message(code: 'sealWireBatch.end.label', default: 'End')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${sealWireBatchInstanceList}" status="i" var="sealWireBatchInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${sealWireBatchInstance.id}">${fieldValue(bean: sealWireBatchInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: sealWireBatchInstance, field: "department.name")}</td>
                        
                            <td><g:formatDate date="${sealWireBatchInstance.importDate}" /></td>
                        
                            <td>${fieldValue(bean: sealWireBatchInstance, field: "importUser")}</td>
                        
                            <td>${fieldValue(bean: sealWireBatchInstance, field: "prefix")}</td>
                        
                            <td>${fieldValue(bean: sealWireBatchInstance, field: "start")}</td>
                        
                            <td>${fieldValue(bean: sealWireBatchInstance, field: "end")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${sealWireBatchInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
