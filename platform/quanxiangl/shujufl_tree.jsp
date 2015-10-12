<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
  <%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<% 
	/**
	*@author:masheng
	*@createdate:2006-8-4	
	*@description:功能模块树
	**/
%>
<html>
<head>
<TITLE>功能活动</TITLE>
</HEAD>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@include file="/common/ztree.jspf" %>
<%
	String targetPath = "";
	if("liebiaojr".equals(request.getParameter("leixing"))){
		targetPath="_qam_dialog=GNDH_QXSZCX_HQX";
	}
	else{
		targetPath="_qam_dialog=GNDH_QXSZ_HQX&cs_QuanXianDXBH="+request.getParameter("cs_QuanXianDXBH")+"&cs_QuanXianDXLX="+request.getParameter("cs_QuanXianDXLX");		
	}
%>
<SCRIPT language=JavaScript>
var tmp =0;
function  onClick(event, treeId, treeNode){
	tmp ++;		
	if(treeNode.Type=="0"){			
   		parent.document.getElementById("RightTree").src="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog_state=<%=request.getParameter("_qam_dialog_state") %>&<%=targetPath%>&cs_ShuJuFLBH="+treeNode.id+"&tmp="+tmp;					
	}
	else if(treeNode.Type="1" && treeNode.id!="root" && <%="liebiaojr".equals(request.getParameter("leixing"))%>){
		parent.document.getElementById("RightTree").src="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog_state=<%=request.getParameter("_qam_dialog_state") %>&<%=targetPath%>&cs_MoKuaiBH="+treeNode.id;		
	}
	else if(treeNode.Type="1" && treeNode.id=="root" && <%="liebiaojr".equals(request.getParameter("leixing"))%>){
		parent.document.getElementById("RightTree").src="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog_state=<%=request.getParameter("_qam_dialog_state") %>&<%=targetPath%>";		
	}
	else if(treeNode.Type="2" && <%="liebiaojr".equals(request.getParameter("leixing"))%>){
		parent.document.getElementById("RightTree").src="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog_state=<%=request.getParameter("_qam_dialog_state") %>&<%=targetPath%>&cs_GongNengBM="+treeNode.id;		
	}
	else if(treeNode.Type="3" && <%="liebiaojr".equals(request.getParameter("leixing"))%>){
		parent.document.getElementById("RightTree").src="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog_state=<%=request.getParameter("_qam_dialog_state") %>&<%=targetPath%>&cs_HuoDongBM="+treeNode.id;		
	}
	else if(treeNode.Type="4" && <%="liebiaojr".equals(request.getParameter("leixing"))%>){
		parent.document.getElementById("RightTree").src="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog_state=<%=request.getParameter("_qam_dialog_state") %>&<%=targetPath%>&cs_ShiWuDYBH="+treeNode.id;		
	}
}
</SCRIPT>
<BODY bottomMargin=1 leftMargin=0 topMargin=10 rightMargin=0 style="overflow-x:auto;">
<html:ztree dataSource="" events="onClick:onClick" tableName = "v_ShuJuFL" id="tree1" rootText="功能模块" rootId="root" condition="" idField="bianhao" parentField="ShangJiBH" otherField="leixing,Type" textField="MingCheng"   orderField="MingCheng"/><%--xml异步数--%>
</BODY></HTML>