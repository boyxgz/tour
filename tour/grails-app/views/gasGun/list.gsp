
<%@ page import="com.surelution.tour.GasGun" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasGun.label', default: 'GasGun')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'gasGun.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="gunNo" title="${message(code: 'gasGun.gunNo.label', default: 'Gun No')}" />
                        
                            <th><g:message code="department.label" default="Department" /></th>
                        
                            <th><g:message code="gasGun.tank.label" default="Tank" /></th>
                        
                            <th><g:message code="gasType.label" default="Gas Type" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${gasGunInstanceList}" status="i" var="gasGunInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${gasGunInstance.id}">${fieldValue(bean: gasGunInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: gasGunInstance, field: "gunNo")}</td>
                        
                            <td>${fieldValue(bean: gasGunInstance, field: "tank.department.name")}</td>
                        
                            <td>${fieldValue(bean: gasGunInstance, field: "tank.tankNo")}</td>
                        
                            <td>${fieldValue(bean: gasGunInstance, field: "tank.gasType.title")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${gasGunInstanceTotal}" params="${['department.id':params.'department.id'] }" />
            </div>
        </div>
    </body>
</html>
