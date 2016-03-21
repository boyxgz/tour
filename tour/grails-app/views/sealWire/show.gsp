
<%@ page import="com.surelution.tour.SealWire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'sealWire.label', default: 'SealWire')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
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
                            <td valign="top" class="name"><g:message code="sealWire.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: sealWireInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="sealWire.department.label" default="Department" /></td>
                            
                            <td valign="top" class="value">${sealWireInstance?.department?.name}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="sealWire.importBatch.label" default="Import Batch" /></td>
                            
                            <td valign="top" class="value">${sealWireInstance?.importBatch?.id}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="sealWire.prefix.label" default="Prefix" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: sealWireInstance, field: "prefix")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="sealWire.sn.label" default="Sn" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: sealWireInstance, field: "sn")}</td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="sealWire.available.label" default="Available" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${sealWireInstance?.available}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="sealWire.status.label" default="Status" /></td>
                            
                            <td valign="top" class="value">${sealWireInstance?.status?.title}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            
            <sec:ifAnyGranted roles="ROLE-ADMIN">
	            <div class="buttons">
	                <g:form>
	                    <g:hiddenField name="id" value="${sealWireInstance?.id}" />
	                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
	                </g:form>
	            </div>
            </sec:ifAnyGranted>
            
        </div>
    </body>
</html>
