

<%@page import="com.surelution.tour.DeliveryScoreItemOption"%>
<%@ page import="com.surelution.tour.DeliveryScore" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'deliveryScore.label', default: 'DeliveryScore')}" />
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
            <g:hasErrors bean="${deliveryScoreInstance}">
            <div class="errors">
                <g:renderErrors bean="${deliveryScoreInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="unloading"><g:message code="deliveryScore.unloading.label" default="Unloading" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deliveryScoreInstance, field: 'unloading', 'errors')}">
                                	<g:hiddenField name="unloading.id" value="${unloading.id }"/>
                                	${unloading.formNo }
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="trunckNo"><g:message code="deliveryScore.trunckNo.label" default="Trunck No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deliveryScoreInstance, field: 'trunckNo', 'errors')}">
                                    <g:textField name="trunckNo" value="${deliveryScoreInstance?.trunckNo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="driverName"><g:message code="deliveryScore.driverName.label" default="Driver Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deliveryScoreInstance, field: 'driverName', 'errors')}">
                                    <g:textField name="driverName" value="${deliveryScoreInstance?.driverName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="supercargoName"><g:message code="deliveryScore.supercargoName.label" default="Supercargo Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deliveryScoreInstance, field: 'supercargoName', 'errors')}">
                                    <g:textField name="supercargoName" value="${deliveryScoreInstance?.supercargoName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sealSn.id"><g:message code="sealWire.label" default="Seal Wire" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deliveryScoreInstance, field: 'sealSn.id', 'errors')}">
                                    <g:select name="sealSn.id" from="${availableSeal }" optionKey='id' optionValue="${{it.prefix+it.sn} }"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
	           <div class="list">
	               <table>
	                   <thead>
	                       <tr>
	                           <th><g:message code="deliveryScoreItem.type.label" default="Type" /></th>

	                           <th>${message(code: 'deliveryScoreItem.score.label', default: 'Score')}</th>
	                           <th>${message(code: 'deliveryScoreItem.remark.label', default: 'Remark')}</th>
	                       
	                       </tr>
	                   </thead>
	                   <tbody>
	                   <g:each in="${deliveryScoreItemTypeList}" status="i" var="type">
	                       <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	                           <td>${type.title}</td>
	                           <td>
	                           <g:select name="score_${type.id}" from="${com.surelution.tour.DeliveryScoreItemOption.list()}" optionKey="id" optionValue='${{it.title + "(" + it.score + ")"}}'/>
	                           </td>
	                           <td>
	                           	<g:textField name="remark_${type.id }"/>
	                           </td>
	                       </tr>
	                   </g:each>
	                   </tbody>
	               </table>
	           </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" onclick="return confirm('${message(code: 'default.button.save.confirm.message', default: 'Are you sure?')}');"/></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
