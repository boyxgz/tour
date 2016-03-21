
<%@ page import="com.surelution.tour.WandDropping" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'wandDropping.label', default: 'WandDropping')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <resource:dateChooser/>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            
            <g:form method="post" action="list">
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="date"><g:message code="wandDropping.date.label" default="Date" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <richui:dateChooser name="from" format="yyyy-MM-dd" value="${params.from}"  />
                                    -
                                    <richui:dateChooser name="to" format="yyyy-MM-dd" value="${params.to}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="user"><g:message code="wandDropping.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <g:select name="user.id" from="${com.surelution.tour.User.list()}" optionKey="id" value="${user?.id}" noSelection="['':'']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="wandSn"><g:message code="wandDropping.wandSn.label" default="Wand Sn" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="wandSn" value="${params.wandSn}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="list" value="查询" /></span>
                </div>
            </g:form>
            
            <br>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'wandDropping.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="date" title="${message(code: 'wandDropping.droppingDate.label', default: 'Date')}" />
                        
                            <th><g:message code="wandDropping.user.label" default="User" /></th>
                        
                            <g:sortableColumn property="wandSn" title="${message(code: 'wandDropping.wandSn.label', default: 'Wand Sn')}" />
                        
                            <!--<g:sortableColumn property="remoteId" title="${message(code: 'wandDropping.remoteId.label', default: 'Remote Id')}" />-->
                        
                            <g:sortableColumn property="reportDate" title="${message(code: 'wandDropping.reportDate.label', default: 'Report Date')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${wandDroppingInstanceList}" status="i" var="wandDroppingInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td>${fieldValue(bean: wandDroppingInstance, field: "id")}</td>
                        
                            <td><g:formatDate date="${wandDroppingInstance.date}" format="yyyy年MM月dd日 HH时mm分"  /></td>
                        
                            <td>${fieldValue(bean: wandDroppingInstance, field: "user")}</td>
                        
                            <td>${fieldValue(bean: wandDroppingInstance, field: "wandSn")}</td>
                        
                            <!-- ${fieldValue(bean: wandDroppingInstance, field: "remoteId")} -->
                        
                            <td><g:formatDate date="${wandDroppingInstance.reportDate}" format="yyyy年MM月dd日 HH时mm分" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${wandDroppingInstanceTotal}" params="${params }" />
            </div>
        </div>
    </body>
</html>
