
<%@ page import="com.surelution.tour.PatrolLogTopic" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'patrolLogTopic.label', default: 'PatrolLogTopic')}" />
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
                            <td valign="top" class="name"><g:message code="patrolLogTopic.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: patrolLogTopicInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrolLogTopic.index.label" default="Index" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: patrolLogTopicInstance, field: "index")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrolLogTopic.shortTitle.label" default="shortTitle" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: patrolLogTopicInstance, field: "shortTitle")}</td>
                            
                        </tr>              
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="patrolLogTopic.title.label" default="Title" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: patrolLogTopicInstance, field: "title")}</td>
                            
                        </tr>
      
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${patrolLogTopicInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
