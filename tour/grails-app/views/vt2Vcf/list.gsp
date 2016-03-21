
<%@ page import="com.surelution.tour.Vt2Vcf" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'vt2Vcf.label', default: 'Vt2Vcf')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'vt2Vcf.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="month" title="${message(code: 'vt2Vcf.month.label', default: 'Month')}" />
                        
                            <g:sortableColumn property="ratio" title="${message(code: 'vt2Vcf.ratio.label', default: 'Ratio')}" />
                        
                            <th><g:message code="vt2Vcf.tank.label" default="Tank" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${vt2VcfInstanceList}" status="i" var="vt2VcfInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${vt2VcfInstance.id}">${fieldValue(bean: vt2VcfInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate date="${vt2VcfInstance.month}" format="yyyy-MM"/></td>
                        
                            <td>${vt2VcfInstance.ratio}</td>
                        
                            <td>${vt2VcfInstance.tank.department.name}-${vt2VcfInstance.tank.tankNo}(${vt2VcfInstance.tank.gasType.title})</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${vt2VcfInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
