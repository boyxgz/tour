
<%@ page import="com.surelution.tour.SealWire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'sealWire.label', default: 'SealWire')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>            
            <span class="menuButton"><g:link class="create" action="create" controller="sealWireBatch"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
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
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    铅封序号
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="sealWireSn" value="${sealWireSn}" />(不带前缀,如:508900)
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'sealWire.id.label', default: 'Id')}" />
                        
                            <th><g:message code="sealWire.department.label" default="Department" /></th>
                        
                            <th><g:message code="sealWire.importBatch.label" default="Import Batch" /></th>
                        
                            <g:sortableColumn property="prefix" title="${message(code: 'sealWire.prefix.label', default: 'Prefix')}" />
                        
                            <g:sortableColumn property="sn" title="${message(code: 'sealWire.sn.label', default: 'Sn')}" />

                            <g:sortableColumn property="available" title="${message(code: 'sealWire.available.label', default: 'Available')}" />
                        
                            <g:sortableColumn property="status" title="${message(code: 'sealWire.status.label', default: 'status')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${sealWireInstanceList}" status="i" var="sealWireInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${sealWireInstance.id}">${fieldValue(bean: sealWireInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: sealWireInstance, field: "department.name")}</td>
                        
                            <td>${fieldValue(bean: sealWireInstance, field: "importBatch.id")}</td>
                        
                            <td>${fieldValue(bean: sealWireInstance, field: "prefix")}</td>
                        
                            <td>${fieldValue(bean: sealWireInstance, field: "sn")}</td>
                        
                            <td><g:formatBoolean boolean="${sealWireInstance.available}" /></td>

                            <td>${fieldValue(bean: sealWireInstance, field: "status.title")}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${sealWireInstanceTotal}" params="${params }"/>
            </div>
        </div>
    </body>
</html>
