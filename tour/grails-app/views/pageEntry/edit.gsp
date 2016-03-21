

<%@ page import="com.surelution.tour.PageEntry" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pageEntry.label', default: 'PageEntry')}" />
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
            <g:hasErrors bean="${pageEntryInstance}">
            <div class="errors">
                <g:renderErrors bean="${pageEntryInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${pageEntryInstance?.id}" />
                <g:hiddenField name="version" value="${pageEntryInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="controllerName"><g:message code="pageEntry.controllerName.label" default="Controller Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pageEntryInstance, field: 'controllerName', 'errors')}">
                                    <g:textField name="controllerName" value="${pageEntryInstance?.controllerName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="actionName"><g:message code="pageEntry.actionName.label" default="Action Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pageEntryInstance, field: 'actionName', 'errors')}">
                                    <g:textField name="actionName" value="${pageEntryInstance?.actionName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="parent"><g:message code="pageEntry.parent.label" default="Parent" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pageEntryInstance, field: 'parent', 'errors')}">
                                    <g:select name="parent.id" from="${com.surelution.tour.PageEntry.list()}" optionKey="id" optionValue="label" value="${pageEntryInstance?.parent?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="children"><g:message code="pageEntry.children.label" default="Children" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pageEntryInstance, field: 'children', 'errors')}">
                                    
<ul>
<g:each in="${pageEntryInstance?.children?}" var="c">
    <li><g:link controller="pageEntry" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="pageEntry" action="create" params="['pageEntry.id': pageEntryInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'pageEntry.label', default: 'PageEntry')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="isLeaf"><g:message code="pageEntry.isLeaf.label" default="Is Leaf" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pageEntryInstance, field: 'isLeaf', 'errors')}">
                                    <g:checkBox name="isLeaf" value="${pageEntryInstance?.isLeaf}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="label"><g:message code="pageEntry.label.label" default="Label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pageEntryInstance, field: 'label', 'errors')}">
                                    <g:textField name="label" value="${pageEntryInstance?.label}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="positionSeq"><g:message code="pageEntry.positionSeq.label" default="Position Seq" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pageEntryInstance, field: 'positionSeq', 'errors')}">
                                    <g:textField name="positionSeq" value="${fieldValue(bean: pageEntryInstance, field: 'positionSeq')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="showInMenu"><g:message code="pageEntry.showInMenu.label" default="Show In Menu" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pageEntryInstance, field: 'showInMenu', 'errors')}">
                                    <g:checkBox name="showInMenu" value="${pageEntryInstance?.showInMenu}" />
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
