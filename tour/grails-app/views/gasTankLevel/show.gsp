
<%@ page import="com.surelution.tour.GasTankLevel" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasTankLevel.label', default: 'GasTankLevel')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
            	<table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasTankLevel.tank.label" default="Tank" />
                                </td>
                                <td valign="top" class="value" colspan="3">
                                	${gasTankLevelInstance.tank.tankNo}(${gasTankLevelInstance.tank.department.name})
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name" style="width: 25%">
                                    <g:message code="gasTankLevel.instrumentAmount.label" default="Instrument Amount" />
                                </td>
                                <td valign="top" class="value" style="width: 25%">
                                    ${fieldValue(bean: gasTankLevelInstance, field: 'instrumentAmount')}&nbsp;MM
                                </td>
                                <td valign="top" class="name" style="width: 25%"><g:message code="gasTankLevel.amout.label" default="Amout" /></td>
                                <td valign="top" class="value" style="width: 25%">${fieldValue(bean: gasTankLevelInstance, field: 'amout')}&nbsp;MM</td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name" style="width: 25%">
                                    <g:message code="gasTankLevel.instrumentTemprature.label" default="Instrument Temprature" />
                                </td>
                                <td valign="top" class="value" style="width: 25%">${fieldValue(bean: gasTankLevelInstance, field: 'instrumentTemprature')}&nbsp;℃</td>
                                <td valign="top" class="name" style="width: 25%"><g:message code="gasTankLevel.temprature.label" default="Temprature" /></td>
                                <td valign="top" class="value" style="width: 25%">${fieldValue(bean: gasTankLevelInstance, field: 'temprature')}&nbsp;℃</td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name" style="width: 25%">
                                    <g:message code="gasTankLevel.instrumentWaterLevel.label" default="Instrument Water Level" />
                                </td>
                                <td valign="top" class="value" style="width: 25%">${fieldValue(bean: gasTankLevelInstance, field: 'instrumentWaterLevel')}&nbsp;MM</td>
                                <td valign="top" class="name" style="width: 25%"><g:message code="gasTankLevel.waterLevel.label" default="Water Level" /></td>
                                <td valign="top" class="value" style="width: 25%">${fieldValue(bean: gasTankLevelInstance, field: 'waterLevel')}&nbsp;MM</td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasTankLevel.density.label" default="Density" />
                                </td>
                                <td valign="top" class="value" style="width: 25%">${fieldValue(bean: gasTankLevelInstance, field: 'density')}&nbsp;kg/m³</td>
                                <td valign="top" class="name" style="width: 25%"><g:message code="gasTankLevel.lastPdnDensity.label" default="lastPdnDensity" /></td>
                                <td valign="top" class="value" style="width: 25%">${fieldValue(bean: gasTankLevelInstance, field: 'lastPdnDensity')}&nbsp;kg/m³</td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasTankLevel.impurityState.label" default="Impurity State" />
                                </td>
                                <td valign="top" class="value" colspan="3">
                                    ${gasTankLevelInstance?.impurityState?"杂质:":"无杂质"}${gasTankLevelInstance?.impurityInfo}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasTankLevel.colorState.label" default="Color State" />
                                </td>
                                <td valign="top" class="value" colspan="3">
                                    ${gasTankLevelInstance?.colorState?"异常:":"无异常"}${gasTankLevelInstance?.colorInfo}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasTankLevel.checkTime.label" default="Check Time" />
                                </td>
                                <td valign="top" class="value" colspan="3">
                                	<g:formatDate date="${gasTankLevelInstance?.checkTime}"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${gasTankLevelInstance?.id}" />
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
