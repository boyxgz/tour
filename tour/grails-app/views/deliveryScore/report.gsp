
<%@ page import="com.surelution.tour.GasUnloading" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasUnloading.label', default: 'GasUnloading')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <r:require module="jquery-ui"/>
        <r:layoutResources/>
        <script type="text/javascript">
	        $(function() {
	        	$.datepicker.regional[ "zh_CN" ] = { closeText: "关闭", prevText: "&#x3c;上月", nextText: "下月&#x3e;", currentText: "今天", monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"], monthNamesShort: ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"], dayNames: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"], dayNamesShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"], dayNamesMin: ["日", "一", "二", "三", "四", "五", "六"], weekHeader: "周", dateFormat: "yy-mm-dd", firstDay: 1, isRTL: !1, showMonthAfterYear: !0, yearSuffix: "年" }
		        $.datepicker.setDefaults( $.datepicker.regional[ "zh_CN" ] );
	            $( "#dateFrom" ).datepicker();
	            $( "#dateTo" ).datepicker();
	        });

	        $(document).ready(function() {
	        	loadTank();
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
        <div class="body" style="overflow: scroll;height: 700px">
            <h1>卸油损耗报表</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            
            <g:form action="report" >
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    所属油站
                                </td>
                                <td valign="top" class="value">
                                	<g:set var="username" value="${sec.loggedInUserInfo(field:'username').toString()}"/>
                                	<g:select name="department.id" from="${com.surelution.tour.UserDepartment.getUserDepartments(username)}" optionKey="id" optionValue="name" noSelection='${["":""] }' value="${params['department.id'] }" onchange="loadTank()"/>
                                    <g:select name="tank.id" id="tank.id" from=""/>
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="formNo"><g:message code="gasUnloading.formNo.label" default="Form No" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="formNo" value="${params.formNo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="gasType.id"><g:message code="gasUnloading.gasType.label" default="Gas Type" /></label>
                                </td>
                                <td colspan="2" valign="top" class="value ${hasErrors(bean: gasUnloadingInstance, field: 'gasType', 'errors')}">
                                	<g:select name="gasType.id" from="${com.surelution.tour.GasType.list() }" noSelection="${['':''] }" optionKey="id" optionValue="title" value="${params.'gasType.id' }"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tankFarm.id"><g:message code="gasUnloading.tankFarm.label" default="Tank Farm" /></label>
                                </td>
                                <td colspan="2" valign="top" class="value ${hasErrors(bean: gasUnloadingInstance, field: 'planningAmount', 'errors')}">
                                	<g:select name="tankFarm.id" optionKey="id" optionValue="name" noSelection="${['':''] }" from="${com.surelution.tour.TankFarm.list() }" value="${params.'tankFarm.id' }"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="splitted"><g:message code="gasUnloading.splitted.label" default="Splitted" /></label>
                                </td>
                                <td colspan="2" valign="top" class="value">
                                	<g:select id="splitted" name="splitted" from="${['全部','分罐','不分罐'] }" keys="${['',1,0] }" id="splitted" value="${params.splitted }"/>
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="trunckNo"><g:message code="deliveryScore.trunckNo.label" default="Trunck No" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="trunckNo" value="${params.trunckNo}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="driverName"><g:message code="deliveryScore.driverName.label" default="Driver Name" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="driverName" value="${params.driverName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="supercargoName"><g:message code="deliveryScore.supercargoName.label" default="Supercargo Name" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="supercargoName" value="${params.supercargoName}" />
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
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="search" class="search" value="${message(code: 'default.button.search.label', default: 'Search')}" /></span>
                </div>
            </g:form>
            
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <th>${message(code: 'gasUnloading.id.label', default: 'Id')}</th>
                        
                            <th><g:message code="department.label" default="Department" /></th>
                        
                            <th><g:message code="gasTank.label" default="Gas Tank" /></th>
                        
                            <th>${message(code: 'gasType.title.label', default: 'Title')}</th>

                            <th>${message(code: 'gasUnloading.amount.label', default: 'Amount')}</th>
                        
                            <th>${message(code: 'gasUnloading.planningAmount.label', default: 'Planning Amount')}</th>
                        
                            <th>综合差量</th>
                        
                            <th>卸油损耗率(‰)</th>
                        
                            <th>${message(code: 'deliveryScore.driverName.label', default: 'Driver Name')}</th>
                        
                            <th>${message(code: 'deliveryScore.supercargoName.label', default: 'Supercargo Name')}</th>
                        
                            <th>${message(code: 'deliveryScore.trunckNo.label', default: 'Trunck No')}</th>
                        
                            <th>${message(code: 'gasUnloading.tankFarm.label', default: 'Tank Farm')}</th>
                        
                            <th>${message(code: 'gasUnloading.unloadingTime.label', default: 'Unloading Time')}</th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${unloadings?.sort{(-it.planningAmount+it.amount)/it.planningAmount}}" status="i" var="gasUnloadingInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link controller="gasUnloading" action="show" id="${gasUnloadingInstance.id}" target="_blank">${fieldValue(bean: gasUnloadingInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: gasUnloadingInstance, field: "department.name")}</td>
                        
                            <td>
                            	${gasUnloadingInstance.splitted?"分卸：":"" }
                            	<g:each in="${gasUnloadingInstance.items}" var="item">
                            		${item.tank.tankNo }&nbsp;
                            	</g:each>
                            </td>
                            <td>${gasUnloadingInstance.gasType.title}</td>
                        
                        <%
							def amount = gasUnloadingInstance.amount
							def planningAmount = gasUnloadingInstance.planningAmount
							def ratio = planningAmount?(formatNumber(number:((planningAmount-amount)*1000)/planningAmount,maxFractionDigits:1)):"不可用"
						 %>
                            <td>${amount}</td>
                        
                            <td>${planningAmount}</td>
                        
                            <td><g:formatNumber number="${planningAmount - amount}"/></td>
                        
                            <td>${ratio}</td>
                        
                            <td>${gasUnloadingInstance.score.driverName}</td>
                        
                            <td>${gasUnloadingInstance.score.supercargoName}</td>
                        
                            <td>${gasUnloadingInstance.score.trunckNo}</td>
                        
                            <td>${gasUnloadingInstance.tankFarm.name}</td>
                        
                            <td><g:formatDate date="${gasUnloadingInstance.unloadingTime}" format="yy-MM-dd HH:mm"/></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
