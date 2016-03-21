

<%@page import="com.surelution.tour.PageEntry"%>
<%@ page import="com.surelution.tour.User;com.surelution.tour.Department" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${userInstance}">
            <div class="errors">
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${userInstance?.id}" />
                <g:hiddenField name="version" value="${userInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="username"><g:message code="user.username.label" default="Username" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'username', 'errors')}">
                                    <g:textField name="username" value="${userInstance?.username}" />
                                </td>
                            </tr><g:hiddenField name="password" value="${userInstance?.password}" />
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="accountExpired"><g:message code="user.accountExpired.label" default="Account Expired" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'accountExpired', 'errors')}">
                                    <g:checkBox name="accountExpired" value="${userInstance?.accountExpired}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="accountLocked"><g:message code="user.accountLocked.label" default="Account Locked" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'accountLocked', 'errors')}">
                                    <g:checkBox name="accountLocked" value="${userInstance?.accountLocked}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="enabled"><g:message code="user.enabled.label" default="Enabled" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'enabled', 'errors')}">
                                    <g:checkBox name="enabled" value="${userInstance?.enabled}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="passwordExpired"><g:message code="user.passwordExpired.label" default="Password Expired" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'passwordExpired', 'errors')}">
                                    <g:checkBox name="passwordExpired" value="${userInstance?.passwordExpired}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="patrolType.id"><g:message code="user.patrolType.label" default="patrolType" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'patrolType', 'errors')}">
                                <g:select from="${com.surelution.tour.PatrolType.list()}" id="patrolType.id" name="patrolType.id" optionKey="id" optionValue="title" value="${userInstance?.patrolType?.id}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label><g:message code="user.userDepartment.label" default="站权限" /></label>
                                </td>
                                <g:set var="dids" value="${userDepartments.collect{it.department.id} }"/>
                                <td valign="top" class="value">
                                	<g:each in="${Department.list() }" var="d">
                                		<label for="ud_${d.id }">${d.name }</label><g:checkBox id="ud_${d.id }" name="userDepartment" value="${d.id }" checked="${dids.contains(d.id) }"/>&nbsp;
                                	</g:each>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label><g:message code="user.userPageEntry.label" default="功能权限" /></label>
                                </td>
                                <g:set var="pids" value="${userPageEntries.collect{it.entry.id} }"/>
                                <td valign="top" class="value">
                                	<table style="border: 0">
                                		<g:each in="${PageEntry.findAllByIsLeaf(false) }" var="cat">
                                			<tr>
                                				<td style="background-color: gray">${cat.label }</td>
                                				<td>
                                					<g:each in="${cat.children }" var="p">
                                						<label for="up_${p.id }">${p.label }</label><g:checkBox id="up_${p.id }" name="userPageEntry" value="${p.id }" checked="${pids.contains(p.id) }"/><br/>
                                					</g:each>
                                				</td>
                                			</tr>
                                		</g:each>
                                	</table>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
