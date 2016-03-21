
<%@ page import="com.surelution.tour.GasRecircling" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gasRecircling.label', default: 'GasRecircling')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasRecircling.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: gasRecirclingInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasRecircling.gun.label" default="Gun" /></td>
                            
                            <td valign="top" class="value">${gasRecirclingInstance?.gun?.tank?.department?.name}:${gasRecirclingInstance?.gun?.gunNo}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasRecircling.volume.label" default="Volume" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: gasRecirclingInstance, field: "volume")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasRecircling.differAmount.label" default="Differ Amount" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: gasRecirclingInstance, field: "differAmount")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasRecircling.type.label" default="Type" /></td>
                            
                            <td valign="top" class="value">${gasRecirclingInstance?.type?.title}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasRecircling.inputTime.label" default="Input Time" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${gasRecirclingInstance?.inputTime}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasRecircling.outputTime.label" default="Output Time" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${gasRecirclingInstance?.outputTime}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasRecircling.reportTime.label" default="Report Time" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${gasRecirclingInstance?.reportTime}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasRecircling.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: gasRecirclingInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="gasRecircling.user.label" default="User" /></td>
                            
                            <td valign="top" class="value">${gasRecirclingInstance?.user?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${gasRecirclingInstance?.id}" />
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
