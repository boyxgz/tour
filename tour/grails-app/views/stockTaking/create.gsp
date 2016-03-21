

<%@ page import="com.surelution.tour.StockTaking" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <r:require module="jquery-ui"/>
        <r:layoutResources/>
        <g:set var="entityName" value="${message(code: 'stockTaking.label', default: 'StockTaking')}" />
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
            <g:hasErrors bean="${stockTakingInstance}">
            <div class="errors">
                <g:renderErrors bean="${stockTakingInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="previousTaking"><g:message code="stockTaking.previousTaking.label" default="Previous Taking" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: stockTakingInstance, field: 'previousTaking', 'errors')}">
                                	<g:select name="previousTaking.id" from="${previousTakings}" noSelection="${['':''] }" optionKey="id" optionValue='${{it.user.username + "@ " + it.takingTime.format("yyyy-MM-dd HH:mm")}}'/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="stockTaking.department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: stockTakingInstance, field: 'department', 'errors')}">
                                	${stockTakingInstance?.patrol?.department?.name}
                                    <g:hiddenField name="department.id" value="${stockTakingInstance?.patrol?.department?.id}"  />
                                    <g:hiddenField name="patrol.id" value="${stockTakingInstance?.patrol?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="user"><g:message code="stockTaking.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: stockTakingInstance, field: 'user', 'errors')}">
                                   <sec:username/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="takingTime"><g:message code="stockTaking.takingTime.label" default="Taking Time" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: stockTakingInstance, field: 'takingTime', 'errors')}">
                                    <g:datePicker name="takingTime" value="${stockTakingInstance?.takingTime}"  precision="minute"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.save.label', default: 'Create')}" onclick="return confirm('${message(code: 'default.button.save.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
