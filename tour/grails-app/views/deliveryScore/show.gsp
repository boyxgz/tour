
<%@ page import="com.surelution.tour.DeliveryScore" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'deliveryScore.label', default: 'DeliveryScore')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
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
                            <td valign="top" class="name"><g:message code="deliveryScore.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: deliveryScoreInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="deliveryScore.driverName.label" default="Driver Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: deliveryScoreInstance, field: "driverName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="deliveryScore.reportDate.label" default="Report Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${deliveryScoreInstance?.reportDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="deliveryScore.reportUser.label" default="Report User" /></td>
                            
                            <td valign="top" class="value">${deliveryScoreInstance?.reportUser?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="deliveryScore.supercargoName.label" default="Supercargo Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: deliveryScoreInstance, field: "supercargoName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="deliveryScore.trunckNo.label" default="Trunck No" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: deliveryScoreInstance, field: "trunckNo")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="deliveryScore.unloading.label" default="Unloading" /></td>
                            
                            <td valign="top" class="value">
                            	<g:each in="${deliveryScoreInstance.unloadings}" var="unloading">
                            		${unloading.formNo },
                            	</g:each>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="sealWire.label" default="Seal Wire" /></td>
                            
                            <td valign="top" class="value">
                            	${deliveryScoreInstance.sealSn?.prefix }${deliveryScoreInstance.sealSn?.sn }
                            </td>
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'gasUnloading.id.label', default: 'Id')}" />
                        
                            <th><g:message code="department.label" default="Department" /></th>
                        
                            <th><g:message code="gasTank.label" default="Gas Tank" /></th>

                            <g:sortableColumn property="amount" title="${message(code: 'gasUnloading.amount.label', default: 'Amount')}" />
                        
                            <g:sortableColumn property="formNo" title="${message(code: 'gasUnloading.formNo.label', default: 'Form No')}" />
                        
                            <g:sortableColumn property="planningAmount" title="${message(code: 'gasUnloading.planningAmount.label', default: 'Planning Amount')}" />
                        
                            <g:sortableColumn property="unloadingTime" title="${message(code: 'gasUnloading.unloadingTime.label', default: 'Unloading Time')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${deliveryScoreInstance.unloadings}" status="i" var="gasUnloadingInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${gasUnloadingInstance.id}">${fieldValue(bean: gasUnloadingInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: gasUnloadingInstance, field: "department.name")}</td>
                        
                            <td>
                            	${gasUnloadingInstance.splitted?"分卸：":"" }
                            	<g:each in="${gasUnloadingInstance.items}" var="item">
                            		${item.tank.tankNo }&nbsp;
                            	</g:each>
                            </td>
                        
                            <td>${fieldValue(bean: gasUnloadingInstance, field: "amount")}</td>
                        
                            <td>${fieldValue(bean: gasUnloadingInstance, field: "formNo")}</td>
                        
                            <td>${fieldValue(bean: gasUnloadingInstance, field: "planningAmount")}</td>
                        
                            <td><g:formatDate date="${gasUnloadingInstance.unloadingTime}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <th><g:message code="deliveryScoreItem.type.label" default="Type" /></th>
                            <g:sortableColumn property="score" title="${message(code: 'deliveryScoreItem.score.label', default: 'Score')}" />
                            <g:sortableColumn property="score" title="${message(code: 'deliveryScoreItem.remark.label', default: 'Remark')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${deliveryScoreItemInstanceList}" status="i" var="deliveryScoreItemInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td title="${deliveryScoreItemInstance.type.description }">${fieldValue(bean: deliveryScoreItemInstance, field: "type.title")}</td>
                        
                            <td>${deliveryScoreItemInstance.score.title}(${deliveryScoreItemInstance.score.score})</td>
                            <td>${deliveryScoreItemInstance.remark}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${deliveryScoreInstance?.id}" />
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
