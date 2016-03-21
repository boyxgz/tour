<!DOCTYPE html>
<%@page import="com.surelution.tour.User"%>
<%@page import="com.surelution.tour.UserPageEntry"%>
<%@page import="com.surelution.tour.PageEntry"%>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
		<resource:accordion skin="default" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <style type='text/css' media='screen'>
			dl.accordion-menu dd.a-m-d .bd {
				padding: 0px;
			}
		</style>
		
        <g:layoutHead />
        <g:javascript library="application" />
    </head>
   
    <g:set var="loggedUserId"><sec:loggedInUserInfo field="id"/></g:set>
    <%
		def cats
		def authPages
		def currPage
		if(loggedUserId) {
			currPage = PageEntry.findByControllerNameAndActionName(controllerName, actionName)
			def user = User.get(loggedUserId.toString())
			def userPageEntries = UserPageEntry.findAllByUser(user)
			def menus = new HashSet()
			userPageEntries.each {
				menus.add(it.entry.parent)
			}
			
			authPages = userPageEntries.collect {
				it.entry
			}
			
			menus.each {entry->
				entry.children.each {child->
					def show = authPages.contains(entry)
					entry.metaClass.getShow {show}
				}
			}
			
			cats = menus.sort {
				it.positionSeq
			}
		}
	 %>
    <body>
	    <div id="container">
	    	<div id="header">
	    		<div style="float:left">
		    		<a href="${createLink(uri: '/')}" title="计量管理平台"><img style="border: 0 none;" src="${resource(dir:'images',file:'title.png')}" width="900px" height="80px"/></a>
					<div style='float: right;font-size:12px;color:black;'>
					当前用户：<sec:username />&nbsp;&nbsp;<g:link controller="user" action="showChangePw" style="color:black;font-weight:normal;">更改密码</g:link>&nbsp;&nbsp;<g:link controller="logout" style="color:black;font-weight:normal;">退出</g:link>
					</div>
		    	</div>
	    	</div>
			<div id="leftcol">
			<!--
					<richui:accordion style="width:140px;padding:0px;">
					<g:each in="${cats }" var="cat">
						<richui:accordionItem id="menu_cat_${cat.id }" caption="${cat.label }" expanded="${currPage?.parent?.id==cat.id }" class="aaa">
							<g:each in="${cat.children.findAll({it.showInMenu}).sort {it.positionSeq}}" var="item">
								<g:if test="${authPages.collect{it.id}.contains(item.id) }">
									<p style="width:140px;border:1px solid black;">
										<g:link controller="${item.controllerName }" action="${item.actionName }">${item.label }</g:link>
									</p>
									</g:if>
							</g:each>
						</richui:accordionItem>
					</g:each>
					</richui:accordion>	
					-->
				<%--<p style='border-top:0px solid #1f5d7b ;'>
					<g:link url="${resource(dir:'patrolLog')}"  >添加巡检记录</g:link>
				</p>
				--%>
				<%--
				<p>
					<g:link url="${resource(dir:'reports/clockPatrolReport')}"  >站内巡检日报表</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'reports')}"  >上级巡查日报表</g:link>
				</p>
				</sec:ifAnyGranted>
				<p>
					<g:link url="${resource(dir:'reports/departmentClockPatrolReport')}"  >单站巡检报表</g:link>
				</p>
				<sec:ifAnyGranted roles="ROLE-ADMIN">
				<p>
					<g:link url="${resource(dir:'reports/departmentMonthlyReport')}"  >站内巡查月报表</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'reports/supervisorDepartmentMonthlyReport')}"  >上级巡查站月报表</g:link>
				</p>
				<p style='border-bottom:5px solid #3a3838;'>
					<g:link url="${resource(dir:'reports/supervisorMonthlyReport')}"  >上级巡查人月报表</g:link>
				</p>
				</sec:ifAnyGranted>
				<p>
					<g:link url="${resource(dir:'stockTaking/listPatrolls')}">盘点</g:link>
				</p>
				--%>
				<p>
					<g:link url="${resource(dir:'gasUnloading/create')}">卸油</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'deliveryScore')}">配送评价</g:link>
				</p>
				<%--<p>
					<g:link url="${resource(dir:'gasRecircling/batchCreate')}">回罐油</g:link>
				</p>
				--%><p>
					<g:link url="${resource(dir:'gasTankLevel/create')}">液位仪比对</g:link>
				</p>
				<%--<p>
					<g:link url="${resource(dir:'reports/stockTakingReport')}">盘点报表</g:link>
				</p>
				--%><p>
					<g:link url="${resource(dir:'deliveryScore/report')}">卸油损耗报表</g:link>
				</p>
				<%--<p>
					<g:link url="${resource(dir:'reports/supervisorSumMonthlyReport')}">计量工作日志月报</g:link>
				</p>
				--%><p style='border-bottom:5px solid #3a3838;'>
					<g:link url="${resource(dir:'sealWireBatch/create')}">铅封管理</g:link>
				</p>
				<%--<p style='border-bottom:5px solid #3a3838;'>
					<g:link url="${resource(dir:'patrolLogAudit')}"  >机关核查</g:link>
				</p> 
				--%><sec:ifAnyGranted roles="ROLE-ADMIN">
				
				<p >
					<g:link url="${resource(dir:'department')}" >管理加油站</g:link>
				</p>
				
				<%--<p>
					<g:link url="${resource(dir:'wand')}" >指派巡检棒</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'patrolClock')}" >管理巡检时间</g:link>
				</p>
				
				<p>
					<g:link url="${resource(dir:'leave')}" >管理请假</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'leaveType')}" >管理请假类型</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'patrolLogTopic')}" >管理巡检记录项目</g:link>
				</p>
				
				--%><p>
					<g:link url="${resource(dir:'gasType')}" >油品品号管理</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'gasTank')}" >油罐信息维护</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'gasGun')}" >油枪信息维护</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'user')}" >管理用户</g:link>
				</p>
				<%--<p>
					<g:link url="${resource(dir:'vt2Vcf')}" >Vcf信息维护</g:link>
				</p>
				--%></sec:ifAnyGranted>
				<%--
				<p>
					<g:link url="${resource(dir:'wandDropping')}" >巡检棒撞击情况</g:link>
				</p>
				<p style='border-top:5px solid #3a3838;'>
					<g:link url="${resource(dir:'systemInfo')}" >系统信息</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'systemInfo/help')}" >帮助说明</g:link>
				</p>
			--%></div>

			<div id="main_content"><g:layoutBody /></div>
			<div id="footer">
			<p>
			_________________________________________________________________
			</p>
				&copy;<a href="http://www.sh-hansi.com" target="_blank">上海悍思企业管理咨询有限公司</a>技术支持
			</div>
	    </div>
    </body>
</html>