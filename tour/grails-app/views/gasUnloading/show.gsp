
<%@ page import="com.surelution.tour.GasUnloading" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasUnloading.label', default: 'GasUnloading')}" />
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
                                    <g:message code="gasUnloading.unloadingTime.label" default="Unloading Time" />
                                </td>
                                <td colspan="2" valign="top" class="value">
                                	<g:formatDate date="${gasUnloadingInstance?.unloadingTime}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasUnloading.formNo.label" default="Form No" />
                                </td>
                                <td colspan="2" valign="top" class="value">
                                    ${gasUnloadingInstance?.formNo}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="department.label" default="Department" />
                                </td>
                                <td colspan="2" valign="top" class="value">
                                	${gasUnloadingInstance.department.name }
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasUnloading.planningAmount.label" default="Planning Amount" />
                                </td>
                                <td colspan="2" valign="top" class="value">
                                    ${fieldValue(bean: gasUnloadingInstance, field: 'planningAmount')}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasUnloading.gasType.label" default="Gas Type" />
                                </td>
                                <td colspan="2" valign="top" class="value ${hasErrors(bean: gasUnloadingInstance, field: 'gasType', 'errors')}">
                                	${gasUnloadingInstance.gasType.title}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasUnloading.tankFarm.label" default="Tank Farm" />
                                </td>
                                <td colspan="2" valign="top" class="value">
                                	${gasUnloadingInstance.tankFarm.name }
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasUnloading.warehouseNo.label" default="Warehouse No" />
                                </td>
                                <td colspan="2" valign="top" class="value">
                                    ${fieldValue(bean: gasUnloadingInstance, field: 'warehouseNo')}
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasUnloading.loadingUser.label" default="loadingUser" />
                                </td>
                                <td colspan="2" valign="top" class="value">
                                    ${fieldValue(bean: gasUnloadingInstance, field: 'loadingUser')}
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
                                	${gasUnloadingInstance.entruckingViewVolume }
                                </td>
                                <td valign="top">
                                	${gasUnloadingInstance.unloadingViewVolume}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasUnloading.stdVolume.label" default="Std Volume" />
                                </td>
                                <td valign="top">
                                	${gasUnloadingInstance.entruckingStdVolume}
                                </td>
                                <td valign="top">
                                	${gasUnloadingInstance.unloadingStdVolume}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasUnloading.density.label" default="Density" />
                                </td>
                                <td valign="top">
                                	${gasUnloadingInstance.entruckingDensity}
                                </td>
                                <td valign="top">
                                	${gasUnloadingInstance.unloadingDensity}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="gasUnloading.temperature.label" default="Temperature"/>
                                </td>
                                <td valign="top">
                                	${gasUnloadingInstance.entruckingTemperature}
                                </td>
                                <td valign="top">
                                	${gasUnloadingInstance.unloadingTemperature}
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                
                <div id="tankList" class="dialog">
                	<table>
                		<tr>
                			<td>${message(code:'gasTank.tankNo.label')}</td>
							<td>${message(code:'gasUnloadingItem.amount.label')}</td>
							<td>${message(code:'gasUnloadingItem.stdVolume.label')}</td>
							<td>${message(code:'gasUnloadingItem.density.label')}</td>
							<td>${message(code:'gasUnloadingItem.temperature.label')}</td>
							<td>${message(code:'gasUnloadingItem.preUnloadingHeight.label')}</td>
							<td>${message(code:'gasUnloadingItem.postUnloadingHeight.label')}</td>
						</tr>
						<g:each in="${gasUnloadingInstance.items}" var="t">
							<tr>
								<td>${t.tank.tankNo}(${t.tank.gasType.title})</td>
								<td>
									${t.amount }
								</td>
								<td>
									${t.stdVolume }
								</td>
								<td>
									${t.density }
								</td>
								<td>
									${t.temperature }
								</td>
								<td>
									${t.preUnloadingHeight }
								</td>
								<td>
									${t.postUnloadingHeight }
								</td>
							</tr>
						</g:each>
                	</table>
                </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${gasUnloadingInstance?.id}" />
                    	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <span class="button">
                    	<g:if test="${gasUnloadingInstance.score }">
                    		<input type="button" class="edit" onclick="goLinkDeliveryScore()" value="查看配送评价" />
                    	</g:if>
                    	<g:else>
	                    	<input type="button" class="edit" onclick="goCreateDeliveryScore()" value="${message(code: 'deliveryScore.button.create.label', default: 'Create Delivery Score')}" />
	                    	<input type="button" class="edit" onclick="goLinkDeliveryScore()" value="${message(code: 'deliveryScore.button.link.label', default: 'Create Delivery Score')}" />
                    	</g:else>
                    </span>
                    <script>
						function goCreateDeliveryScore() {
							var url = '${createLink(controller:'deliveryScore', action:'create', params:['unloading.id':gasUnloadingInstance?.id])}';
							document.location.href=url
						}
						function goLinkDeliveryScore() {
							var url = '${createLink(controller:'deliveryScore', action:'showLink', params:['unloading.id':gasUnloadingInstance?.id])}';
							document.location.href=url
						}
                    </script>
                </g:form>
            </div>
        </div>
    </body>
</html>
