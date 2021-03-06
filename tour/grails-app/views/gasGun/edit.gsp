

<%@ page import="com.surelution.tour.GasGun" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasGun.label', default: 'GasGun')}" />
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
            <g:hasErrors bean="${gasGunInstance}">
            <div class="errors">
                <g:renderErrors bean="${gasGunInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${gasGunInstance?.id}" />
                <g:hiddenField name="version" value="${gasGunInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        <tr class="prop">
                                <td valign="top" class="name">
                                  <g:message code="department.label" default="Department" />
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasGunInstance, field: 'gunNo', 'errors')}">
                                    ${gasGunInstance?.tank.department.name}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="gunNo"><g:message code="gasGun.gunNo.label" default="Gun No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasGunInstance, field: 'gunNo', 'errors')}">
                                    <g:textField name="gunNo" value="${gasGunInstance?.gunNo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tank"><g:message code="gasGun.tank.label" default="Tank" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasGunInstance, field: 'tank', 'errors')}">
                                    <g:select name="tank.id" from="${com.surelution.tour.GasTank.list()}" optionKey="id" optionValue='${{it.tankNo+","+it.department.name}}' value="${gasGunInstance?.tank?.id}"  />
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
