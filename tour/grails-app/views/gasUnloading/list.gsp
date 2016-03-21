
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
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    卸油结束时间
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'gasUnloading.id.label', default: 'Id')}" />
                        
                            <th><g:message code="department.label" default="Department" /></th>
                        
                            <th><g:message code="gasTank.label" default="Gas Tank" /></th>

                            <g:sortableColumn property="amount" title="${message(code: 'gasUnloading.amount.label', default: 'Amount')}" />
                        
                            <g:sortableColumn property="formNo" title="${message(code: 'gasUnloading.formNo.label', default: 'Form No')}" />
                        
                            <g:sortableColumn property="planningAmount" title="${message(code: 'gasUnloading.planningAmount.label', default: 'Planning Amount')}" />
                        
                            <g:sortableColumn property="unloadingTime" title="${message(code: 'gasUnloading.unloadingTime.label', default: 'Unloading Time')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${gasUnloadingInstanceList}" status="i" var="gasUnloadingInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${gasUnloadingInstance.id}">${fieldValue(bean: gasUnloadingInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: gasUnloadingInstance, field: "department.name")}</td>
                        
                            <td>
                            	${gasUnloadingInstance.splitted?"分卸：":"" }
                            	<g:each in="${gasUnloadingInstance.items}" var="item">
                            		${item.tank.tankNo }&nbsp;
                            	</g:each>
                            </td>
                        
                            <td>${fieldValue(bean: gasUnloadingInstance, field: "amount")}</td>
                        
                            <td>${fieldValue(bean: gasUnloadingInstance, field: "formNo")}</td>
                        
                            <td>${fieldValue(bean: gasUnloadingInstance, field: "planningAmount")}</td>
                        
                            <td><g:formatDate date="${gasUnloadingInstance.unloadingTime}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${gasUnloadingInstanceTotal}" params="${params }"/>
            </div>
        </div>
    </body>
</html>
