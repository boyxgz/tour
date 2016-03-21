

<%@ page import="com.surelution.tour.GasGunChecking" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:javascript library="jquery"/>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasGunChecking.label', default: 'GasGunChecking')}" />
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
            <g:hasErrors bean="${gasGunCheckingInstance}">
            <div class="errors">
                <g:renderErrors bean="${gasGunCheckingInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="gasGunChecking.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasGunCheckingInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${gasGunCheckingInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="differAmount"><g:message code="gasGunChecking.differAmount.label" default="Differ Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasGunCheckingInstance, field: 'differAmount', 'errors')}">
                                    <g:textField name="differAmount" value="${fieldValue(bean: gasGunCheckingInstance, field: 'differAmount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="gun"><g:message code="gasGunChecking.gun.label" default="Gun" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasGunCheckingInstance, field: 'gun', 'errors')}">
                                	<g:select name="department.id" from="${com.surelution.tour.Department.list()}" noSelection="${['':''] }" optionKey="id" optionValue="name" onchange="loadGun()"/>
                                    <g:select name="gun.id" noSelection="${['':''] }" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="volume"><g:message code="gasGunChecking.volume.label" default="Volume" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasGunCheckingInstance, field: 'volume', 'errors')}">
                                    <g:textField name="volume" value="${fieldValue(bean: gasGunCheckingInstance, field: 'volume')}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
