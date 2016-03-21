

<%@ page import="com.surelution.tour.Vt2Vcf" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'vt2Vcf.label', default: 'Vt2Vcf')}" />
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
            <g:hasErrors bean="${vt2VcfInstance}">
            <div class="errors">
                <g:renderErrors bean="${vt2VcfInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${vt2VcfInstance?.id}" />
                <g:hiddenField name="version" value="${vt2VcfInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="month"><g:message code="vt2Vcf.month.label" default="Month" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vt2VcfInstance, field: 'month', 'errors')}">
                                    <g:datePicker name="month" precision="month" value="${vt2VcfInstance?.month}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="ratio"><g:message code="vt2Vcf.ratio.label" default="Ratio" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vt2VcfInstance, field: 'ratio', 'errors')}">
                                    <g:textField name="ratio" value="${vt2VcfInstance.ratio}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tank"><g:message code="vt2Vcf.tank.label" default="Tank" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vt2VcfInstance, field: 'tank', 'errors')}">
                                    <g:select name="tank.id" from="${com.surelution.tour.GasTank.list()}" optionKey="id" optionValue='${{it.department.name + "-" + it.tankNo + "(" + it.gasType.title + ")"} }' value="${vt2VcfInstance?.tank?.id}"  />
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
