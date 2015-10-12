<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ page language="java" contentType="text/html;charset=UTF-8"%>
<% 
	/**
	*@author:masheng(邮箱名)
	*@createdate:2006-6-10(精确到日)
	*@description:用户查询
	*@version: 
	**/
%>
<html>
<head>
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<!-- jquery -->
<%@include file="/common/jquery.jspf" %>
<!-- ui -->
<%@include file="/common/ui.jspf"%>
<%-- jqgrid --%>
<%@include file="/common/jqgrid.jspf"%>	
<%--ztree --%>
<%@include file="/common/ztree.jspf" %>

<%@ page import="com.qam.web.extension.tree.*" %>
<html:dialog id="GNDH_XuanZeSJX_Tree" /><%--进行对话初始化(必须的且在其他任何标签之前)--%>

<base target="_self">
<title><%=executeResult.getDialog().getName() %></title>

</head>
<body >

<html:form  ><%--产生form标签(可选的) --%>

<html:splitline width="100%"/><%--产生间隔线(可选的) --%>

<%
	String state = request.getParameter("_qam_dialog_state");	
	String select_target = request.getParameter("select_target");
	String submitFlag = request.getParameter("submitFlag");
	String yixuan = request.getParameter("cs_ShuJuXZ");		
	String shujuxbm = request.getParameter("cs_ShuJuXBM");
	TreeBean treeBean = null;
	String tablename = "";
	String bianhao ="";
	String shangjibh="";
	String mingcheng ="";
	String sql = "";
	tablename = request.getParameter("cs_TableName");
	
	if("submited".equals(submitFlag)){
		treeBean = new TreeBean();
		bianhao = request.getParameter("di_BianHao");
 		shangjibh = request.getParameter("di_ShangJiBH");
 		mingcheng = request.getParameter("di_MingCheng");		 			 		
 		treeBean.setBianhao(bianhao);
	    treeBean.setBiaoming(tablename);
	    treeBean.setMingcheng(mingcheng);
	    treeBean.setShangjibh(shangjibh);
	    RightTreeViewManage.getInstance().saveTreeBean(treeBean);	
	    response.sendRedirect(request.getContextPath()+"/platform/quanxiangl/treeview.jsp?cs_TableName="+tablename+"&cs_BianHao="+bianhao+"&cs_MingCheng="+mingcheng+"&cs_ShangJiBH="+shangjibh+"&cs_ShuJuXZ="+yixuan+"&cs_ShuJuXBM="+shujuxbm+"&cs_DuoXuan=true&select_target="+select_target);		    
	}
	sql = "select distinct sx.MingCheng,sx.BieMing from QAM_ShuXing SX  where SX.shitibm='"+tablename+"' order by SX.BieMing  ";
	if(state.equals("DHZT_XuanZe")){	
				
		treeBean = RightTreeViewManage.getInstance().findTreeBean(tablename);	
		if(treeBean != null){			
			bianhao = treeBean.getBianhao();		
			mingcheng = treeBean.getMingcheng();
			shangjibh = treeBean.getShangjibh();					
			response.sendRedirect(request.getContextPath()+"/platform/quanxiangl/treeview.jsp?cs_TableName="+tablename+"&cs_BianHao="+bianhao+"&cs_MingCheng="+mingcheng+"&cs_ShangJiBH="+shangjibh+"&cs_ShuJuXZ="+yixuan+"&cs_ShuJuXBM="+shujuxbm+"&cs_DuoXuan=true&select_target="+select_target);
		}
	}
	

%>
<table align="center" border=0 width="99%" cellspacing="0" cellpadding="2" class="table">
	<tr>
		<td align="center" class="title" width="30%">	
			名称
		</td>
		<td align="center" class="content_L"  width="70%">	
			<html:select id="di_MingCheng" initText="" enumSQL="<%=sql %>"   style="width:90%"/>
		</td>
	</tr>
	<tr>
		<td align="center" class="title">	
			编号
		</td>
		<td align="center" class="content_L" >	
			<html:select id="di_BianHao" initText="" enumSQL="<%=sql %>"   style="width:90%"/>
		</td>
	</tr>
	<tr>
		<td align="center" class="title">	
			上级编号
		</td>
		<td align="center" class="content_L" >	
			<html:select id="di_ShangJiBH" initText="" enumSQL="<%=sql %>" onchange="chcekSJBH()" style="width:90%"/>
		</td>
	</tr>	
	<tr>
		<td align="center" colspan="2" width="98%">
		<html:command id="MLKZ_QueDing"/><html:command id="MLKZ_GuanBi"/>
		</td>
	</tr>
</table>

<input type="hidden" name="submitFlag" value="submited">
<html:controls id="dc_ShuJuBBM" value="<%=tablename %>"/>
<html:paraSave/>
</html:form><%--form标签结束(可选的,如果使用了form标签，则是必须的) --%>
<script type="text/javascript">
	function chcekSJBH(){		
		var bianhao = document.getElementById("di_BianHao").value;
		var shangjibh = document.getElementById("di_ShangJiBH").value;
		if(shangjibh == bianhao){			
			alert("上级编号不能与编号相同，请重新选择");
			document.getElementById("di_ShangJiBH").value = "";
		}		
	}	
</script>
</body>
</html>