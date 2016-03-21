

<%@ page import="com.surelution.tour.PatrolLog" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrolLog.label', default: 'PatrolLog')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <script type="text/javascript">
        	var topics = new Array();
        	<g:each in="${patrolLogTopics}" var="topic">
        		topics.push(${topic.id});
        	</g:each>
        	var msg = "当巡检内容为未检查或不正常时，必须填写备注信息，请确认！";
			function validateForm() {
				var f = document.forms[0]
				for(var i=0; i < topics.length; i++) {
					//var notOpt = f["topic_" + topics[i]][0].checked || 
					//	(!(f["topic_" + topics[i]][1].checked) && !(f["topic_" + topics[i]][2].checked));
					var needMark = !(f["topic_" + topics[i]][1].checked);
					var tfield = f["topic_" + topics[i] + "_remark"].value;
					if(needMark && tfield == "") {
						alert(msg);
						return false;
					}
				}
				return true;
			}

			function addStockTaking() {
				document.location.href="${createLink(controller:'stockTaking', action:'create', params:['patrol.id':patrolLogInstance?.patrol?.id])}";
			}
        </script>
        
    </head>
     
    
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" />或者<input type="button" value="添加盘点" onclick="addStockTaking()"></h1>
            <p style="font-size:13px;color:#d5442f;font-weight:bold;">提示：需填写所有巡检明细情况，否则无法提交；若选择了“未检查”或“不正常”，则必须写明备注内容！</p>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${patrolLogInstance}">
            <div class="errors">
                <g:renderErrors bean="${patrolLogInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form id="mainForm" action="save" onsubmit="return validateForm();">

		    <div class="content">
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <g:hiddenField name="patrol.id" value="${patrolLogInstance?.patrol?.id}"/>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="remark"><g:message code="patrolLog.remarked.label" default="Remark" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <table>
                                    	<g:each in="${patrolLogTopics}" var="topic">
                                    		<tr>
                                    			<td style="text-align:right;"><label for="topic_${topic.id }_1" title="${topic.title}">${topic.shortTitle}</label></td>
                                    			<td style='width:450px;'>
                                    				未检查：<input type="radio" id="topic_${topic.id }_1" name="topic_${topic.id }" value="1"/>&nbsp;&nbsp; &nbsp; &nbsp;
                                    				正常：<input type="radio" id="topic_${topic.id }_2" name="topic_${topic.id }" checked="checked" value="2"/>&nbsp;&nbsp;&nbsp; &nbsp;
                                    				不正常：<input type="radio" id="topic_${topic.id }_3" name="topic_${topic.id }" value="3"/>&nbsp;&nbsp;&nbsp; &nbsp;
                                    				备注：<input type="text" name="topic_${topic.id}_remark"/>
                                    			</td>
                                    		</tr>
                                    	</g:each>
                                    </table>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="remark"><g:message code="patrolLog.remark.label" default="Remark" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: patrolLogInstance, field: 'remark', 'errors')}" >
                                    <g:textArea name="remark" rows="1" cols="200" value="${patrolLogInstance?.remark}" style="text-align:left;"  />
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.save.label', default: 'Create')}" /></span>
                </div>
           </div>
            </g:form>
        </div>
    </body>
</html>
