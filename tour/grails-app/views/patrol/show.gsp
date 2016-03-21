
<%@ page import="com.surelution.tour.Patrol" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrol.label', default: 'Patrol')}" /> 
        <g:javascript library="jquery" />
        <r:require module="jquery-ui"/>
        <r:layoutResources/>
        <g:set value="${false }" var="needAudit"/>
        <sec:ifAnyGranted roles="ROLE-ADMIN">
	        <g:if test="${patrolLog != null }">
	        	<g:set value="true" var="needAudit"/>
	        </g:if>
        </sec:ifAnyGranted>
        <g:if test="${needAudit }">
	        <script type="text/javascript">
	        $(function() {
	    		$( "#divLogAudit" ).dialog({autoOpen:false, modal:true, height:350, width:600});
	    	});
	        </script>
        </g:if>
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.printElement.min.js')}"></script>
        <script type="text/javascript">
			function addStockTaking() {
				document.location.href="${createLink(controller:'stockTaking', action:'create', params:['patrol.id':patrolInstance.id])}";
			}
        </script>
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${needAudit }">
            <input type="button" onclick="showDialog()" value="管理人员复核意见"/>
	            <div id="divLogAudit" title="请填写管理人员复查意见！">
	            	
	            	
		            <g:form action="patrolLogAudit" controller="patrol">
		                <div class="dialog">
		                    <table>
		                        <tbody>
		                        
		                            <tr class="prop">
		                                <td valign="top" class="name">
		                                    <label for="auditTime"><g:message code="patrolLogAudit.auditTime.label" default="Audit Time" /></label>
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: patrolLogAuditInstance, field: 'auditTime', 'errors')}">
		                                    <g:datePicker name="auditTime" precision="day" value="${patrolLogAuditInstance?.auditTime}"  />
		                                </td>
		                            </tr>
		                        
		                            <tr class="prop">
		                                <td valign="top" class="name">
		                                    <label for="correct"><g:message code="patrolLogAudit.correct.label" default="Correct" /></label>
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: patrolLogAuditInstance, field: 'correct', 'errors')}">
		                                    <g:checkBox name="correct" value="${patrolLogAuditInstance?.correct}" />
		                                </td>
		                            </tr>
		                        
		                            <tr class="prop">
		                                <td valign="top" class="name">
		                                    <label for="descript"><g:message code="patrolLogAudit.descript.label" default="Descript" /></label>
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: patrolLogAuditInstance, field: 'descript', 'errors')}">
		                                    <g:textArea name="descript" value="${patrolLogAuditInstance?.descript}" />
		                                    <g:hiddenField name="patrolLog.id" value="${patrolLog?.id}"  />
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
            </g:if>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <input type="button" value="打印报表" id="simplePrint" />或者<input type="button" value="添加盘点" onclick="addStockTaking()">
            <div id="areaToPrint" class="dialog" style="overflow: scroll;height: 640px">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrol.user.label" default="Clock" /></td>
                            
                            <td valign="top" class="value">${patrolInstance?.user?.username}</td>
                            
                        </tr>
                    	<g:if test="${patrolInstance?.clock}">
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="patrol.clock.label" default="Clock" /></td>
	                            
	                            <td valign="top" class="value"><g:link controller="patrolClock" action="show" id="${patrolInstance?.clock?.id}">${patrolInstance?.clock?.encodeAsHTML()}</g:link></td>
	                            
	                        </tr>
                        </g:if>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrol.department.label" default="Department" /></td>
                            
                            <td valign="top" class="value">${patrolInstance?.department?.name}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrol.items.label" default="Items" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${patrolInstance.items}" var="i">
                                    <li>${i?.poi?.name}@${i?.patrolTime.format("yyyy年MM月dd日HH时mm分") }</li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrol.patrolDate.label" default="Patrol Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${patrolInstance?.patrolDate}" /></td>
                            
                        </tr>
                    
                   
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrol.reportDate.label" default="Report Date" /></td>
                            
                            <td valign="top" class="value">
                            	<g:formatDate date="${patrolInstance?.reportDate}" />
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrolLog.remark.label" default="Remark" /></td>

                            <td valign="top" class="value">${fieldValue(bean: patrolLog, field: "remark")}</td>
                            
                        </tr>
                        <g:if test="${patrolLog?.items}">
	                        <g:each in="${patrolLog.items}" var="item">
		                        <tr class="prop">
		                            <td valign="top" class="name">
		                            	<label title="${item.topic.title}">${item.topic.shortTitle}</label>
		                            </td>
		                            
		                            <td valign="top" class="value">
		                            	${item.answerChar }
		                            	|备注：${item.description }
		                            </td>
		                            
		                        </tr>
	                        </g:each>
                        </g:if>
                        
                        <g:if test="${patrolLogAudits}">
	                        <g:each in="${patrolLogAudits }" var="patrolLogAudit">
	                    
		                        <tr class="prop">
		                            <td valign="top" class="name"><g:message code="patrolLogAudit.user.label" default="User" /></td>
		                            
		                            <td valign="top" class="value">${patrolLogAudit?.user?.username}</td>
		                            
		                        </tr>
		                        
		                        
		                        <tr class="prop">
		                            <td valign="top" class="name"><g:message code="patrolLogAudit.auditTime.label" default="Audit Time" /></td>
		                            
		                            <td valign="top" class="value"><g:formatDate date="${patrolLogAudit?.auditTime}" format="yyyy年MM月dd日"/></td>
		                            
		                        </tr>
		                    
		                        <tr class="prop">
		                            <td valign="top" class="name"><g:message code="patrolLogAudit.correct.label" default="Correct" /></td>
		                            
		                            <td valign="top" class="value"><g:formatBoolean boolean="${patrolLogAudit?.correct}" /></td>
		                            
		                        </tr>
		                    
		                        <tr class="prop">
		                            <td valign="top" class="name"><g:message code="patrolLogAudit.descript.label" default="Descript" /></td>
		                            
		                            <td valign="top" class="value">${fieldValue(bean: patrolLogAudit, field: "descript")}</td>
		                            
		                        </tr>
			                </g:each>
                    	</g:if>
                    </tbody>
                </table>
                
            </div>
        </div>
        
	<script type="text/javascript">
		$(document).ready(function() {
			   $("#simplePrint").click(function() { 
			       printElem({leaveOpen: true, printMode: 'popup'});
			   });
		});
		function printElem(options){
		    $('#areaToPrint').printElement(options);
		}

    </script>
    </body>
</html>
