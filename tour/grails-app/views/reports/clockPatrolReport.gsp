
<%@page import="com.surelution.tour.vo.DepartmentPoiClockKey"%>
<%@page import="javax.transaction.UserTransaction"%>
<%@ page import="com.surelution.tour.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'clockPatrolReport.label', default: 'clockPatrolReport')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
	    <div class="nav">
	       <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
	    </div>
    <div class="dialog">
    	<g:form action="clockPatrolReport">
    		日期：<g:datePicker name="date" value="${date}" precision="day"/>
    		<g:submitButton name="查询"/>
    	</g:form>
    	<label style="font-size:14px;color:#0725a7;">（亮黄色代表已做巡检，灰色代表未巡检）</label>
    </div>
    <div class="content">
    <div class="list">
    	<table>
    		<thead>
    			<tr>
    				<td rowspan="2" width="60px" style="text-align: center;vertical-align: middle;background:#75746a;color:#fff;">名称</td>
    				<td colspan="${clockList.size()}" style="text-align:center;background:#75746a;color:#fff;">时间</td>
    			</tr>
    			<tr>
    			<g:each in="${clockList}" var="c">
    				<td style="text-align: center;background:#75746a;color:#fff;border-top:1px solid #fff">${c.clock}点${c.minute}分(向后延迟${c.delay}分钟)</td>
    			</g:each>
    			</tr>
    		</thead>
    		<g:each in="${departments}" var="department" status="i">
    			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
    				<td>${department.shortName }</td>
	    			<g:each in="${clockList }" var="c">
	    				<td>
	    					<table>
	    						<tr>
    								<g:set var="dpois" value="${com.surelution.tour.Poi.findAllByDepartment(department) }"></g:set>
	    							<g:each in="${dpois}" status="c_index" var="poi">
	    								<g:if test="${c_index<maxPoiCount}">
    										<%
												DepartmentPoiClockKey key = new DepartmentPoiClockKey()
												key.department = department
												key.poi = poi
												key.clock = c
												def v = values[key]
											 %>
	    									<td bgcolor="${v==null?'#cbc9ba':'#ec7b1a'}" width="10px">${poi.name }</td>
	    								</g:if>
	    							</g:each>
	    						</tr>
	    					</table>
	    				</td>
	    			</g:each>
    			</tr>
    		</g:each>
    	</table>
    </div>
    </div>
    </body>
</html>
