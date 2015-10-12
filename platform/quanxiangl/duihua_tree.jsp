<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<% 
	/**
	*@author:masheng
	*@createdate:2006-8-8	
	*@description:功能对话树
	**/
%>
<%
	String targetPath = "";
	if("liebiaojr".equals(request.getParameter("leixing"))){
		targetPath="GNDH_QXSZCX_LQX";
	}
	else{
		targetPath="GNDH_QXSZ_LQX";
	}
%>
<html>
<head>
<TITLE>功能对话</TITLE>
<script type="text/javascript">
function onClick(event, treeId, treeNode){
	if(treeNode.Type=="0"){
   		parent.document.getElementById("RightTree").src="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog=<%=targetPath%>&_qam_dialog_state=<%=request.getParameter("_qam_dialog_state") %>&cs_QuanXianDXBH=<%=request.getParameter("cs_QuanXianDXBH") %>&cs_QuanXianDXLX=<%=request.getParameter("cs_QuanXianDXLX") %>&cs_DuiHuaBM="+treeNode.id;		
	}
	else if(treeNode.Type=="1" && treeNode.id!="root"){			
		parent.document.getElementById("RightTree").src="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog=<%=targetPath%>&_qam_dialog_state=<%=request.getParameter("_qam_dialog_state") %>&cs_QuanXianDXBH=<%=request.getParameter("cs_QuanXianDXBH") %>&cs_QuanXianDXLX=<%=request.getParameter("cs_QuanXianDXLX") %>&cs_GongNengBM="+treeNode.id;	
	}
	else if(treeNode.Type=="2" ){		
		parent.document.getElementById("RightTree").src="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog=<%=targetPath%>&_qam_dialog_state=<%=request.getParameter("_qam_dialog_state") %>&cs_QuanXianDXBH=<%=request.getParameter("cs_QuanXianDXBH") %>&cs_QuanXianDXLX=<%=request.getParameter("cs_QuanXianDXLX") %>&cs_MoKuaiBH="+treeNode.id;				
	}
	else{
		parent.document.getElementById("RightTree").src="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog=<%=targetPath%>&_qam_dialog_state=<%=request.getParameter("_qam_dialog_state") %>&cs_QuanXianDXBH=<%=request.getParameter("cs_QuanXianDXBH") %>&cs_QuanXianDXLX=<%=request.getParameter("cs_QuanXianDXLX") %>&cs_MoKuaiBH=";		
	}
}
</script>
</HEAD>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@include file="/common/ztree.jspf" %>

<BODY bottomMargin=0 leftMargin=0 topMargin=10 rightMargin=0>
<html:ztree dataSource="" events="onClick:onClick" tableName = "v_GongNengDH" id="tree1" rootText="功能对话" rootId="root" condition="" idField="bianhao" parentField="ShangJiBH" otherField="leixing,Type" textField="MingCheng" orderField="MingCheng"/><%--xml异步数--%>
</SCRIPT>
</BODY></HTML>