<%@ page import="com.surelution.tour.GasTank" %>
<%@ page import="com.surelution.tour.GasTankLevel" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:javascript library="jquery"/>
        <r:require module="jquery-ui"/>
        <r:layoutResources/>
        <g:set var="entityName" value="${message(code: 'gasTankLevel.label', default: 'GasTankLevel')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <script type="text/javascript">
	        $(function() {
	        	$.datepicker.regional[ "zh_CN" ] = { closeText: "关闭", prevText: "&#x3c;上月", nextText: "下月&#x3e;", currentText: "今天", monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"], monthNamesShort: ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"], dayNames: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"], dayNamesShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"], dayNamesMin: ["日", "一", "二", "三", "四", "五", "六"], weekHeader: "周", dateFormat: "yy-mm-dd", firstDay: 1, isRTL: !1, showMonthAfterYear: !0, yearSuffix: "年" }
		        $.datepicker.setDefaults( $.datepicker.regional[ "zh_CN" ] );
	            $( "#dateFrom" ).datepicker();
	            $( "#dateTo" ).datepicker();
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
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
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
                                	<g:select name="department.id" from="${com.surelution.tour.UserDepartment.getUserDepartments(username)}" noSelection="${['':''] }" optionKey="id" optionValue="name" value="${params['department.id'] }" onchange="loadTank()"/>
                                    <g:select name="tank.id" id="tank.id" from="${tankList}" optionKey="id" optionValue="${{it.tankNo+','+it.gasType.title}}" noSelection='${["":""] }' value="${params['tank.id'] }"/>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    检查时间
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="dateFrom" value="${params.dateFrom }"/>~
                                	<g:textField name="dateTo" value="${params.dateTo }"/>
                                	<span class="button"><g:submitButton name="search" class="search" value="${message(code: 'default.button.search.label', default: 'Search')}" /></span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </g:form>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'gasTankLevel.id.label', default: 'Id')}" />

                            <g:sortableColumn property="tank" title="${message(code: 'gasTankLevel.tank.label', default: 'tank')}" />

                            <g:sortableColumn property="checkTime" title="${message(code: 'gasTankLevel.checkTime.label', default: 'Check Time')}" />
                        
                            <th>${message(code: 'gasTankLevel.diffAmount.label', default: 'diffAmount')}</th>
                        
                            <th>${message(code: 'gasTankLevel.diffWaterLevel.label', default: 'diffWaterLevel')}</th>

                            <th>${message(code: 'gasTankLevel.diffTemprature.label', default: 'diffTemprature')}</th>

                            <th>${message(code: 'gasTankLevel.diffDensity.label', default: 'diffDensity')}</th>

                            <g:sortableColumn property="colorState" title="${message(code: 'gasTankLevel.colorState.label', default: 'Color State')}" />
                        
                            <g:sortableColumn property="impurityState" title="${message(code: 'gasTankLevel.impurityState.label', default: 'Impurity State')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${gasTankLevelInstanceList}" status="i" var="gasTankLevelInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${gasTankLevelInstance.id}">${fieldValue(bean: gasTankLevelInstance, field: "id")}</g:link></td>
                        
                            <td>${gasTankLevelInstance.tank.tankNo}(${gasTankLevelInstance.tank.department.name})</td>

                            <td><g:formatDate date="${gasTankLevelInstance.checkTime}" /></td>

                            <td><g:formatNumber number="${gasTankLevelInstance.amout-gasTankLevelInstance.instrumentAmount}" maxFractionDigits="2"/>&nbsp;MM</td>
                        
                            <td><g:formatNumber number="${gasTankLevelInstance.waterLevel-gasTankLevelInstance.instrumentWaterLevel}" maxFractionDigits="2"/>&nbsp;MM</td>

                            <td><g:formatNumber number="${gasTankLevelInstance.temprature-gasTankLevelInstance.instrumentTemprature}" maxFractionDigits="2"/>&nbsp;℃</td>

                            <td><g:formatNumber number="${gasTankLevelInstance.density-gasTankLevelInstance.lastPdnDensity}" maxFractionDigits="2"/>&nbsp;kg/m³</td>

                            <td><g:formatBoolean boolean="${gasTankLevelInstance.colorState}" /></td>
                        
                            <td><g:formatBoolean boolean="${gasTankLevelInstance.impurityState}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${gasTankLevelInstanceTotal}" params="${params }"/>
            </div>
        </div>
    </body>
</html>
