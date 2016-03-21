

<%@ page import="com.surelution.tour.GasRecircling" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:javascript library="jquery"/>
        <r:layoutResources/>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasRecircling.label', default: 'GasRecircling')}" />
        <title>回罐批量导入</title>
        <script type="text/javascript">
        	function loadGuns() {
				var deptId = $("#deptId").val()
				if(deptId) {
					var url = "${createLink(action:'batchCreateGunTable')}?deptId=" + deptId;
					$("#gunTable").load(url);

				}
            }
        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create">新增单条回罐油记录</g:link></span>
        </div>
        <div class="body">
            <h1>回罐批量导入</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form action="batchSave" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="gun"><g:message code="department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'gun', 'errors')}">
                                	<g:set var="username" value="${sec.loggedInUserInfo(field:'username').toString()}"/>
                                	<g:select name="deptId" from="${com.surelution.tour.UserDepartment.getUserDepartments(username)}" noSelection="${['':''] }" optionKey="id" optionValue="name" onchange="loadGuns()"/>
                                </td>
                            </tr>
                        
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
                                    <label for="inputTime"><g:message code="gasRecircling.inputTime.label" default="Input Time" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: gasRecirclingInstance, field: 'inputTime', 'errors')}">
                                    <g:datePicker name="inputTime" precision="minute" value="${gasRecirclingInstance?.inputTime}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                
	            <div class="list" id="gunTable" style="overflow:scroll;height:500px">
	            </div>
            </g:form>
        </div>
    </body>
</html>
