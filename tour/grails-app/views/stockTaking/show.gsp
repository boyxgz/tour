<%@page import="com.surelution.tour.GasGun"%>
<%@page import="com.surelution.tour.GasTank"%>
<%@ page import="com.surelution.tour.StockTaking" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <r:require module="jquery-ui"/>
        <r:layoutResources/>
        <g:set var="entityName" value="${message(code: 'stockTaking.label', default: 'StockTaking')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <script type="text/javascript">
        	var currTakingItemId;
	        $(function() {
	    		$( "#stockTakingItemDiv" ).dialog({autoOpen:false, modal:true, height:350, width:600});
	    	});
	        $(function() {
	    		$( "#tabs" ).tabs();
	    	});

	    	function showDialog(takingItemId, tankNo, tankId) {
		    	var url = '${createLink(controller:"stockTaking", action:"loadTankGunForm")}?takingItemId=' + takingItemId + '&tankId=' + tankId;
	    		$( "#stockTakingItemDiv" ).load(url);
		    	$( "#stockTakingItemDiv" ).dialog({title:tankNo});
	    		$( "#stockTakingItemDiv" ).dialog('open');
		    }

			function keyup_s(e) {
				var key = e.keyCode? e.keyCode : e.charCode;
				var fields = $('#stockTakingItemForm :input');
				var originalTarget = e.originalTarget;
				if(!originalTarget) {
					originalTarget = e.srcElement;
				}
					
				if(key == 40 || key == 13) { //向下箭头
					for(i = 0; i < fields.length; i++) {
						if(fields[i] == originalTarget) {
							fields[i+1].focus();
							return;
						}
					}
					
				} else if(key == 38) { //向上箭头
					for(i = 0; i < fields.length; i++) {
						if(fields[i] == originalTarget) {
							fields[i-1].focus();
							return;
						}
					}
				}
			}
        </script>
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
                            <td valign="top" class="name"><g:message code="stockTaking.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: stockTakingInstance, field: "id")}</td>
                            
                        </tr>
                    
                    <g:if test="${stockTakingInstance.previousTaking}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="stockTaking.previousTaking.label" default="Previous Taking" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${stockTakingInstance.previousTaking.takingTime }" /></td>
                            
                        </tr>
                    </g:if>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="stockTaking.department.label" default="Department" /></td>
                            
                            <td valign="top" class="value">${stockTakingInstance?.department?.name}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="stockTaking.takingTime.label" default="Taking Time" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${stockTakingInstance?.takingTime}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="stockTaking.user.label" default="User" /></td>
                            
                            <td valign="top" class="value">${stockTakingInstance?.user?.username}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${stockTakingInstance?.id}" />
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
            <g:if test="${stockTakingInstance.id}">
	        <div id="tabs">
	        	<ul>
					<li><a href="#tabs-taking">盘点</a></li>
					<li><a href="#tabs-unloading">卸油</a></li>
					<li><a href="#tabs-gunChecking">回罐油</a></li>
					<!-- <li><a href="#tabs-gasTankLevel">液位仪比对信息</a></li> -->
				</ul>
				<div id="tabs-taking">
		            <div class="list">
		                <table>
		                    <thead>
		                        <tr>
		                        
		                            <g:sortableColumn property="id" title="${message(code: 'stockTakingItem.id.label', default: 'Id')}" />
		                        
		                            <th><g:message code="stockTakingItem.tank.label" default="Tank" /></th>
		                        
		                            <g:sortableColumn property="stockAmount" title="${message(code: 'stockTakingItem.previousStockAmount.label', default: 'Previous Stock Amount')}" />
		                        
		                            <g:sortableColumn property="stockAmount" title="${message(code: 'stockTakingItem.stockAmount.label', default: 'Stock Amount')}" />
		                        
		                            <g:sortableColumn property="saleAmount" title="${message(code: 'stockTakingItem.saleAmount.label', default: 'Sale Amount')}" />
		                        
		                        </tr>
		                    </thead>
		                    <tbody>
		                    <g:each in="${stockTakingItemInstanceList}" status="i" var="stockTakingItemInstance">
		                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" ondblclick="showDialog(${stockTakingItemInstance.id},'${stockTakingItemInstance.tank.tankNo}',${stockTakingItemInstance.tank.id})">
		                        
		                            <td>${fieldValue(bean: stockTakingItemInstance, field: "id")}</td>
		                        
		                            <td>${stockTakingItemInstance.tank.tankNo}(${stockTakingItemInstance.tank.gasType.title})</td>

		                            <td>${fieldValue(bean: stockTakingItemInstance, field: "previousStockAmount")}</td>

		                            <td>${fieldValue(bean: stockTakingItemInstance, field: "stockAmount")}</td>
		                        
		                            <td>
			                            <g:each in="${stockTakingItemInstance.gunSales.sort{it.gun.id} }" var="sales">
			                            [${message(code: 'gasGun.gunNo.label', default: 'Gas No.')}${sales.gun.gunNo}:<font color="blue">${sales.salesAmount}</font>]<br/>
			                            </g:each>
		                            </td>
		                        
		                        </tr>
		                    </g:each>
		                    </tbody>
		                </table>
		            </div>
				</div>
				<div id="tabs-unloading">
		            <div class="list">
		                <table>
		                    <thead>
		                        <tr>
		                        
		                            <g:sortableColumn property="id" title="${message(code: 'gasUnloading.id.label', default: 'Id')}" />
		                        
		                            <g:sortableColumn property="amount" title="${message(code: 'gasUnloading.amount.label', default: 'Amount')}" />
		                        
		                            <g:sortableColumn property="formNo" title="${message(code: 'gasUnloading.formNo.label', default: 'Form No')}" />
		                        
		                            <g:sortableColumn property="planningAmount" title="${message(code: 'gasUnloading.planningAmount.label', default: 'Planning Amount')}" />
		                        
		                            <th><g:message code="gasUnloading.tank.label" default="Tank" /></th>
		                        
		                            <g:sortableColumn property="unloadingTime" title="${message(code: 'gasUnloading.unloadingTime.label', default: 'Unloading Time')}" />
		                        
		                        </tr>
		                    </thead>
		                    <tbody>
		                    <g:each in="${gasUnloadings}" status="i" var="gasUnloadingInstance">
		                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		                        
		                            <td>${fieldValue(bean: gasUnloadingInstance, field: "id")}</td>
		                        
		                            <td>${fieldValue(bean: gasUnloadingInstance, field: "amount")}</td>
		                        
		                            <td>${fieldValue(bean: gasUnloadingInstance, field: "formNo")}</td>
		                        
		                            <td>${fieldValue(bean: gasUnloadingInstance, field: "planningAmount")}</td>
		                        
		                            <td>
		                            	${gasUnloadingInstance.splitted?"分卸:":""}
		                            	<g:each in="${gasUnloadingInstance.items}" var="item">
		                            		${item.tank.tankNo }&nbsp;
		                            	</g:each>
		                            </td>
		                        
		                            <td><g:formatDate date="${gasUnloadingInstance.unloadingTime}" /></td>
		                        
		                        </tr>
		                    </g:each>
		                    </tbody>
		                </table>
		            </div>
				</div>
				<div id="tabs-gunChecking">
		            <div class="list">
		                <table>
		                    <thead>
		                        <tr>
		                        
		                            <g:sortableColumn property="id" title="${message(code: 'gasGunChecking.id.label', default: 'Id')}" />
		                        
		                            <th><g:message code="gasGunChecking.gun.label" default="Gun" /></th>
		                        
		                            <g:sortableColumn property="volume" title="${message(code: 'gasGunChecking.volume.label', default: 'Volume')}" />
		                        
		                            <g:sortableColumn property="differAmount" title="${message(code: 'gasGunChecking.differAmount.label', default: 'Differ Amount')}" />
		                        
		                            <g:sortableColumn property="description" title="${message(code: 'gasGunChecking.description.label', default: 'Description')}" />
		                        
		                        </tr>
		                    </thead>
		                    <tbody>
		                    <g:each in="${gasRecirclings}" status="i" var="gasGunCheckingInstance">
		                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		                        
		                            <td>${fieldValue(bean: gasGunCheckingInstance, field: "id")}</td>
		                        
		                            <td>${fieldValue(bean: gasGunCheckingInstance, field: "gun.gunNo")}</td>
		                        
		                            <td>${fieldValue(bean: gasGunCheckingInstance, field: "volume")}</td>
		                        
		                            <td>${fieldValue(bean: gasGunCheckingInstance, field: "differAmount")}</td>
		                        
		                            <td>${fieldValue(bean: gasGunCheckingInstance, field: "description")}</td>
		                        
		                        </tr>
		                    </g:each>
		                    </tbody>
		                </table>
		            </div>
				</div>
				<!-- 
				<div id="tabs-gasTankLevel">
		            <div class="list">
		                <table>
		                    <thead>
		                        <tr>
		                        
		                            <g:sortableColumn property="id" title="${message(code: 'gasTankLevel.id.label', default: 'Id')}" />
		                        
		                            <g:sortableColumn property="amout" title="${message(code: 'gasTankLevel.amout.label', default: 'Amout')}" />
		                        
		                            <g:sortableColumn property="instrumentAmount" title="${message(code: 'gasTankLevel.instrumentAmount.label', default: 'Instrument Amount')}" />
		                        
		                            <g:sortableColumn property="instrumentTemprature" title="${message(code: 'gasTankLevel.instrumentTemprature.label', default: 'Instrument Temprature')}" />
		                        
		                            <th><g:message code="gasTankLevel.tank.label" default="Tank" /></th>
		                        
		                        </tr>
		                    </thead>
		                    <tbody>
		                    <g:each in="${gasTankLevels}" status="i" var="gasTankLevelInstance">
		                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		                        
		                            <td><g:link action="show" id="${gasTankLevelInstance.id}">${fieldValue(bean: gasTankLevelInstance, field: "id")}</g:link></td>
		                        
		                            <td>${fieldValue(bean: gasTankLevelInstance, field: "amout")}</td>
		                        
		                            <td>${fieldValue(bean: gasTankLevelInstance, field: "instrumentAmount")}</td>
		                        
		                            <td>${fieldValue(bean: gasTankLevelInstance, field: "instrumentTemprature")}</td>
		                        
		                            <td>${fieldValue(bean: gasTankLevelInstance, field: "tank.tankNo")}</td>
		                        
		                        </tr>
		                    </g:each>
		                    </tbody>
		                </table>
		            </div>
            
				</div>
				 -->
	        </div>
	        </g:if>
        </div>
        
        <div id="stockTakingItemDiv">
        </div>
        
    </body>
</html>
