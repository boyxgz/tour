

<%@ page import="com.surelution.tour.GasUnloading" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasUnloading.label', default: 'GasUnloading')}" />
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
            <g:hasErrors bean="${gasUnloadingInstance}">
            <div class="errors">
                <g:renderErrors bean="${gasUnloadingInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${gasUnloadingInstance?.id}" />
                <g:hiddenField name="version" value="${gasUnloadingInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="unloadingTime"><g:message code="gasUnloading.unloadingTime.label" default="Unloading Time" /></label>
                                </td>
                                <td colspan="2" valign="top" class="value ${hasErrors(bean: gasUnloadingInstance, field: 'unloadingTime', 'errors')}">
                                    <g:datePicker name="unloadingTime" precision="minute" value="${gasUnloadingInstance?.unloadingTime}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="formNo"><g:message code="gasUnloading.formNo.label" default="Form No" /></label>
                                </td>
                                <td colspan="2" valign="top" class="value ${hasErrors(bean: gasUnloadingInstance, field: 'formNo', 'errors')}">
                                    <g:textField name="formNo" value="${gasUnloadingInstance?.formNo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department.id"><g:message code="department.label" default="Department" /></label>
                                </td>
                                <td colspan="2" valign="top" class="value ${hasErrors(bean: gasUnloadingInstance, field: 'tank', 'errors')}">
                                	<g:select name="department.id" from="${com.surelution.tour.Department.list()}" noSelection="${['':''] }" optionKey="id" optionValue="name" onchange="load4()"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="planningAmount"><g:message code="gasUnloading.planningAmount.label" default="Planning Amount" /></label>
                                </td>
                                <td colspan="2" valign="top" class="value ${hasErrors(bean: gasUnloadingInstance, field: 'planningAmount', 'errors')}">
                                    <g:textField name="planningAmount" value="${fieldValue(bean: gasUnloadingInstance, field: 'planningAmount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="gasType."><g:message code="gasUnloading.gasType.label" default="Gas Type" /></label>
                                </td>
                                <td colspan="2" valign="top" class="value ${hasErrors(bean: gasUnloadingInstance, field: 'gasType', 'errors')}">
                                	<g:select name="gasType.id" from="${com.surelution.tour.GasType.list() }" noSelection="${['':''] }" optionKey="id" optionValue="title" onchange="load4()"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tankFarm"><g:message code="gasUnloading.tankFarm.label" default="Tank Farm" /></label>
                                </td>
                                <td colspan="2" valign="top" class="value ${hasErrors(bean: gasUnloadingInstance, field: 'planningAmount', 'errors')}">
                                	<g:select name="tankFarm.id" optionKey="id" optionValue="name" from="${com.surelution.tour.TankFarm.list() }"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="warehouseNo"><g:message code="gasUnloading.warehouseNo.label" default="Warehouse No" /></label>
                                </td>
                                <td colspan="2" valign="top" class="value ${hasErrors(bean: gasUnloadingInstance, field: 'planningAmount', 'errors')}">
                                    <g:textField name="warehouseNo" value="${fieldValue(bean: gasUnloadingInstance, field: 'warehouseNo')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop" style="background-color: #cccccc">
                                <td valign="top" class="name">
                                    &nbsp;
                                </td>
                                <td valign="top">
                                    油库装车数据
                                </td>
                                <td valign="top">
                                    加油站车上实收数据
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasUnloading.viewVolume.label" default="View Volume" />
                                </td>
                                <td valign="top">
                                	<g:textField name="entruckingViewVolume"/>
                                </td>
                                <td valign="top">
                                	<g:textField name="unloadingViewVolume"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasUnloading.stdVolume.label" default="Std Volume" />
                                </td>
                                <td valign="top">
                                	<g:textField name="entruckingStdVolume"/>
                                </td>
                                <td valign="top">
                                	<g:textField name="unloadingStdVolume"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasUnloading.density.label" default="Density" />
                                </td>
                                <td valign="top">
                                	<g:textField name="entruckingDensity"/>
                                </td>
                                <td valign="top">
                                	<g:textField name="unloadingDensity"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasUnloading.temperature.label" default="Temperature"/>
                                </td>
                                <td valign="top">
                                	<g:textField name="entruckingTemperature"/>
                                </td>
                                <td valign="top">
                                	<g:textField name="unloadingTemperature"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                
                <div id="tankList" class="dialog"><!-- remains for ajax -->
                
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
