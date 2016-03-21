
<%@ page import="com.surelution.tour.Department" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'department.label', default: 'Department')}" />
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
            <g:form action="list" >
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    所属油站
                                </td>
                                <td valign="top" class="value">
                                	<g:select name="department.id" from="${com.surelution.tour.Department.list() }" optionKey="id" optionValue="name" noSelection='${["":""] }' value="${params['department.id'] }" onchange="loadTank()"/>
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'department.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'department.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="shortName" title="${message(code: 'department.shortName.label', default: 'Short Name')}" />
                        
                            <g:sortableColumn property="tel" title="${message(code: 'department.tel.label', default: 'Tel')}" />
                        
                            <g:sortableColumn property="address" title="${message(code: 'department.address.label', default: 'Address')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'department.description.label', default: 'Description')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${departmentInstanceList}" status="i" var="departmentInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${departmentInstance.id}">${fieldValue(bean: departmentInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: departmentInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: departmentInstance, field: "shortName")}</td>
                        
                            <td>${fieldValue(bean: departmentInstance, field: "tel")}</td>
                        
                            <td>${fieldValue(bean: departmentInstance, field: "address")}</td>
                        
                            <td>${fieldValue(bean: departmentInstance, field: "description")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${departmentInstanceTotal}" params="${params }"/>
            </div>
        </div>
    </body>
</html>
