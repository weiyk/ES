<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
 <% 
	/**
	*@author:masheng
	*@createdate:2006-8-8	
	*@description:功能活动树

	**/
%>
<%
	String targetPath = "";
	String condition = "";
	if("liebiaojr".equals(request.getParameter("leixing"))){
		targetPath="_qam_dialog=GNDH_QXSZCX_CZQX";		
		condition = " quanxianbz='1'";
	}
	else{
		targetPath="_qam_dialog=GNDH_QXSZ_CZQXHMD&cs_QuanXianDXBH="+request.getParameter("cs_QuanXianDXBH")+"&cs_QuanXianDXLX="+request.getParameter("cs_QuanXianDXLX");
		condition = " quanxianbz='1' and Type!='0'";
	}
%>
<html>
<head>
<TITLE>功能活动</TITLE>
<SCRIPT language=JavaScript>
function onClick(event, treeId, treeNode){
		if(treeNode.Type=="2"){
	   		parent.document.getElementById("RightTree").src="<%=request.getContextPath() %>/servlet/jspdispatchservlet?<%=targetPath%>&_qam_dialog_state=<%=request.getParameter("_qam_dialog_state") %>&cs_GongNengBM="+treeNode.id;		
		}
		else if(treeNode.Type=="1" && treeNode.id!="root"){
			parent.document.getElementById("RightTree").src="<%=request.getContextPath() %>/servlet/jspdispatchservlet?<%=targetPath%>&_qam_dialog_state=<%=request.getParameter("_qam_dialog_state") %>&cs_QuanXianDXBH=<%=request.getParameter("cs_QuanXianDXBH")%>&cs_QuanXianDXLX=<%=request.getParameter("cs_QuanXianDXLX")%>&cs_MoKuaiBH="+treeNode.id;		
		}
		else if(treeNode.Type=="0"){
			parent.document.getElementById("RightTree").src="<%=request.getContextPath() %>/servlet/jspdispatchservlet?<%=targetPath%>&_qam_dialog_state=<%=request.getParameter("_qam_dialog_state") %>&cs_QuanXianDXBH=<%=request.getParameter("cs_QuanXianDXBH")%>&cs_QuanXianDXLX=<%=request.getParameter("cs_QuanXianDXLX")%>&cs_HuoDongBM="+treeNode.id;		
		}
		else if(treeNode.id=="root"){
			parent.document.getElementById("RightTree").src="<%=request.getContextPath() %>/servlet/jspdispatchservlet?<%=targetPath%>&_qam_dialog_state=<%=request.getParameter("_qam_dialog_state") %>&cs_QuanXianDXBH=<%=request.getParameter("cs_QuanXianDXBH")%>&cs_QuanXianDXLX=<%=request.getParameter("cs_QuanXianDXLX")%>";
		}
	
}
function dataFilter(treeId, parentNode, childNodes){
	if(childNodes){
		$.each(childNodes,function(i,node){
			if(node.Type == 2){
				node.isParent = false;
			}
		});
	}
	return childNodes;
}
</SCRIPT>
</HEAD>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@include file="/common/ztree.jspf" %>

<BODY bottomMargin=0 leftMargin=0 topMargin=10 rightMargin=0 style="overflow-x:auto;" >
<html:ztree dataSource="" dataFilter="dataFilter" events="onClick:onClick" tableName = "v_GongNengHD" id="tree1" rootId="root" rootText="功能模块" condition="<%=condition%>" idField="bianhao" parentField="ShangJiBH" textField="MingCheng" otherField="Type" orderField="YeWuBM"/><%--xml异步数--%>
</BODY></HTML>