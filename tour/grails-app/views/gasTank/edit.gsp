

<%@ page import="com.surelution.tour.GasTank" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasTank.label', default: 'GasTank')}" />
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
            <g:hasErrors bean="${gasTankInstance}">
            <div class="errors">
                <g:renderErrors bean="${gasTankInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${gasTankInstance?.id}" />
                <g:hiddenField name="version" value="${gasTankInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="department"><g:message code="gasTank.department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankInstance, field: 'department', 'errors')}">
                                    ${gasTankInstance?.department?.name}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="gasType"><g:message code="gasTank.gasType.label" default="Gas Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankInstance, field: 'gasType', 'errors')}">
                                    <g:select name="gasType.id" from="${com.surelution.tour.GasType.list()}" optionKey="id" optionValue="title" value="${gasTankInstance?.gasType?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tankNo"><g:message code="gasTank.tankNo.label" default="Tank No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankInstance, field: 'tankNo', 'errors')}">
                                    ${gasTankInstance?.tankNo}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="volume"><g:message code="gasTank.volume.label" default="Volume" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankInstance, field: 'volume', 'errors')}">
                                    <g:textField name="volume" value="${fieldValue(bean: gasTankInstance, field: 'volume')}" />
                                </td>
                            </tr>
                            
                             <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="gasTank.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${gasTankInstance?.description}" />
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
