
<%@page import="com.surelution.tour.Department"%>
<%@ page import="com.surelution.tour.DeliveryScore" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'deliveryScore.label', default: 'DeliveryScore')}" />
        <r:require module="jquery-ui"/>
        <r:layoutResources/>
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
        	<g:set var="gasUnloading" value="${message(code: 'gasUnloading.label', default: 'GasUnloading')}" />
            <h1><g:message code="default.show.label" args="[gasUnloading]" /></h1>
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
            <g:if test="${!deliveryScoreInstanceList}">
            	<font color="red">
            	没有符合要求的配送评价可以关联，请<a href='${createLink(controller:"gasUnloading",action:"show",params:[id:gasUnloadingInstance.id]) }'>返回卸油页面</a>，点击 ${message(code: 'deliveryScore.button.create.label', default: 'Create Delivery Score')} 按钮，添加配送评价
            	</font>
            </g:if>
            <g:else>
	            <div class="list">
	                <h1><g:message code="default.list.label" args="[entityName]" /></h1>
	                <g:form action="link">
	                <table>
	                    <thead>
	                        <tr>
	                        
	                            <th>${message(code: 'deliveryScore.id.label', default: 'Id')}</th>
	                        
	                            <th>${message(code: 'deliveryScore.driverName.label', default: 'Driver Name')}</th>
	                        
	                            <th>${message(code: 'deliveryScore.supercargoName.label', default: 'Supercargo Name')}</th>
	                        
	                            <th>${message(code: 'deliveryScore.trunckNo.label', default: 'Trunck No')}</th>
	                        
	                            <th>${message(code: 'sealWire.label', default: 'sealSn')}</th>

	                            <th>${message(code: 'deliveryScore.reportDate.label', default: 'Report Date')}</th>
	                            
	                            <th>最低单项及得分</th>
	                            
	                            <th>总分</th>
	                        
	                            <th><g:message code="deliveryScore.reportUser.label" default="Report User" /></th>
	                        
	                        </tr>
	                    </thead>
	                    <tbody>
	                    <g:each in="${deliveryScoreInstanceList}" status="i" var="deliveryScoreInstance">
	                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	                        
	                            <td>
	                            	<g:radio name="deliveryScore.id" value="${deliveryScoreInstance.id}"/>
	                            </td>
	                            
	                            <td>${fieldValue(bean: deliveryScoreInstance, field: "driverName")}</td>
	                        
	                            <td>${fieldValue(bean: deliveryScoreInstance, field: "supercargoName")}</td>
	                        
	                            <td>${fieldValue(bean: deliveryScoreInstance, field: "trunckNo")}</td>
	                        
	                            <td>${deliveryScoreInstance.sealSn?.prefix }${deliveryScoreInstance.sealSn?.sn }</td>

	                            <td><g:link action="show" id="${deliveryScoreInstance.id}"><g:formatDate date="${deliveryScoreInstance.reportDate}" /></g:link></td>
	                        
	                        	<td>${deliveryScoreInstance.lowestScoreItem?.type?.title }(${deliveryScoreInstance.lowestScoreItem?.score?.score })</td>
	                        
	                        	<td>${deliveryScoreInstance.totalScore }</td>
	                        
	                            <td>${fieldValue(bean: deliveryScoreInstance, field: "reportUser")}</td>
	                        </tr>
	                    </g:each>
	                    </tbody>
	                </table>
	                <g:hiddenField name="unloading.id" value="${gasUnloadingInstance.id}"/>
	                <g:submitButton name="link" value="关联"/>
	                </g:form>
	            </div>
            </g:else>
        </div>
    </body>
</html>
