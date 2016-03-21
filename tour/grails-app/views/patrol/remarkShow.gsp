
<%@ page import="com.surelution.tour.Patrol" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrol.label', default: 'Patrol')}" />
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
                            <td valign="top" class="name"><g:message code="patrol.department.label" default="Department" /></td>
                            
                            <td valign="top" class="value"><g:link controller="department" action="show" id="${patrolInstance?.department?.id}">${patrolInstance?.department?.name}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrol.items.label" default="Items" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${patrolInstance.items}" var="i">
                                    <li>${i?.poi.name}&nbsp;<g:formatDate date="${i?.patrolTime }" /></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrol.reportDate.label" default="Report Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${patrolInstance?.reportDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrol.status.label" default="Status" /></td>
                            
                            <td valign="top" class="value">${patrolInstance?.status?.title}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="patrolId" value="${patrolInstance?.id}" />
                    
                    
	                <div class="dialog">
	                    <table>
	                        <tbody>
	                        
	                            <tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="videoStatus"><g:message code="patrolRemark.videoStatus.label" default="Video Status" /></label>
	                                </td>
	                                <td valign="top" class="value ${hasErrors(bean: patrolRemarkInstance, field: 'videoStatus', 'errors')}">
	                                    <g:radioGroup name="videoStatus" values="[true,false]" labels="['是','否']" value="true" >
											<p><g:message code="${it.label}" />: ${it.radio}</p>
										</g:radioGroup>
	                                </td>
	                            </tr>
	                        
	                            <tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="oilStatus"><g:message code="patrolRemark.oilStatus.label" default="Oil Status" /></label>
	                                </td>
	                                <td valign="top" class="value ${hasErrors(bean: patrolRemarkInstance, field: 'videoStatus', 'errors')}">
	                                    <g:radioGroup name="oilStatus" values="[true,false]" labels="['是','否']" value="true" >
											<p><g:message code="${it.label}" />: ${it.radio}</p>
										</g:radioGroup>
	                                </td>
	                            </tr>
	                        
	                            <tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="accountStatus"><g:message code="patrolRemark.accountStatus.label" default="Account Status" /></label>
	                                </td>
	                                <td valign="top" class="value ${hasErrors(bean: patrolRemarkInstance, field: 'accountStatus', 'errors')}">
	                                    <g:radioGroup name="accountStatus" values="[true,false]" labels="['是','否']" value="true" >
											<p><g:message code="${it.label}" />: ${it.radio}</p>
										</g:radioGroup>
	                                </td>
	                            </tr>
	                        
	                        </tbody>
	                    </table>
	                </div>
	                <span class="button">
                		<g:if test="${patrolInstance?.status?.code=='NEW'}"><g:actionSubmit class="edit" action="remark" value="备注" /></g:if>
                	</span>
                
                    
                </g:form>
            </div>
        </div>
    </body>
</html>
