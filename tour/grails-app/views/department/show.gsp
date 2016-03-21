
<%@ page import="com.surelution.tour.Department" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'department.label', default: 'Department')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="content">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="department.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: departmentInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="department.address.label" default="Address" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: departmentInstance, field: "address")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="department.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: departmentInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="department.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: departmentInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="department.shortName.label" default="Short Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: departmentInstance, field: "shortName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="department.tel.label" default="Tel" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: departmentInstance, field: "tel")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${departmentInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
            
            <br/>
            
            <div>
	            <g:form action="poiAdd" >
	                <div class="dialog">
            		<h1>新建 巡更点</h1>

	                    <table>
	                        <tbody>
	                        
	                            <tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="sn"><g:message code="poi.sn.label" default="Sn" /></label>
	                                </td>
	                                <td valign="top" class="value ${hasErrors(bean: poiInstance, field: 'sn', 'errors')}">
	                                    <g:textField name="sn" value="${poiInstance?.sn}" />
	                                    <g:hiddenField name="department.id" value="${departmentInstance.id}"/>
	                                </td>
	                            </tr>
	                        
	                            <tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="name"><g:message code="poi.name.label" default="Name" /></label>
	                                </td>
	                                <td valign="top" class="value ${hasErrors(bean: poiInstance, field: 'name', 'errors')}">
	                                    <g:textField name="name" value="${poiInstance?.name}" />
	                                </td>
	                            </tr>
	                        
	                            <tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="descriptoin"><g:message code="poi.description.label" default="Descriptoin" /></label>
	                                </td>
	                                <td valign="top" class="value ${hasErrors(bean: poiInstance, field: 'descriptoin', 'errors')}">
	                                    <g:textField name="description" value="${poiInstance?.description}" />
	                                </td>
	                            </tr>
	                        
	                        </tbody>
	                    </table>
	                </div>
	                <div class="buttons">
	                    <span class="button"><g:submitButton name="poiAdd" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
	                </div>
	            </g:form>
	            
	            <div class="list">
            		<h1>巡更点 列表</h1>
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'poi.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="sn" title="${message(code: 'poi.sn.label', default: 'Sn')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'poi.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="descriptoin" title="${message(code: 'poi.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="operation" title="${message(code: 'poi.operation.label', default: 'Operation')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${poiInstanceList}" status="i" var="poiInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td>${fieldValue(bean: poiInstance, field: "id")}</td>
                        
                            <td>${fieldValue(bean: poiInstance, field: "sn")}</td>
                        
                            <td>${fieldValue(bean: poiInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: poiInstance, field: "description")}</td>
                        
                            <td><g:link>[X]</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            
            </div>
            
        </div>
    </body>
</html>
