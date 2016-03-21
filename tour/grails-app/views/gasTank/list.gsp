
<%@ page import="com.surelution.tour.GasTank" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasTank.label', default: 'GasTank')}" />
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
                                	<g:select name="department.id" from="${com.surelution.tour.Department.list() }" optionKey="id" optionValue="name" noSelection='${["":"全部"] }' value="${params['department.id'] }"/>
                                	&nbsp;&nbsp;
                                	<g:submitButton name="search" class="search" value="${message(code: 'default.button.search.label', default: 'Search')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'gasTank.id.label', default: 'Id')}" />
                        
                            <th><g:message code="gasTank.department.label" default="Department" /></th>
                        
                            <g:sortableColumn property="description" title="${message(code: 'gasTank.description.label', default: 'Description')}" />
                        
                            <th><g:message code="gasTank.gasType.label" default="Gas Type" /></th>
                        
                            <g:sortableColumn property="tankNo" title="${message(code: 'gasTank.tankNo.label', default: 'Tank No')}" />
                        
                            <g:sortableColumn property="volume" title="${message(code: 'gasTank.volume.label', default: 'Volume')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${gasTankInstanceList}" status="i" var="gasTankInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${gasTankInstance.id}">${fieldValue(bean: gasTankInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: gasTankInstance, field: "department.name")}</td>
                        
                            <td>${fieldValue(bean: gasTankInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: gasTankInstance, field: "gasType.title")}</td>
                        
                            <td>${fieldValue(bean: gasTankInstance, field: "tankNo")}</td>
                        
                            <td>${fieldValue(bean: gasTankInstance, field: "volume")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${gasTankInstanceTotal}" params="${params }"/>
            </div>
        </div>
    </body>
</html>
