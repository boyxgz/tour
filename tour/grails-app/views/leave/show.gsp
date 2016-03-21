
<%@ page import="com.surelution.tour.Leave" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'leave.label', default: 'Leave')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span><%--
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        --%></div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="leave.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: leaveInstance, field: "id")}</td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="leave.user.label" default="User" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: leaveInstance, field: "user")}</td>
                            
                        </tr>
                                            
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="leave.type.label" default="Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: leaveInstance, field: "type.name")}</td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="leave.from.label" default="From" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${leaveInstance?.from}" format="yyyy年MM月dd日"/></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="leave.to.label" default="To" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${leaveInstance?.to}" format="yyyy年MM月dd日 "/></td>
                            
                        </tr>                        
                   
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="leave.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: leaveInstance, field: "description")}</td>
                            
                        </tr>
                  
                    </tbody>
                </table>
            </div>
            
        <sec:ifAnyGranted roles="ROLE-ADMIN">
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${leaveInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
		</sec:ifAnyGranted>

        </div>
    </body>
</html>
