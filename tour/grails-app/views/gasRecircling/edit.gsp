

<%@ page import="com.surelution.tour.GasRecircling" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasRecircling.label', default: 'GasRecircling')}" />
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
            <g:hasErrors bean="${gasRecirclingInstance}">
            <div class="errors">
                <g:renderErrors bean="${gasRecirclingInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${gasRecirclingInstance?.id}" />
                <g:hiddenField name="version" value="${gasRecirclingInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="gasRecircling.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${gasRecirclingInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="differAmount"><g:message code="gasRecircling.differAmount.label" default="Differ Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'differAmount', 'errors')}">
                                    <g:textField name="differAmount" value="${fieldValue(bean: gasRecirclingInstance, field: 'differAmount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="gun"><g:message code="gasRecircling.gun.label" default="Gun" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'gun', 'errors')}">
                                    <g:select name="gun.id" from="${com.surelution.tour.GasGun.list()}" optionKey="id" optionValue="gunNo" value="${gasRecirclingInstance?.gun?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="inputTime"><g:message code="gasRecircling.inputTime.label" default="Input Time" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'inputTime', 'errors')}">
                                    <g:datePicker name="inputTime" precision="day" value="${gasRecirclingInstance?.inputTime}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="outputTime"><g:message code="gasRecircling.outputTime.label" default="Output Time" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'outputTime', 'errors')}">
                                    <g:datePicker name="outputTime" precision="day" value="${gasRecirclingInstance?.outputTime}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="type"><g:message code="gasRecircling.type.label" default="Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'type', 'errors')}">
                                    <g:select name="type.id" from="${com.surelution.tour.GasRecirclingType.list()}" optionKey="id" optionValue="title" value="${gasRecirclingInstance?.type?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="user"><g:message code="gasRecircling.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'user', 'errors')}">
                                    <g:select name="user.id" from="${com.surelution.tour.User.list()}" optionKey="id" value="${gasRecirclingInstance?.user?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="volume"><g:message code="gasRecircling.volume.label" default="Volume" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'volume', 'errors')}">
                                    <g:textField name="volume" value="${fieldValue(bean: gasRecirclingInstance, field: 'volume')}" />
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
