
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.surelution.tour.vo.PatrolDayPoiClockKey"%>
<%@page import="com.surelution.tour.Department"%>
<%@page import="com.surelution.tour.vo.DepartmentPoiClockKey"%>
<%@page import="javax.transaction.UserTransaction"%>
<%@ page import="com.surelution.tour.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'departmentClockPatrolReport.label', default: 'departmentClockPatrolReport')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <r:require module="jquery-ui"/>
        <r:layoutResources/>
        <script type="text/javascript">
	        $(function() {
	        	$.datepicker.regional[ "zh_CN" ] = { closeText: "关闭", prevText: "&#x3c;上月", nextText: "下月&#x3e;", currentText: "今天", monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"], monthNamesShort: ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"], dayNames: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"], dayNamesShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"], dayNamesMin: ["日", "一", "二", "三", "四", "五", "六"], weekHeader: "周", dateFormat: "yy-mm-dd", firstDay: 1, isRTL: !1, showMonthAfterYear: !0, yearSuffix: "年" }
		        $.datepicker.setDefaults( $.datepicker.regional[ "zh_CN" ] );
	            $( "#dateFrom" ).datepicker();
	            $( "#dateTo" ).datepicker();
	        });
	    </script>
    </head>
    <body>
	    <div class="nav">
	       <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
	    </div>
    <div class="dialog">
    	<g:form action="departmentClockPatrolReport">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    所属油站
                                </td>
                                <td valign="top" class="value">
                                	<g:select name="department.id" from="${Department.list()}" optionKey="id" optionValue="shortName" value="${department?.id }"/>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    日期
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="dateFrom" value="${params.dateFrom }"/>~
            						<g:textField name="dateTo" value="${params.dateTo }"/>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name" colspan="2">
                                    <g:submitButton name="查询"/>
                                </td>
                            </tr>
                          </tbody>
                      </table>
                   </div>
    	</g:form>
    	<label style="font-size:14px;color:#0725a7;">（亮黄色代表已做巡检，灰色代表未巡检）</label>
    </div>
    <div class="content" style="height: 550px">
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
    		<g:if test="${department }">
    		<g:set var="dpois" value="${com.surelution.tour.Poi.findAllByDepartment(department) }"></g:set>
    		<%
				def sdf = new SimpleDateFormat("yyyyMMdd");
			 %>
    		<g:each in="${days}" var="day" status="i">
    			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
    				<td>${formatDate(date:day,format:'yyyy-MM-dd') }</td>
	    			<g:each in="${clockList }" var="c">
	    				<td>
	    					<table>
	    						<tr>
    								
	    							<g:each in="${dpois}" status="c_index" var="poi">
	    								<g:if test="${c_index<maxPoiCount}">
    										<%
												PatrolDayPoiClockKey key = new PatrolDayPoiClockKey()
												key.patrolDay = sdf.format(day)
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
    	</g:if>
    	</table>
    </div>
    </div>
    </body>
</html>
