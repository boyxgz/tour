
<%@page import="javax.transaction.UserTransaction"%>
<%@ page import="com.surelution.tour.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'datePatrolReport.label', default: 'datePatrolReport')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
    	<div class="nav">
	       <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
	    </div>
	    <g:form action="datePatrolReport">
	            <g:message code="${message(code: 'datePatrolReport.label', default: 'datePatrolReport')}" /><br/>
	    请选择日期：<g:datePicker name="date" precision="day" value="${date}"/><g:submitButton name="查看报表"/>
	    </g:form>
   		<p style="font-size:12px;"> 报表日期：<g:formatDate date="${date}" format="yyyy-MM-dd"/></p>
    <div class="content">
	    <div class="list">
                <table>
                    <thead>
                        <tr>
                            <th>巡检人员</th>
                            <th>加油站</th>
                            <th>详情</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:set var="userOccur" value="${0}"/>
                    <g:set var="lastUserId" value="${0}"/>
                    <g:each in="${patrols}" var="patrol">
                    	<g:if test="${lastUserId != patrol.user.id }">
                    		<g:set var="userOccur" value="${userOccur + 1}"/>
                    		<g:set var="lastUserId" value="${patrol.user.id}"/>
                    	</g:if>
                        <tr class="${(userOccur % 2) == 0 ? 'odd' : 'even'}">
                            <td>${fieldValue(bean: patrol, field: "user.username")}</td>
                            <td>${fieldValue(bean: patrol, field: "department.name")}</td>
                            <td>
                            	<g:each in="${patrol.items}" var="item">
	                            	<g:formatDate date="${item.patrolTime }" format="HH:mm"/>&nbsp;
	                            	${fieldValue(bean: item, field: "poi.name")}<br/>
                            	</g:each>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                 </table>

	    </div>
	    </div>
    </body>
</html>
