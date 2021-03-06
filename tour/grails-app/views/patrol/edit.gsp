

<%@ page import="com.surelution.tour.Patrol" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrol.label', default: 'Patrol')}" />
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
            <g:hasErrors bean="${patrolInstance}">
            <div class="errors">
                <g:renderErrors bean="${patrolInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${patrolInstance?.id}" />
                <g:hiddenField name="version" value="${patrolInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="postScript"><g:message code="patrol.postScript.label" default="Post Script" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolInstance, field: 'postScript', 'errors')}">
                                    <g:textField name="postScript" value="${patrolInstance?.postScript}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="clock"><g:message code="patrol.clock.label" default="Clock" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolInstance, field: 'clock', 'errors')}">
                                    <g:select name="clock.id" from="${com.surelution.tour.PatrolClock.list()}" optionKey="id" value="${patrolInstance?.clock?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="department"><g:message code="patrol.department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${com.surelution.tour.Department.list()}" optionKey="id" value="${patrolInstance?.department?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="items"><g:message code="patrol.items.label" default="Items" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolInstance, field: 'items', 'errors')}">
                                    
<ul>
<g:each in="${patrolInstance?.items?}" var="i">
    <li><g:link controller="patrolItem" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="patrolItem" action="create" params="['patrol.id': patrolInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'patrolItem.label', default: 'PatrolItem')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="patrolDate"><g:message code="patrol.patrolDate.label" default="Patrol Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolInstance, field: 'patrolDate', 'errors')}">
                                    <g:datePicker name="patrolDate" precision="day" value="${patrolInstance?.patrolDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="patrolDay"><g:message code="patrol.patrolDay.label" default="Patrol Day" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolInstance, field: 'patrolDay', 'errors')}">
                                    <g:textField name="patrolDay" value="${patrolInstance?.patrolDay}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="reportDate"><g:message code="patrol.reportDate.label" default="Report Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolInstance, field: 'reportDate', 'errors')}">
                                    <g:datePicker name="reportDate" precision="day" value="${patrolInstance?.reportDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="status"><g:message code="patrol.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolInstance, field: 'status', 'errors')}">
                                    <g:select name="status.id" from="${com.surelution.tour.PatrolStatus.list()}" optionKey="id" value="${patrolInstance?.status?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="user"><g:message code="patrol.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolInstance, field: 'user', 'errors')}">
                                    <g:select name="user.id" from="${com.surelution.tour.User.list()}" optionKey="id" value="${patrolInstance?.user?.id}"  />
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
