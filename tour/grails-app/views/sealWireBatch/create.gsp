

<%@ page import="com.surelution.tour.SealWireBatch" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'sealWireBatch.label', default: 'SealWireBatch')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="list" action="list" controller="sealWire"><g:message code="default.sealWireList.label" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${sealWireBatchInstance}">
            <div class="errors">
                <g:renderErrors bean="${sealWireBatchInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="sealWireBatch.department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sealWireBatchInstance, field: 'department', 'errors')}">
                                    <g:set var="username" value="${sec.loggedInUserInfo(field:'username').toString()}"/>
                                	<g:select name="department.id" from="${com.surelution.tour.UserDepartment.getUserDepartments(username)}" noSelection="${['':''] }" optionKey="id" optionValue="name" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="prefix"><g:message code="sealWireBatch.prefix.label" default="Prefix" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sealWireBatchInstance, field: 'prefix', 'errors')}">
                                    <g:textField name="prefix" value="${sealWireBatchInstance?.prefix}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="start"><g:message code="sealWireBatch.start.label" default="Start" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sealWireBatchInstance, field: 'start', 'errors')}">
                                    <g:textField name="start" value="${fieldValue(bean: sealWireBatchInstance, field: 'start')}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="end"><g:message code="sealWireBatch.end.label" default="End" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sealWireBatchInstance, field: 'end', 'errors')}">
                                    <g:textField name="end" value="${fieldValue(bean: sealWireBatchInstance, field: 'end')}" />
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
