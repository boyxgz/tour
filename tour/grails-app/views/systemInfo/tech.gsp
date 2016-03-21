
<%@page import="javax.transaction.UserTransaction"%>
<%@ page import="com.surelution.tour.User" %>
<html>
    <head>
       <title>系统技术信息</title>
    </head>
    <body>
        <div class="content1">
	    	<p>系统运行信息</p>
	    	<p>以下信息供系统管理员在程序运行不正常时参考，普通用户无需关心本页信息</p>
	    	<p>在必要时，请协助软件提供商将此屏截屏，发送给相关技术人员</p>
	    	<table border="1" cellpadding="0" cellspacing="0">
	    		<tr>
	    			<td align="center" width="150px">名称</td>
	    			<td align="center" width="400px">内容</td>
	    		</tr>
	    		<tr>
	    			<td align="right">系统架构</td>
	    			<td>${os.arch }</td>
	    		</tr>
	    		<tr>
	    			<td align="right">操作系统名称</td>
	    			<td>${os.name }</td>
	    		</tr>
	    		<tr>
	    			<td align="right">操作系统版本</td>
	    			<td>${os.version }</td>
	    		</tr>
	    		<tr>
	    			<td align="right">cpu个数</td>
	    			<td>${os.availableProcessors }</td>
	    		</tr>
	    		<tr>
	    			<td align="right">运行时名称</td>
	    			<td>${rt.name }</td>
	    		</tr>
	    		<tr>
	    			<td align="right">运行时规范</td>
	    			<td>${rt.specName }</td>
	    		</tr>
	    		<tr>
	    			<td align="right">运行时发布商</td>
	    			<td>${rt.specVendor }</td>
	    		</tr>
	    		<tr>
	    			<td align="right">运行时规范版本</td>
	    			<td>${rt.specVersion }</td>
	    		</tr>
	    		<tr>
	    			<td align="right">jmx规范版本</td>
	    			<td>${rt.managementSpecVersion }</td>
	    		</tr>
	    		<g:set var="heapUsage" value="${mem.heapMemoryUsage}"/>
	    		<g:set var="nonHeapUsage" value="${mem.nonHeapMemoryUsage}"/>
	    		<g:set var="oneM" value="${1024*1024 }"/>
	    		<tr>
	    			<td align="right">heap committed</td>
	    			<td>${(int)heapUsage.committed/oneM}</td>
	    		</tr>
	    		<tr>
	    			<td align="right">heap init</td>
	    			<td>${(int)heapUsage.init/oneM}</td>
	    		</tr>
	    		<tr>
	    			<td align="right">heap max</td>
	    			<td>${(int)heapUsage.max/oneM}</td>
	    		</tr>
	    		<tr>
	    			<td align="right">heap used</td>
	    			<td>${(int)heapUsage.used/oneM}</td>
	    		</tr>
	    		<tr>
	    			<td align="right">NonHeap committed</td>
	    			<td>${(int)nonHeapUsage.committed/oneM}</td>
	    		</tr>
	    		<tr>
	    			<td align="right">NonHeap init</td>
	    			<td>${(int)nonHeapUsage.init/oneM}</td>
	    		</tr>
	    		<tr>
	    			<td align="right">NonHeap max</td>
	    			<td>${(int)nonHeapUsage.max/oneM}</td>
	    		</tr>
	    		<tr>
	    			<td align="right">NonHeap used</td>
	    			<td>${(int)nonHeapUsage.used/oneM}</td>
	    		</tr>
	    	</table>
    	</div>
    </body>
</html>
