
<%@ page import="com.surelution.tour.PageEntry" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pageEntry.label', default: 'PageEntry')}" />
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
                            <td valign="top" class="name"><g:message code="pageEntry.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: pageEntryInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pageEntry.controllerName.label" default="Controller Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: pageEntryInstance, field: "controllerName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pageEntry.actionName.label" default="Action Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: pageEntryInstance, field: "actionName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pageEntry.parent.label" default="Parent" /></td>
                            
                            <td valign="top" class="value"><g:link controller="pageEntry" action="show" id="${pageEntryInstance?.parent?.id}">${pageEntryInstance?.parent?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pageEntry.children.label" default="Children" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${pageEntryInstance.children}" var="c">
                                    <li><g:link controller="pageEntry" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pageEntry.isLeaf.label" default="Is Leaf" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${pageEntryInstance?.isLeaf}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pageEntry.label.label" default="Label" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: pageEntryInstance, field: "label")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pageEntry.positionSeq.label" default="Position Seq" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: pageEntryInstance, field: "positionSeq")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="pageEntry.showInMenu.label" default="Show In Menu" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${pageEntryInstance?.showInMenu}" /></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${pageEntryInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
