
<%@page import="com.surelution.tour.vo.DepartmentPoiClockKey"%>
<%@page import="javax.transaction.UserTransaction"%>
<%@ page import="com.surelution.tour.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'clockPatrolReport.label', default: 'clockPatrolReport')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <g:javascript library="jquery"/>
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.printElement.min.js')}"></script>
		<script type="text/javascript">
			$(document).ready(function() {
			   $("#simplePrint").click(function() { 
			       printElem({leaveOpen: true, printMode: 'popup', overrideElementCSS: ["${resource(dir:'css',file:'main.css')}"]});
			   });
			});
			function printElem(options){
			    $('#areaToPrint').printElement(options);
			}
	
	    </script>
    </head>
    <body>
	    <div class="nav">
	       <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
	    </div>
    <div class="dialog">
    	<g:form action="supervisorSumMonthlyReport">
    		日期：<g:datePicker name="month" precision="month"/>
    		巡检人员<g:textField name="reporter" value="${reporter}" />
    		<g:submitButton name="查询"/><input type="button" value="打印报表" id="simplePrint" />
    	</g:form>
    </div>
    <div class="content">
    <div id="areaToPrint" class="list" style="width: 1200px">
    	<table>
    		<thead>
    			<tr>
    				<td>日期</td>
    				<td>时间</td>
    				<td>站</td>
    				<g:each in="${allTopics}" var="topic">
    					<td style="width:60px">${topic.shortTitle }</td>
    				</g:each>
    				<td style="width:80px">备注</td>
    			</tr>
    		</thead>
    		<g:each in="${list}" var="logSum">
    			<tr>
    				<td>${logSum[0].patrolLog.patrol.patrolDay }</td>
    				<td>${logSum[0].patrolLog.patrol.items.first().patrolTime.format('HH:mm') }-${logSum[0].patrolLog.patrol.items.last().patrolTime.format('HH:mm') }</td>
    				<td>${logSum[0].patrolLog.patrol.department.name }(${(logSum[0].patrolLog.patrol.items.last().patrolTime.time - logSum[0].patrolLog.patrol.items.first().patrolTime.time)/60000 })</td>
    				<g:each	in="${1..logSum.length - 1 }" var="i">
    					<td>${com.surelution.tour.PatrolLogItem.answersMap.get(logSum[i]) }</td>
    				</g:each>
    				<td>${logSum[0].patrolLog.remark }</td>
    			</tr>
    		</g:each>
    	</table>
    </div>
    </div>
    </body>
</html>
