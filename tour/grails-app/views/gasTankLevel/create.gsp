

<%@ page import="com.surelution.tour.GasTankLevel" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:javascript library="jquery"/>
        <meta name="layout" content="main" />
        <r:layoutResources/>
        <g:set var="entityName" value="${message(code: 'gasTankLevel.label', default: 'GasTankLevel')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <script type="text/javascript">
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
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${gasTankLevelInstance}">
            <div class="errors">
                <g:renderErrors bean="${gasTankLevelInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tank"><g:message code="gasTankLevel.tank.label" default="Tank" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'tank', 'errors')}">
                                	<g:set var="username" value="${sec.loggedInUserInfo(field:'username').toString()}"/>
                                	<g:select name="department.id" from="${com.surelution.tour.UserDepartment.getUserDepartments(username)}" noSelection="${['':''] }" optionKey="id" optionValue="name" onchange="loadTank()"/>
                                    <g:select name="tank.id" from="" id="tank.id"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="instrumentAmount"><g:message code="gasTankLevel.instrumentAmount.label" default="Instrument Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'instrumentAmount', 'errors')}">
                                    <g:textField name="instrumentAmount" value="${fieldValue(bean: gasTankLevelInstance, field: 'instrumentAmount')}" />&nbsp;MM
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <label for="amout"><g:message code="gasTankLevel.amout.label" default="Amout" /></label>
                                    <g:textField name="amout" value="${fieldValue(bean: gasTankLevelInstance, field: 'amout')}" />&nbsp;MM
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="instrumentTemprature"><g:message code="gasTankLevel.instrumentTemprature.label" default="Instrument Temprature" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'instrumentTemprature', 'errors')}">
                                    <g:textField name="instrumentTemprature" value="${fieldValue(bean: gasTankLevelInstance, field: 'instrumentTemprature')}" />&nbsp;℃
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <label for="temprature"><g:message code="gasTankLevel.temprature.label" default="Temprature" /></label>
                                    <g:textField name="temprature" value="${fieldValue(bean: gasTankLevelInstance, field: 'temprature')}" />&nbsp;℃
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="instrumentWaterLevel"><g:message code="gasTankLevel.instrumentWaterLevel.label" default="Instrument Water Level" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'instrumentWaterLevel', 'errors')}">
                                    <g:textField name="instrumentWaterLevel" value="${fieldValue(bean: gasTankLevelInstance, field: 'instrumentWaterLevel')}" />&nbsp;MM
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <label for="waterLevel"><g:message code="gasTankLevel.waterLevel.label" default="Water Level" /></label>
                                    <g:textField name="waterLevel" value="${fieldValue(bean: gasTankLevelInstance, field: 'waterLevel')}" />&nbsp;MM
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="density"><g:message code="gasTankLevel.density.label" default="density" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'density', 'errors')}">
                                    <g:textField name="density" value="${fieldValue(bean: gasTankLevelInstance, field: 'density')}" size="18"/>&nbsp;kg/m³
                                    &nbsp;&nbsp;
                                    <label for="lastPdnDensity"><g:message code="gasTankLevel.lastPdnDensity.label" default="lastPdnDensity" /></label>
                                    <g:textField name="lastPdnDensity" value="${fieldValue(bean: gasTankLevelInstance, field: 'lastPdnDensity')}" size="8" />&nbsp;kg/m³
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="impurityState"><g:message code="gasTankLevel.impurityState.label" default="Impurity State" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'impurityState', 'errors')}">
                                    <g:checkBox name="impurityState" value="${gasTankLevelInstance?.impurityState}" />
                                    <g:textField name="impurityInfo" value="${gasTankLevelInstance?.impurityInfo}" />(打勾代表有杂质)
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="colorState"><g:message code="gasTankLevel.colorState.label" default="Color State" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'colorState', 'errors')}">
                                    <g:checkBox name="colorState" value="${gasTankLevelInstance?.colorState}" />
                                    <g:textField name="colorInfo" value="${gasTankLevelInstance?.colorInfo}" />(打勾代表有异常)
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="checkTime"><g:message code="gasTankLevel.checkTime.label" default="Check Time" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasTankLevelInstance, field: 'checkTime', 'errors')}">
                                    <g:datePicker name="checkTime" precision="minute" value="${gasTankLevelInstance?.checkTime}"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.save.label', default: 'Create')}" onclick="return confirm('${message(code: 'default.button.save.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
