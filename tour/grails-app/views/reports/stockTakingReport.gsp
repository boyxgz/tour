
<%@page import="com.surelution.tour.vo.DepartmentPoiClockKey"%>
<%@page import="javax.transaction.UserTransaction"%>
<%@ page import="com.surelution.tour.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:javascript library="jquery"/>
        <r:require module="jquery-ui"/>
        <r:layoutResources/>
        <g:set var="entityName" value="${message(code: 'clockPatrolReport.label', default: 'clockPatrolReport')}" />
        <title><g:message code="default.stockTakingReport.label" args="[entityName]" /></title>
        <script type="text/javascript">
	        $(function() {
	        	$.datepicker.regional[ "zh_CN" ] = { closeText: "关闭", prevText: "&#x3c;上月", nextText: "下月&#x3e;", currentText: "今天", monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"], monthNamesShort: ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"], dayNames: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"], dayNamesShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"], dayNamesMin: ["日", "一", "二", "三", "四", "五", "六"], weekHeader: "周", dateFormat: "yy-mm-dd", firstDay: 1, isRTL: !1, showMonthAfterYear: !0, yearSuffix: "年" }
		        $.datepicker.setDefaults( $.datepicker.regional[ "zh_CN" ] );
	            $( "#from" ).datepicker();
	            $( "#to" ).datepicker();
	        });
	        function loadTank() {
				$('#tank\\.id').find("option").remove();
				$('#tank\\.id').append($("<option></option>"));
	
				var deptId = $("#department\\.id");
				if(deptId.val() == null) 
					return;
				
				var request = $.ajax({
					url: '${createLink(controller:"gasTank", action:"loadTanksByDepartment")}',
				  	data: {departmentId:deptId.val()},
				  	type:"Get",
				  	dataType: 'xml',
				  	cache:false,
				  	success: parseXml
					});
			}
	
			function parseXml(xml) {
				var dept = $(xml).find("department");
				var name = $(dept).attr("name");
				var id = $(dept).attr("id");
	
				$(xml).find("tank").each(function(index, tank){
					var tankNo = $(tank).attr("tankNo");
					var id = $(tank).attr("id");
					var description = $(tank).attr("description");
					var volume = $(tank).attr("volume");
					var gasType = $(tank).attr("gasType");
					$('#tank\\.id')
			         .append($("<option></option>")
			         .attr("value",id)
			         .text(tankNo + ", " + gasType));
				});
			}
	    </script>
    </head>
    <body>
	    <div class="nav">
	       <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
	    </div>
    <div class="dialog">
    	<h1> <g:message code="default.stockTakingReport.label" args="[entityName]" /></h1>
    	<g:form action="stockTakingReport">
    		<div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    所属油站
                                </td>
                                <td valign="top" class="value">
                                	<g:set var="username" value="${sec.loggedInUserInfo(field:'username').toString()}"/>
                                	<g:select name="department.id" from="${com.surelution.tour.UserDepartment.getUserDepartments(username)}" noSelection="${['':''] }" optionKey="id" optionValue="name" value="${params['department.id'] }" onchange="loadTank()" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    日期
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="from" value="${params.from }"/>——
                                	<g:textField name="to" value="${params.to }"/>
                                	<span class="button"><g:submitButton name="search" class="search" value="${message(code: 'default.button.search.label', default: 'Search')}" /></span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
    	</g:form>
    </div>
    <div class="content">
    <div class="list">
    	<table>
    		<thead>
    			<tr>
    				<td>加油站</td>
    				<td>初次盘点</td>
    				<td>末次盘点</td>
    				<td>盘点次数</td>
    				<td>损耗率</td>
    			</tr>
    		</thead>
    		<g:if test="takings">
	    		<g:each in="${takings}" var="taking" status="i">
	    			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	    				<td><a href="${createLink(controller:'stockTaking', action:'contrast', params:[start:taking.firstTaking?.id, end:taking.lastTaking?.id, 'department.id':taking.department.id]) }">${taking.department.name }</a></td>
	    				<td><g:formatDate date="${taking.firstTaking?.takingTime }"/></td>
	    				<td><g:formatDate date="${taking.lastTaking?.takingTime }"/></td>
	    				<td>${taking.takingCount}</td>
	    				<td><g:formatNumber number="${-taking?.financialShrinkRate * 1000 }" maxFractionDigits="3"/></td>
	    			</tr>
	    		</g:each>
	    	</g:if>
    	</table>
    	说明：正数为盘盈，负数为盘亏
    </div>
    </div>
    </body>
</html>
