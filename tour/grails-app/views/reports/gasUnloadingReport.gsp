
<%@page import="com.surelution.tour.vo.DepartmentPoiClockKey"%>
<%@page import="javax.transaction.UserTransaction"%>
<%@ page import="com.surelution.tour.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'clockPatrolReport.label', default: 'clockPatrolReport')}" />
        <title><g:message code="default.gasUnloadingReport.label" /></title>
    </head>
    <body>
	    <div class="nav">
	       <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
	    </div>
    <div class="dialog">
    	<h1><g:message code="default.gasUnloadingReport.label" /></h1>
    	<g:form action="gasUnloadingReport">
    		日期：<g:datePicker name="from" value="${params.from}" precision="day"/>--
    		<g:datePicker name="to" value="${params.to}" precision="day"/>
    		<g:submitButton name="查询"/>
    	</g:form>
    </div>
    <div class="content">
    <div class="list">
    	<table>
    		<thead>
    			<tr>
    				<td>${message(code:'department.label') }</td>
    				<td>${message(code:'gasUnloading.formNo.label') }</td>
    				<td>${message(code:'gasUnloading.planningAmount.label') }</td>
    				<td>${message(code:'gasUnloading.amount.label') }</td>
    				<td>${message(code:'gasUnloading.shirinkRate.label') }</td>
    				<td>${message(code:'gasUnloading.splitted.label') }</td>
    				<td>${message(code:'gasUnloading.unloadingTime.label') }</td>
    			</tr>
    		</thead>
    		<g:each in="${unloadings}" var="unloading" status="i">
    			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
    				<td>${unloading.department.name }</td>
    				<td>${unloading.formNo }</td>
    				<td>${unloading.planningAmount }</td>
    				<td>${unloading.amount }</td>
    				<td>${formatNumber(number:(unloading.amount-unloading.planningAmount)/unloading.planningAmount*1000, maxFractionDigits:3) }</td>
    				<td>${unloading.items.size()>1?"是":"否"}</td>
    				<td><g:formatDate date="${unloading.unloadingTime }"/></td>
    			</tr>
    		</g:each>
    	</table>
    </div>
    </div>
    </body>
</html>
