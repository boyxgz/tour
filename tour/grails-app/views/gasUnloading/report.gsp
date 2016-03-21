
<%@ page import="com.surelution.tour.GasUnloading" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasUnloading.label', default: 'GasUnloading')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'gasUnloading.id.label', default: 'Id')}" />
                        
                            <th><g:message code="department.label" default="Department" /></th>
                        
                            <th><g:message code="gasTank.label" default="Gas Tank" /></th>

                            <g:sortableColumn property="amount" title="${message(code: 'gasUnloading.amount.label', default: 'Amount')}" />
                        
                            <g:sortableColumn property="formNo" title="${message(code: 'gasUnloading.formNo.label', default: 'Form No')}" />
                        
                            <g:sortableColumn property="planningAmount" title="${message(code: 'gasUnloading.planningAmount.label', default: 'Planning Amount')}" />
                        
                            <g:sortableColumn property="unloadingTime" title="${message(code: 'gasUnloading.unloadingTime.label', default: 'Unloading Time')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${gasUnloadingInstanceList}" status="i" var="gasUnloadingInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${gasUnloadingInstance.id}">${fieldValue(bean: gasUnloadingInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: gasUnloadingInstance, field: "department.name")}</td>
                        
                            <td>
                            	${gasUnloadingInstance.splitted?"分卸：":"" }
                            	<g:each in="${gasUnloadingInstance.items}" var="item">
                            		${item.tank.tankNo }&nbsp;
                            	</g:each>
                            </td>
                        
                            <td>${fieldValue(bean: gasUnloadingInstance, field: "amount")}</td>
                        
                            <td>${fieldValue(bean: gasUnloadingInstance, field: "formNo")}</td>
                        
                            <td>${fieldValue(bean: gasUnloadingInstance, field: "planningAmount")}</td>
                        
                            <td><g:formatDate date="${gasUnloadingInstance.unloadingTime}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${gasUnloadingInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
