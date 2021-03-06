
<%@ page import="com.surelution.tour.GasTank" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasTank.label', default: 'GasTank')}" />
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
                            <td valign="top" class="name"><g:message code="gasTank.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: gasTankInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasTank.department.label" default="Department" /></td>
                            
                            <td valign="top" class="value">${gasTankInstance?.department?.name}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasTank.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: gasTankInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasTank.gasType.label" default="Gas Type" /></td>
                            
                            <td valign="top" class="value">${gasTankInstance?.gasType?.title}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasTank.tankNo.label" default="Tank No" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: gasTankInstance, field: "tankNo")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasTank.volume.label" default="Volume" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: gasTankInstance, field: "volume")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${gasTankInstance?.id}" />
                    <sec:ifAnyGranted roles="ROLE-ADMIN">
	                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
	                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    </sec:ifAnyGranted>
                </g:form>
            </div>
        </div>
    </body>
</html>
