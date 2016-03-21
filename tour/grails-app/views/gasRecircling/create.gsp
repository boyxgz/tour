

<%@ page import="com.surelution.tour.GasRecircling" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:javascript library="jquery"/>
        <meta name="layout" content="main" />
        <r:layoutResources/>
        <g:set var="entityName" value="${message(code: 'gasRecircling.label', default: 'GasRecircling')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <script type="text/javascript">
			function loadGun() {
				$('#gun\\.id').find("option").remove();
				$('#gun\\.id').append($("<option></option>"));

				var deptId = $("#department\\.id");
				if(deptId.val() == null) 
					return;
				
				var request = $.ajax({
					url: '${createLink(controller:"gasGun", action:"loadGasGunsByDepartment")}',
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

				$(xml).find("gun").each(function(index, gun){
					var gunNo = $(gun).attr("gunNo");
					var id = $(gun).attr("id");
					$('#gun\\.id')
			         .append($("<option></option>")
			         .attr("value",id)
			         .text(gunNo));
				});
			}

			var map = new Array();
			<g:each in="${com.surelution.tour.GasRecirclingType.list()}" var="type">
				map['${type.id}'] = ${type.recirclingRequired};
			</g:each>
			function changeType() {
				var recType = document.getElementById("type.id").value;
				var reciclingRequired = map[recType];
				document.getElementById("differAmount").disabled = !reciclingRequired;

				document.getElementById("inputTime_day").disabled = !reciclingRequired;
				document.getElementById("inputTime_month").disabled = !reciclingRequired;
				document.getElementById("inputTime_year").disabled = !reciclingRequired;
				document.getElementById("inputTime_hour").disabled = !reciclingRequired;
				document.getElementById("inputTime_minute").disabled = !reciclingRequired;
				
			}
        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="list" action="batchCreate">回罐批量导入</g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${gasRecirclingInstance}">
            <div class="errors">
                <g:renderErrors bean="${gasRecirclingInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="gasRecircling.type.label" default="Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'type', 'errors')}">
                                    <g:select name="type.id" from="${com.surelution.tour.GasRecirclingType.list()}" optionKey="id" optionValue="title" value="${gasRecirclingInstance?.type?.id}" noSelection="${['':''] }" onchange="changeType()" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="gun"><g:message code="gasRecircling.gun.label" default="Gun" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'gun', 'errors')}">
                                	<g:select name="department.id" from="${com.surelution.tour.Department.list()}" noSelection="${['':''] }" optionKey="id" optionValue="name" onchange="loadGun()"/>
                                    <g:select name="gun.id" from="${com.surelution.tour.GasGun.list()}" noSelection="${['':''] }" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="startGunCount"><g:message code="gasRecircling.startGunCount.label" default="Start Gun Count" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'startGunCount', 'errors')}">
                                    <g:textField name="startGunCount" value="${fieldValue(bean: gasRecirclingInstance, field: 'startGunCount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="endGunCount"><g:message code="gasRecircling.endGunCount.label" default="End Gun Count" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'endGunCount', 'errors')}">
                                    <g:textField name="endGunCount" value="${fieldValue(bean: gasRecirclingInstance, field: 'endGunCount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="volume"><g:message code="gasRecircling.volume.label" default="Volume" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'volume', 'errors')}">
                                    <g:textField name="volume" value="${fieldValue(bean: gasRecirclingInstance, field: 'volume')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="differAmount"><g:message code="gasRecircling.differAmount.label" default="Differ Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'differAmount', 'errors')}">
                                    <g:textField name="differAmount" value="${fieldValue(bean: gasRecirclingInstance, field: 'differAmount')}" />
                                    <g:message code="default.perThousandSign.label" default=" " />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="outputTime"><g:message code="gasRecircling.outputTime.label" default="Output Time" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'outputTime', 'errors')}">
                                    <g:datePicker name="outputTime" precision="minute" value="${gasRecirclingInstance?.outputTime}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="inputTime"><g:message code="gasRecircling.inputTime.label" default="Input Time" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'inputTime', 'errors')}">
                                    <g:datePicker name="inputTime" precision="minute" value="${gasRecirclingInstance?.inputTime}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="gasRecircling.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" value="${gasRecirclingInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="involvedPerson"><g:message code="gasRecircling.involvedPerson.label" default="Involved Person" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'involvedPerson', 'errors')}">
                                    <g:textField name="involvedPerson" value="${fieldValue(bean: gasRecirclingInstance, field: 'involvedPerson')}" />
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
