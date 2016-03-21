
<%@page import="com.surelution.tour.Department"%>
<%@page import="javax.transaction.UserTransaction"%>
<%@ page import="com.surelution.tour.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <resource:calendarMonthView/>
        <g:set var="entityName" value="${message(code: 'supervisorMonthlyReport.label', default: 'supervisorMonthlyReport')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <g:javascript library="jquery"/>
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.printElement.min.js')}"></script>
    </head>
    <body>
    	<div class="nav">
	       <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
	    </div>
	     <g:message code="${message(code: 'supervisorMonthlyReport.label', default: 'supervisorMonthlyReport')}" />
	                 （括号中数字代表巡检时间，单位为分钟）<g:form action="supervisorMonthlyReport">
	    <br/>
	    巡查人：<g:select name="user.id" value="${user?.id}" from="${users}" optionKey="id" optionValue="username"/>
	    请选择日期：<g:datePicker name="month" precision="month" value="${month}"/><g:submitButton name="查看报表"/>
	    <g:if test="${user != null && month != null}"><input type="button" value="打印报表" id="simplePrint" /></g:if>
	    </g:form>
	    <div id="areaToPrint" style="width:896px">
		    <g:if test="${user != null && month != null}">
		    	${user.username }巡查月报表(${month.format("yyyy-MM") })
		    	<richui:calendarMonthView items="${patrols}" month="${month}" createLink="true" controller="patrol" action="show" constraintDateFields="['patrolDate']" displayField="message" locale="zh_CN"/>
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
