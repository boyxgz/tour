
<%@page import="com.surelution.tour.Department"%>
<%@page import="javax.transaction.UserTransaction"%>
<%@ page import="com.surelution.tour.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'DepartmentMonthlyReport.label', default: 'DepartmentMonthlyReport')}" />
        <g:javascript library="jquery"/>
        <script type="text/javascript" src="/tour/js/jquery/jquery.printElement.min.js"></script>
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
    	<div class="nav">
	       <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
	    </div>
	    <g:message code="${message(code: 'DepartmentMonthlyReport.label', default: 'DepartmentMonthlyReport')}"/>
	    <g:form action="departmentMonthlyReport">
	    <br/>
	    请选择日期：<g:datePicker name="month" precision="month" value="${month }"/><g:submitButton id="btnReport" name="查看报表" onsubmit="this.disabled=true;return true;"/>
	    <g:if test="${month}"><input type="button" value="打印报表" id="simplePrint" /></g:if>
	    </g:form>
	    <div style="width:500px;font-size:12px;" id="areaToPrint">
	    <g:if test="${month != null}">
	    	站内巡查月报表(${month.format("yyyy-MM") })<br/>
	    	本月共${daysInMonth}天，根据系统设置，每天共需巡检${clockCount}次
	    	<div class="content2">
	    	<div class="list">
                <table>
                    <thead>
                        <tr>
                        	<th>名称</th>
                        	<th>出巡次数/应出巡次数</th>
                        	<th>点位巡检次数/应点位巡检次数</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:set value="${daysInMonth * clockCount}" var="monthlyPatrolCount"/>
                    <g:set value="0:|" var="departmentNames"/>
                    <g:set value="" var="no1"/>
                    <g:set value="" var="no2"/>
                    <g:each in="${departments}" var="department" status="i">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        	<td>${department.shortName}</td>
                        	<g:set value="${patrolSummaryMap[department] }" var="summary"/>
                        	
                        	<g:set var="patrolCountPercentage" value="${(int)((summary?summary?.patrolCount:0) * 100/ monthlyPatrolCount)}"/>
                        	<g:set var="patrolItemCountPercentage" value="${(int)((summary?summary?.patrolItemCount:0) * 100 / (monthlyPatrolCount * (departmentPoiCountMap[department])?(departmentPoiCountMap[department]):1))}"/>
                        	<g:if test="${i != 0}">
                        		<g:set value="${departmentNames + '|'}" var="departmentNames"/>
                        		<g:set value="${no1 + ',' }" var="no1"/>
                        		<g:set value="${no2 + ',' }" var="no2"/>
                        	</g:if>
                       		<g:set value="${departmentNames + department.shortName.encodeAsURL()}" var="departmentNames"/>
                       		<g:set value="${no1 + patrolCountPercentage}" var="no1"/>
                       		<g:set value="${no2 + patrolItemCountPercentage}" var="no2"/>
                        	
                        	<td>${patrolCountPercentage}%(${summary?summary.patrolCount:0 }/${monthlyPatrolCount})</td>
                        	<td>${(int)((summary?summary.patrolItemCount:0) * 100 / (monthlyPatrolCount * departmentPoiCountMap[department]))}%(${summary?summary.patrolItemCount:0 }/${monthlyPatrolCount * departmentPoiCountMap[department]})</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        <img alt="chart" src="${grailsApplication.config.chartAPI.location}?chs=1000x300&cht=bvg&chco=4d89f9,c6d9fd&chd=t:${no2 }|${no1 }&chxl=${departmentNames }&chxt=x,y&chdl=${'点位巡检次数/应点位巡检次数'.encodeAsURL()}|${'出巡次数/应出巡次数'.encodeAsURL()}&chdlp=t&chm=N,000000,0,,6%7CN,000000,1,,6">
	    <br>
	    本次生成报表用时${System.currentTimeMillis() - start}毫秒<br/>
	    特别提示：本报表生成非常耗费系统资源，可能导致其他用户响应变慢，请只在必要时查看该报表
	    </g:if>
	    </div>
	    </div>
	    
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnReport").disabled = false;
		   $("#simplePrint").click(function() { 
		       printElem({leaveOpen: true, printMode: 'popup', overrideElementCSS: ["${resource(dir:'css',file:'main.css')}"]});
		   });
		});
		function printElem(options){
		    $('#areaToPrint').printElement(options);
		}
    </script>
    </body>
</html>
