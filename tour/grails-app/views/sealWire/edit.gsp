

<%@ page import="com.surelution.tour.SealWire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'sealWire.label', default: 'SealWire')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${sealWireInstance}">
            <div class="errors">
                <g:renderErrors bean="${sealWireInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${sealWireInstance?.id}" />
                <g:hiddenField name="version" value="${sealWireInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="department"><g:message code="sealWire.department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sealWireInstance, field: 'department', 'errors')}">
                                    ${sealWireInstance?.department?.id}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="importBatch"><g:message code="sealWire.importBatch.label" default="Import Batch" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sealWireInstance, field: 'importBatch', 'errors')}">
                                    ${sealWireInstance?.importBatch?.id}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="prefix"><g:message code="sealWire.prefix.label" default="Prefix" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sealWireInstance, field: 'prefix', 'errors')}">
                                    ${sealWireInstance?.prefix}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="sn"><g:message code="sealWire.sn.label" default="Sn" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sealWireInstance, field: 'sn', 'errors')}">
                                    ${sealWireInstance?.sn}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="available"><g:message code="sealWire.available.label" default="Available" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sealWireInstance, field: 'available', 'errors')}">
                                    <g:checkBox name="available" value="${sealWireInstance?.available}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="status"><g:message code="sealWire.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sealWireInstance, field: 'status', 'errors')}">
                                    <g:select name="status.id" from="${com.surelution.tour.SealWireStatus.list()}" optionKey="id" optionValue="title" value="${sealWireInstance?.status?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
