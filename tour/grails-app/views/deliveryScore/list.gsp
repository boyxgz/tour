
<%@page import="com.surelution.tour.Department"%>
<%@ page import="com.surelution.tour.DeliveryScore" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'deliveryScore.label', default: 'DeliveryScore')}" />
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
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form action="list" >
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    所属油站
                                </td>
                                <td valign="top" class="value">
                                	<g:set var="username" value="${sec.loggedInUserInfo(field:'username').toString()}"/>
                                	<g:select name="department.id" from="${com.surelution.tour.UserDepartment.getUserDepartments(username)}" optionKey="id" optionValue="name" noSelection='${["":""] }' value="${params['department.id'] }"/>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    卸油起止时间
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="dateFrom" value="${params.dateFrom }"/>~
                                	<g:textField name="dateTo" value="${params.dateTo }"/>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    总分数区间
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="scoreFrom" value="${params.scoreFrom }"/>~
                                	<g:textField name="scoreTo" value="${params.scoreTo }"/>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    最低单项得分区间
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="itemScoreFrom" value="${params.itemScoreFrom }"/>~
                                	<g:textField name="itemScoreTo" value="${params.itemScoreTo }"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="search" class="search" value="${message(code: 'default.button.search.label', default: 'Search')}" /></span>
                </div>
            </g:form>
            <div class="list" style="overflow: scroll;height:480px">
                <table>
                    <thead>
                        <tr>
                        
                            <th>${message(code: 'deliveryScore.id.label', default: 'Id')}</th>
                        
                            <th>${message(code: 'deliveryScore.driverName.label', default: 'Driver Name')}</th>
                        
                            <th>${message(code: 'deliveryScore.supercargoName.label', default: 'Supercargo Name')}</th>
                        
                            <th>${message(code: 'deliveryScore.trunckNo.label', default: 'Trunck No')}</th>
                        			
							<th>${message(code: 'sealWire.label', default: 'sealSn')}</th>
                        
                            <th>${message(code: 'deliveryScore.reportDate.label', default: 'Report Date')}</th>
                            
                            <th>最低单项及得分</th>
                            
                            <th>总分</th>
                        
                            <th><g:message code="deliveryScore.reportUser.label" default="Report User" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${deliveryScoreInstanceList}" status="i" var="deliveryScoreInstance">
                    <g:if test="${i<20}">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${deliveryScoreInstance.id}">${fieldValue(bean: deliveryScoreInstance, field: "id")}</g:link></td>
                            
                            <td>${fieldValue(bean: deliveryScoreInstance, field: "driverName")}</td>
                        
                            <td>${fieldValue(bean: deliveryScoreInstance, field: "supercargoName")}</td>
                        
                            <td>${fieldValue(bean: deliveryScoreInstance, field: "trunckNo")}</td>
                        	                     
	                        <td>${deliveryScoreInstance.sealSn?.prefix }${deliveryScoreInstance.sealSn?.sn }</td>
                        
                            <td><g:formatDate date="${deliveryScoreInstance.reportDate}" /></td>
                        
                        	<td>${deliveryScoreInstance.lowestScoreItem?.type?.title }(${deliveryScoreInstance.lowestScoreItem?.score?.score })</td>
                        
                        	<td>${deliveryScoreInstance.totalScore }</td>
                        
                            <td>${fieldValue(bean: deliveryScoreInstance, field: "reportUser")}</td>
                        </tr>
                       </g:if>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
