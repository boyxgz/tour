

<%@ page import="com.surelution.tour.Department" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'department.label', default: 'Department')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${departmentInstance}">
            <div class="errors">
                <g:renderErrors bean="${departmentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td class="name">
                                    <label for="address"><g:message code="department.address.label" default="Address" /></label>
                                </td>
                                <td class="value ${hasErrors(bean: departmentInstance, field: 'address', 'errors')}">
                                    <g:textField name="address" value="${departmentInstance?.address}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td class="name">
                                    <label for="description"><g:message code="department.description.label" default="Description" /></label>
                                </td>
                                <td class="value ${hasErrors(bean: departmentInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${departmentInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td class="name">
                                    <label for="name"><g:message code="department.name.label" default="Name" /></label>
                                </td>
                                <td class="value ${hasErrors(bean: departmentInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${departmentInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td class="name">
                                    <label for="shortName"><g:message code="department.shortName.label" default="Short Name" /></label>
                                </td>
                                <td class="value ${hasErrors(bean: departmentInstance, field: 'shortName', 'errors')}">
                                    <g:textField name="shortName" value="${departmentInstance?.shortName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td class="name">
                                    <label for="tel"><g:message code="department.tel.label" default="Tel" /></label>
                                </td>
                                <td class="value ${hasErrors(bean: departmentInstance, field: 'tel', 'errors')}">
                                    <g:textField name="tel" value="${departmentInstance?.tel}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
