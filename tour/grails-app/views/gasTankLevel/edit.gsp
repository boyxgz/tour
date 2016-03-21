

<%@ page import="com.surelution.tour.GasTankLevel" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasTankLevel.label', default: 'GasTankLevel')}" />
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
            <g:hasErrors bean="${gasTankLevelInstance}">
            <div class="errors">
                <g:renderErrors bean="${gasTankLevelInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${gasTankLevelInstance?.id}" />
                <g:hiddenField name="version" value="${gasTankLevelInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="amout"><g:message code="gasTankLevel.amout.label" default="Amout" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'amout', 'errors')}">
                                    <g:textField name="amout" value="${fieldValue(bean: gasTankLevelInstance, field: 'amout')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="checkTime"><g:message code="gasTankLevel.checkTime.label" default="Check Time" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'checkTime', 'errors')}">
                                    <g:datePicker name="checkTime" precision="day" value="${gasTankLevelInstance?.checkTime}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="colorState"><g:message code="gasTankLevel.colorState.label" default="Color State" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'colorState', 'errors')}">
                                    <g:checkBox name="colorState" value="${gasTankLevelInstance?.colorState}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="density"><g:message code="gasTankLevel.density.label" default="Density" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'density', 'errors')}">
                                    <g:textField name="density" value="${fieldValue(bean: gasTankLevelInstance, field: 'density')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="impurityState"><g:message code="gasTankLevel.impurityState.label" default="Impurity State" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'impurityState', 'errors')}">
                                    <g:checkBox name="impurityState" value="${gasTankLevelInstance?.impurityState}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="instrumentAmount"><g:message code="gasTankLevel.instrumentAmount.label" default="Instrument Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'instrumentAmount', 'errors')}">
                                    <g:textField name="instrumentAmount" value="${fieldValue(bean: gasTankLevelInstance, field: 'instrumentAmount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="instrumentTemprature"><g:message code="gasTankLevel.instrumentTemprature.label" default="Instrument Temprature" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'instrumentTemprature', 'errors')}">
                                    <g:textField name="instrumentTemprature" value="${fieldValue(bean: gasTankLevelInstance, field: 'instrumentTemprature')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="instrumentWaterLevel"><g:message code="gasTankLevel.instrumentWaterLevel.label" default="Instrument Water Level" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'instrumentWaterLevel', 'errors')}">
                                    <g:textField name="instrumentWaterLevel" value="${fieldValue(bean: gasTankLevelInstance, field: 'instrumentWaterLevel')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tank"><g:message code="gasTankLevel.tank.label" default="Tank" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'tank', 'errors')}">
                                    ${gasTankLevelInstance.tank.tankNo}(${gasTankLevelInstance.tank.department.name})
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="temprature"><g:message code="gasTankLevel.temprature.label" default="Temprature" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'temprature', 'errors')}">
                                    <g:textField name="temprature" value="${fieldValue(bean: gasTankLevelInstance, field: 'temprature')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="user"><g:message code="gasTankLevel.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'user', 'errors')}">
                                    <g:select name="user.id" from="${com.surelution.tour.User.list()}" optionKey="id" value="${gasTankLevelInstance?.user?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="waterLevel"><g:message code="gasTankLevel.waterLevel.label" default="Water Level" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'waterLevel', 'errors')}">
                                    <g:textField name="waterLevel" value="${fieldValue(bean: gasTankLevelInstance, field: 'waterLevel')}" />
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
