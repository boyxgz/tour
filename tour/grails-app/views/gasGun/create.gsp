

<%@ page import="com.surelution.tour.GasGun" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasGun.label', default: 'GasGun')}" />
        <g:javascript library="jquery"/>
        
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
        
        <title><g:message code="default.create.label" args="[entityName]" /></title>
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
            <g:hasErrors bean="${gasGunInstance}">
            <div class="errors">
                <g:renderErrors bean="${gasGunInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="gunNo"><g:message code="gasGun.gunNo.label" default="Gun No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasGunInstance, field: 'gunNo', 'errors')}">
                                    <g:textField name="gunNo" value="${gasGunInstance?.gunNo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tank"><g:message code="gasTank.label" default="Tank" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasGunInstance, field: 'tank', 'errors')}">
                                	<g:select name="department.id" from="${com.surelution.tour.Department.list()}" noSelection="${['':''] }" optionKey="id" optionValue="name" onchange="loadTank()"/>
                                    <g:select name="tank.id"/>
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
