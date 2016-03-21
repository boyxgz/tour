
<%@ page import="com.surelution.tour.PatrolLog" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrolLog.label', default: 'PatrolLog')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
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
                            <td valign="top" class="name"><g:message code="patrolLog.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: patrolLogInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrolLog.patrol.label" default="Patrol" /></td>
                            
                            <td valign="top" class="value">
                            	巡检人：${patrolLogInstance?.patrol?.user.username}<br>
                            	巡检部门：${patrolLogInstance?.patrol?.department.name}<br>
                            	明细：
                            	<g:each in="${patrolLogInstance?.patrol?.items}" var="item">
                            		${item.poi.name }（${item.patrolTime.format("yyyy年MM月dd日 HH点mm分") }）<br>
                            	</g:each>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrolLog.logTime.label" default="Log Time" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${patrolLogInstance?.logTime}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrolLog.remark.label" default="Remark" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: patrolLogInstance, field: "remark")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrolLog.remarked.label" default="Remark" /></td>
                            
                            <td valign="top" class="value">
                            	<g:each in="${patrolLogInstance.items}" var="item">
                            		${item.topic.title}:${item.answerChar }，备注：${item.description }<br>
                            	</g:each>
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>

        </div>
    </body>
</html>
