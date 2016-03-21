

<%@ page import="com.surelution.tour.Vt2Vcf" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <r:require module="jquery-ui"/>
        <r:layoutResources/>
        <g:set var="entityName" value="${message(code: 'vt2Vcf.label', default: 'Vt2Vcf')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <script type="text/javascript">
			function loadTanks() {
				var deptId = $("#deptId").val();
				var month = $("#month_year").val() + "-" + $("#month_month").val();
		    	var url = '${createLink(controller:"vt2Vcf", action:"loadTanks")}?department.id=' + deptId + '&month=' + month;
				$( "#ratioEditDiv" ).load(url);
			}
        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${vt2VcfInstance}">
            <div class="errors">
                <g:renderErrors bean="${vt2VcfInstance}" as="list" />
            </div>
            </g:hasErrors>
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="month"><g:message code="vt2Vcf.month.label" default="Month" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vt2VcfInstance, field: 'month', 'errors')}">
                                    <g:datePicker name="month" precision="month" value="${vt2VcfInstance?.month}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department.id"><g:message code="department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vt2VcfInstance, field: 'department', 'errors')}">
                                    <g:select name="deptId" from="${com.surelution.tour.Department.list()}" optionKey="id" optionValue="name" onchange="loadTanks()"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
	                <div id="ratioEditDiv"><!-- for ajax -->
	                </div>
                </div>
        </div>
    </body>
</html>
