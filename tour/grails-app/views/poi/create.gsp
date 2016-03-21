

<%@ page import="com.surelution.tour.Poi" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'poi.label', default: 'Poi')}" />
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
            <g:hasErrors bean="${poiInstance}">
            <div class="errors">
                <g:renderErrors bean="${poiInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sn"><g:message code="poi.sn.label" default="Sn" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: poiInstance, field: 'sn', 'errors')}">
                                    <g:textField name="sn" value="${poiInstance?.sn}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="poi.department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: poiInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${com.surelution.tour.Department.list()}" optionKey="id" optionValue="name" noSelection="['':'——请选择加油站——']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="poi.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: poiInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${poiInstance?.description}" />
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
