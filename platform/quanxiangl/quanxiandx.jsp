<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<% 
	/**
	*@author:masheng
	*@createdate:2006-8-7	
	*@description:权限对象
	*
	**/
%>
<html>
<head>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@include file="/common/ui.jspf" %>
<%@include file="/common/jqgrid.jspf" %>
<%@include file="/common/ztree.jspf" %>
<html:dialog id="GNDH_YongHuLB"/>
<title>权限对象</title>
<script type="text/javascript">
	function resizeGrid(groupId){
		var ss = getPageSize();
		$("#"+groupId).jqGrid('setGridWidth', ss.WinW-55);
	}
	$(function(){
		$("#tabs_GNDH_YongHuLB").bind('tabsselect',function(event, ui){
			if(ui.index == 1){
				var con = ['dc_YongHuM'];
				$(this)._search('YongHuLB','SouSuo',con,'ChaXun');
			}
		});
		$("#SouSuo").attr('onclick','');
		$("#SouSuo").bind('click',function(){
			var con = ['dc_YongHuM'];
			$(this)._search('YongHuLB','SouSuo',con,'ChaXun');
		});
	});
	function doSheZhiQX(var1,var2,var3){//0,用户编号,登录名	
		parent.frames["RightTree"].document.getElementById("cs_QuanXianDXLX").value='0';
		parent.frames["RightTree"].document.getElementById("cs_QuanXianDXBH").value=var2;
		parent.frames["RightTree"].document.getElementById("td_ShouQuanDX").innerText="授权对象："+var3;				
		parent.frames["RightTree"].doChaXun();
	}
</script>
</head>
<body bottomMargin=0 leftMargin=0 topMargin=0 rightMargin=0 >
<html:form>
<html:tabcontrol style="font-size:90%; height: 95%;">
	<html:tabtitle  tabNames="权限组,用户"/>
	<html:tabpage index="1">
		<iframe width="100%" height="440" src="<%=request.getContextPath() %>/platform/quanxiangl/quanxiandx_tree.jsp" scrolling="auto" id="frame_1" name="content" frameBorder="0"></iframe>
	</html:tabpage>
	<html:tabpage index="2">
		<html:text id="dc_YongHuM" modeStyle="ui-widget-content ui-corner-all" style="width:130px;height:20px" title="按登录名或用户姓名搜索"/>
		<html:command id="SouSuo"/>
		<html:splitline width="70%"/>
		<html:jqgrid id="YongHuLB" pager="pager"   height="450"     viewRecords="false" autoWidth="true" />
	<%-- 
		<iframe width="100%" height="80%" src="" id="frame_2" name="content" frameBorder="0"></iframe>--%>
	</html:tabpage>
</html:tabcontrol>

</html:form> 
<script type="text/javascript">
		$(function(){
			$(window).wresize(function(){
				content_resize($('#YongHuLB'),window,57,150);
			});
			content_resize($('#YongHuLB'),window,57,150);
		});
	</script>
</body>
</html>