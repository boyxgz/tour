
<%@page import="javax.transaction.UserTransaction"%>
<%@ page import="com.surelution.tour.User" %>
<html>
    <head>
       <title>系统信息</title>
        <meta name="layout" content="main" />
        <style type="text/css" media="screen">
        	.p1 {
        		font-size:15px;
        		font-weight:bold;
        		padding-top:2px;
        		padding-bottom:2px;
        	} 
        	.pp{
        	    font-size:13px;
        	
        	}
        	.ppp{
        	    font-size:13px;
        	    font-weight:normal;
        	    word-wrap: break-word;
        	    word-break: normal; 
        	}
        </style>
        
    </head>
    <body>
        <div class="nav">
        	<span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="content1">
        	<p class=p1>系统信息</p>
	    	<p style='font-size:13px;font-weight:normal;'>本软件授权给：</br>&nbsp;&nbsp;&nbsp;&nbsp;${application["system-info"].companyName}，使用日期自${application["system-info"].from.format("yyyy年MM月dd日")}至${application["system-info"].to.format("yyyy年MM月dd日")}，
	    	超过使用日期使用，可能带来数据丢失等异常，且<a href="http://www.sh-hansi.com/" target="_blank">上海悍思企业管理咨询有限公司</a>不再为使用提供技术支持。</p>
	    	<p style='padding-top:10px;'>系统详细配置信息：</p>
	    	<p class='pp'>巡更棒编号:</p>
	    	<p class='ppp'>${wandSn }</p>
	    	<p class='pp'>地址钮编号:</p>
	    	<p class='ppp'>${poiSn}</p>
    	</div>
    </body>
</html>
