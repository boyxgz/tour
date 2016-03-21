
<%@ page import="com.surelution.tour.GasRecircling" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasRecircling.label', default: 'GasRecircling')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasRecircling.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: summary, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasRecircling.gun.label" default="Gun" /></td>
                            
                            <td valign="top" class="value">${summary.department?.name}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasRecircling.type.label" default="Type" /></td>
                            
                            <td valign="top" class="value">${summary?.type?.title}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasRecircling.inputTime.label" default="Input Time" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${summary?.time}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasRecircling.user.label" default="User" /></td>
                            
                            <td valign="top" class="value">${summary?.user?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'gasRecircling.id.label', default: 'Id')}" />
                        
                            <th><g:message code="department.label" default="Department" /></th>
                        
                            <th><g:message code="gasRecirclingType.label" default="Gun" /></th>

                            <th><g:message code="gasRecircling.gun.label" default="Gun" /></th>
                        
                            <th><g:message code="gasRecircling.volume.label" default="Volume" /></th>
                            
                            <g:sortableColumn property="differAmount" title="${message(code: 'gasRecircling.differAmount.label', default: 'Differ Amount')}" />

                            <g:sortableColumn property="inputTime" title="${message(code: 'gasRecircling.inputTime.label', default: 'Input Time')}" />
                        
                            <g:sortableColumn property="outputTime" title="${message(code: 'gasRecircling.outputTime.label', default: 'Output Time')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'gasRecircling.description.label', default: 'Description')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${recirclings}" status="i" var="gasRecirclingInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${gasRecirclingInstance.id}">${fieldValue(bean: gasRecirclingInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: gasRecirclingInstance, field: "gun.tank.department.name")}</td>
                        
                            <td>${fieldValue(bean: gasRecirclingInstance, field: "type.title")}</td>

                            <td>${fieldValue(bean: gasRecirclingInstance, field: "gun.gunNo")}</td>
                        
                            <td>${fieldValue(bean: gasRecirclingInstance, field: "volume")}</td>
                        
                            <td>${fieldValue(bean: gasRecirclingInstance, field: "differAmount")}</td>
                        
                            <td><g:formatDate date="${gasRecirclingInstance.inputTime}" /></td>
                        
                            <td><g:formatDate date="${gasRecirclingInstance.outputTime}" /></td>
                        
                            <td>${fieldValue(bean: gasRecirclingInstance, field: "description")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            
        </div>
    </body>
</html>
