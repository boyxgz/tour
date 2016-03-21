

<%@ page import="com.surelution.tour.Leave" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'leave.label', default: 'Leave')}" />
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
            <g:hasErrors bean="${leaveInstance}">
            <div class="errors">
                <g:renderErrors bean="${leaveInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="user"><g:message code="leave.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: leaveInstance, field: 'user', 'errors')}">
                                    <g:select name="user.id" from="${users}" optionKey="id" value="${leaveInstance?.user?.id}"  />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="leave.type.label" default="Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: leaveInstance, field: 'type', 'errors')}">
                                    <g:select name="type.id" from="${com.surelution.tour.LeaveType.list()}" optionKey="id" optionValue="name" value="${leaveInstance?.type?.id}"  />
                                </td>
                            </tr>
                                                   
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="from"><g:message code="leave.from.label" default="From" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: leaveInstance, field: 'from', 'errors')}">
                                    <g:datePicker name="from" precision="day" value="${leaveInstance?.from}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="to"><g:message code="leave.to.label" default="To" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: leaveInstance, field: 'to', 'errors')}">
                                    <g:datePicker name="to" precision="day" value="${leaveInstance?.to}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="leave.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: leaveInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" value="${leaveInstance?.description}" />
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
