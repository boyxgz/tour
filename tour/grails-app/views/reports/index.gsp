
<%@page import="javax.transaction.UserTransaction"%>
<%@ page import="com.surelution.tour.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'report.label', default: 'reports')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
    	<div class="nav">
	       <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
	    </div>
    <g:form action="datePatrolReport">
   		<p style='font-size:15px;'> 请查询区域经理报表：</p>
    	<p style='font-size:12px;'>请选择日期：<g:datePicker name="date" precision="day" /><g:submitButton name="查看报表"/></p>
    </g:form>
    
    <g:form action="clockPatrolReport">
    
    </g:form>
    </body>
</html>
