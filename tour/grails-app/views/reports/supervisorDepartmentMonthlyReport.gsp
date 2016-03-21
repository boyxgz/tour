
<%@page import="com.surelution.tour.Department"%>
<%@page import="javax.transaction.UserTransaction"%>
<%@ page import="com.surelution.tour.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <resource:calendarMonthView/>
        <g:set var="entityName" value="${message(code: 'supervisorDepartmentMonthlyReport.label', default: 'supervisorDepartmentMonthlyReport')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <g:javascript library="jquery"/>
        <script type="text/javascript" src="/tour/js/jquery/jquery.printElement.min.js"></script>
    </head>
    <body>
    	<div class="nav">
	       <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
	    </div>
	    <g:message code="${message(code: 'supervisorDepartmentMonthlyReport.label', default: 'supervisorDepartmentMonthlyReport')}" />
	    <g:form action="supervisorDepartmentMonthlyReport">（括号中数字代表巡检时间，单位为分钟）
	    <br/>
	    部门：<g:select name="department.id" value="${department?.id}" from="${com.surelution.tour.Department.list()}" optionKey="id" optionValue="shortName"/>
	    请选择日期：<g:datePicker name="date" precision="month" value="${month }"/><g:submitButton name="查看报表"/>
	    <g:if test="${department != null && month != null}"><input type="button" value="打印报表" id="simplePrint" /></g:if>
	    </g:form>
	    <div id="areaToPrint" style="width:895px">
		    <g:if test="${department != null && month != null}">
		    	${department.name }上级巡查月报表(${month.format("yyyy-MM") })
		    	<richui:calendarMonthView locale="zh_CN" items="${patrols}" createLink="true" controller="patrol" action="show" month="${month}" constraintDateFields="['patrolDate']" displayField="username"/>
		    </g:if>
	    </div>
	<script type="text/javascript">
		$(document).ready(function() {
		   $("#simplePrint").click(function() { 
		       printElem({leaveOpen: true, printMode: 'popup', overrideElementCSS: ["${resource(dir:'plugins/richui-0.8/css',file:'calendarmonthview.css')}","${resource(dir:'css',file:'main.css')}"]});
		   });
		});
		function printElem(options){
		    $('#areaToPrint').printElement(options);
		}
    </script>
    </body>
</html>
