<%@page import="com.surelution.tour.CommonDensity"%>
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
            <p style="font-size: +2">
            所属站点：${taking.department.name }<br/>
            期初盘点时间：<g:formatDate date="${taking.firstTaking.takingTime }"/><br/>
            期末盘点时间：<g:formatDate date="${taking.lastTaking.takingTime }"/>
            </p>
            <div class="list">
            	<table>
            	<thead>
            		<tr>
            			<th>油罐</th>
            			<th>期初库存</th>
            			<th>期末库存</th>
            			<th>库存增量</th>
            			<th>卸油量</th>
            			<th>卸油量计划量</th>
            			<th>回罐油量</th>
            			<th>油枪编号</th>
            			<th>期初泵码数</th>
            			<th>期末泵码数</th>
            			<th>加油枪走码数</th>
            			<th>销售数小计</th>
            			<th>Vcf</th>
            			<th>油罐实出</th>
            			<th>损耗量</th>
            			<th>损耗率(‰)</th>
            			<th>损耗率(含卸油)(‰)</th>
            			<th>损耗率(财务账面)(‰)</th>
            		</tr>
            		</thead>
            		<tbody>
	       				<g:set var="startStockTakingAmount" value="${0}"/>
	       				<g:set var="endStockTakingAmount" value="${0}"/>
	       				<g:set var="unloadingAmount" value="${0}"/>
	       				<g:set var="recirlingAmount" value="${0}"/>
	       				<g:set var="tankSalesAmount" value="${0}"/>
	       				
	           			<g:set var="totalTankSalesAmount" value="${0 }"/>
	           			<g:set var="totalThriftAmount" value="${0 }"/>
	           			<g:set var="totalThriftAmountIncludeUnloading" value="${0 }"/>
	           			<g:set var="vcf" value="${0 }"/>
	           			<g:set var="idOdd" value="${false }"/>
	           			
            			<g:each in="${taking.tankTakings }" var="tankTaking">
            				<g:set var="startDensity" value="${CommonDensity.findDensityByDateAndType(taking.firstTaking.takingTime, tankTaking.tank.gasType) -1.1 }"/>
            				<g:set var="endDensity" value="${CommonDensity.findDensityByDateAndType(taking.lastTaking.takingTime, tankTaking.tank.gasType) - 1.1 }"/>
            				
            				<g:set var="hasPut" value="${false }"/>
            				<g:set var="rowspan" value="${tankTaking.gunTakings.size() }"/>
            				<g:each in="${tankTaking.gunTakings}" var="gunTaking">
	           					<g:set var="idOdd" value="${!idOdd }"/>
            					<tr class="${idOdd ? 'odd' : 'even'}">
            						<g:if test="${!hasPut }">
					       				<g:set var="startStockTakingAmount" value="${tankTaking.startTakingItem?.stockAmount}"/>
					       				<g:set var="startStockTakingAmount" value="${startStockTakingAmount?startStockTakingAmount:0}"/>
					       				
					       				<g:set var="endStockTakingAmount" value="${tankTaking.endTakingItem?.stockAmount}"/>
					       				<g:set var="endStockTakingAmount" value="${endStockTakingAmount?endStockTakingAmount:0}"/>
					       				
					       				<g:set var="unloadingAmount" value="${tankTaking.unloadingAmount}"/>
					       				<g:set var="unloadingAmount" value="${unloadingAmount?unloadingAmount:0}"/>
					       				
					       				<g:set var="planningUnloadingAmount" value="${tankTaking.planningUnloadingAmount}"/>
					       				<g:set var="planningUnloadingAmount" value="${planningUnloadingAmount?planningUnloadingAmount:0}"/>
					       				
					       				<g:set var="recirlingAmount" value="${tankTaking.recirclingAmount}"/>
					       				<g:set var="recirlingAmount" value="${recirlingAmount?recirlingAmount:0}"/>
					       				
	       								<g:set var="tankSalesAmount" value="${tankTaking.totalGunsAmount}"/>
	       								<g:set var="tankSalesAmount" value="${tankSalesAmount?tankSalesAmount:0}"/>
	       								
	           							<g:set var="vcf" value="${tankTaking.vt2VcfRatio }"/>
            							<td rowspan="${rowspan}">${tankTaking.tank.tankNo }(${tankTaking.tank.gasType.title })</td>
				            			<td rowspan="${rowspan}">${startStockTakingAmount}</td>
				            			<td rowspan="${rowspan}">${endStockTakingAmount}</td>
				            			<td rowspan="${rowspan}">${formatNumber(number:(endStockTakingAmount - startStockTakingAmount), maxFractionDigits:1)}</td>
				            			<td rowspan="${rowspan}">${unloadingAmount}</td>
				            			<td rowspan="${rowspan}">${planningUnloadingAmount}</td>
				            			<td rowspan="${rowspan}">${recirlingAmount}</td>
            						</g:if>
			            			<td>${gunTaking.gun.gunNo }</td>
			            			<g:set var="startGunSalesAmount" value="${gunTaking.startGunItem?.salesAmount }"/>
			            			<g:set var="startGunSalesAmount" value="${startGunSalesAmount?startGunSalesAmount:0 }"/>
			            			
			            			<g:set var="endGunSalesAmount" value="${gunTaking.endGunItem?.salesAmount }"/>
			            			<g:set var="endGunSalesAmount" value="${endGunSalesAmount?endGunSalesAmount:0 }"/>
			            			<td>${startGunSalesAmount}</td>
			            			<td>${endGunSalesAmount}</td>
			            			<td>${formatNumber(number:(endGunSalesAmount - startGunSalesAmount), maxFractionDigits:2) }</td>
            						<g:if test="${!hasPut }">
			            				<td rowspan="${rowspan}">${tankSalesAmount}</td>
			            				<td rowspan="${rowspan}">${vcf }</td>
				            			
					           			<g:set var="totalTankSalesAmount" value="${totalTankSalesAmount + vcf * tankSalesAmount}"/>
					           			<g:set var="totalThriftAmount" value="${totalThriftAmount + (unloadingAmount+startStockTakingAmount-endStockTakingAmount+recirlingAmount-vcf * tankSalesAmount)}"/>
					           			
					           			<g:set var="totalThriftAmountIncludeUnloading" value="${totalThriftAmountIncludeUnloading + (planningUnloadingAmount+startStockTakingAmount-endStockTakingAmount+recirlingAmount-vcf * tankSalesAmount)}"/>
					           			
			            				<td rowspan="${rowspan}">${formatNumber(number:(vcf * tankSalesAmount), maxFractionDigits:1)}</td>
			            				<td rowspan="${rowspan}">${formatNumber(number:-(unloadingAmount+startStockTakingAmount-endStockTakingAmount+recirlingAmount-vcf * tankSalesAmount), maxFractionDigits:1) }</td>
			            				<td rowspan="${rowspan}">${(vcf * tankSalesAmount) == 0?"":formatNumber(number:-(unloadingAmount+startStockTakingAmount-endStockTakingAmount+recirlingAmount-vcf * tankSalesAmount)*1000/(vcf * tankSalesAmount), maxFractionDigits:1) }</td>
			            				<td rowspan="${rowspan}">${(vcf * tankSalesAmount) == 0?"":formatNumber(number:-(planningUnloadingAmount+startStockTakingAmount-endStockTakingAmount+recirlingAmount-vcf * tankSalesAmount)*1000/(vcf * tankSalesAmount), maxFractionDigits:1) }</td>
			            				
			            				<td rowspan="${rowspan}">${(tankSalesAmount) == 0?"":formatNumber(number:-(Math.round(startStockTakingAmount*startDensity/1000)+planningUnloadingAmount*endDensity/1000-(tankSalesAmount-recirlingAmount)*endDensity/1000-Math.round(endStockTakingAmount*endDensity/1000))/((tankSalesAmount-recirlingAmount)*endDensity/1000000), maxFractionDigits:3) }</td>
			            				<!-- <td rowspan="${rowspan}">((${planningUnloadingAmount}-${endStockTakingAmount}+${recirlingAmount}-${tankSalesAmount})*${endDensity}+(${startStockTakingAmount})*${startDensity})*1000/((${tankSalesAmount}-${recirlingAmount})*${endDensity})</td> -->
			            			</g:if>
            						<g:set var="hasPut" value="${true }"/>
            					</tr>
            				</g:each>
            			</g:each>
            		</tbody>
            		<tfoot>
            			<tr style="color: blue;text-decoration:underline;">
            				<td>总计</td>
            				<td colspan="12">&nbsp;</td>
            				<td>${formatNumber(number:(totalTankSalesAmount), maxFractionDigits:1)  }</td>
            				<td>${formatNumber(number:(-totalThriftAmount), maxFractionDigits:1)  }</td>
            				<td>${totalTankSalesAmount==0?"":formatNumber(number:-(totalThriftAmount*1000/totalTankSalesAmount), maxFractionDigits:1)  }</td>
            				<td>${totalTankSalesAmount==0?"":formatNumber(number:-(totalThriftAmountIncludeUnloading*1000/totalTankSalesAmount), maxFractionDigits:1)  }</td>
            				<td><g:formatNumber number="${-taking.financialShrinkRate*1000}" maxFractionDigits="3"/></td>
            			</tr>
            		</tfoot>
            	</table>
            	说明：正数为盘盈，负数为盘亏
            	</div>
        </div>
        
    </body>
</html>
