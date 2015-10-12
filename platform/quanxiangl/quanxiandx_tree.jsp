 <%@ page language="java"  contentType="text/html;charset=UTF-8"%>

<% 
	/**
	*@author:masheng
	*@createdate:2006-8-7
	*@description:权限对象(权限组/用户)
	**/
%>
<HTML><HEAD>
<TITLE></TITLE>

</HEAD>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@include file="/common/ztree.jspf" %>
<%
	String state=request.getParameter(QamWebDataConstants.QAM_SUBMIT_DIALOGSTATE);
	if(state==null || state.length()==0){
		state="Query";
	}
 %>
<script type="text/javascript">
	function onClick(event, treeId, treeNode){
		parent.parent.frames["RightTree"].document.getElementById("cs_QuanXianDXLX").value="1";
		parent.parent.frames["RightTree"].document.getElementById("cs_QuanXianDXBH").value=treeNode.id;		
		parent.parent.frames["RightTree"].document.getElementById("td_ShouQuanDX").innerText="授权对象："+treeNode.name;	
		parent.parent.frames["RightTree"].doChaXun();
	}
</script>
<body bottomMargin=0 style="overflow-x: hidden;"  leftMargin=0 TOPMARGIN=10 rightMargin=0 >

<html:ztree  tableName = "view_quanxz" rootText="权限组管理" rootId="rooter" events="onClick:onClick" id="tree1"  idField="id" parentField="pid" textField="title"  orderField="oid" async="false"/><%--xml异步数--%>

</body></HTML>

