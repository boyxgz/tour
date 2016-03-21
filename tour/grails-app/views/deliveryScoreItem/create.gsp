

<%@ page import="com.surelution.tour.DeliveryScoreItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'deliveryScoreItem.label', default: 'DeliveryScoreItem')}" />
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
            <g:hasErrors bean="${deliveryScoreItemInstance}">
            <div class="errors">
                <g:renderErrors bean="${deliveryScoreItemInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="deliveryScore"><g:message code="deliveryScoreItem.deliveryScore.label" default="Delivery Score" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deliveryScoreItemInstance, field: 'deliveryScore', 'errors')}">
                                    <g:select name="deliveryScore.id" from="${com.surelution.tour.DeliveryScore.list()}" optionKey="id" value="${deliveryScoreItemInstance?.deliveryScore?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="score"><g:message code="deliveryScoreItem.score.label" default="Score" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deliveryScoreItemInstance, field: 'score', 'errors')}">
                                    <g:textField name="score" value="${fieldValue(bean: deliveryScoreItemInstance, field: 'score')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="deliveryScoreItem.type.label" default="Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deliveryScoreItemInstance, field: 'type', 'errors')}">
                                    <g:select name="type.id" from="${com.surelution.tour.DeliveryScoreItemType.list()}" optionKey="id" value="${deliveryScoreItemInstance?.type?.id}"  />
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
