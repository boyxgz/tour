

<%@ page import="com.surelution.tour.Wand" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'wand.label', default: 'Wand')}" />
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
            <g:hasErrors bean="${wandInstance}">
            <div class="errors">
                <g:renderErrors bean="${wandInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="wand.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: wandInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${wandInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sn"><g:message code="wand.sn.label" default="Sn" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: wandInstance, field: 'sn', 'errors')}">
                                    <g:textField name="sn" value="${wandInstance?.sn}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="user"><g:message code="wand.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: wandInstance, field: 'user', 'errors')}">
                                    <g:select name="user.id" from="${com.surelution.tour.User.list()}" optionKey="id" optionValue="username" noSelection="['':'——请选择用户——']"/>
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
