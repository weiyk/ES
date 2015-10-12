<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ page language="java"  contentType="text/html;charset=UTF-8"%>
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
<%
	String treeUrl="";
	String listUrl = "";
	if("liequanxjr".equals(request.getParameter("jinrulx"))){
		treeUrl=request.getContextPath()+"/platform/quanxiangl/duihua_tree.jsp?_qam_dialog_state=ChaXun&leixing=liebiaojr";
		listUrl=request.getContextPath() +"/servlet/jspdispatchservlet?_qam_dialog=GNDH_QXSZCX_LQX&_qam_dialog_state=ChaXun";
	}
	else if("hangquanxjr".equals(request.getParameter("jinrulx"))){
		treeUrl=request.getContextPath()+"/platform/quanxiangl/shujufl_tree.jsp?_qam_dialog_state=ChaXun&leixing=liebiaojr";
		listUrl=request.getContextPath() +"/servlet/jspdispatchservlet?_qam_dialog=GNDH_QXSZCX_HQX&_qam_dialog_state=ChaXun";
	}
	else{
		treeUrl=request.getContextPath()+"/platform/quanxiangl/gongneng_tree.jsp?_qam_dialog_state="+request.getParameter("_qam_dialog_state")+"&leixing=liebiaojr";
		listUrl=request.getContextPath() +"/servlet/jspdispatchservlet?_qam_dialog=GNDH_QXSZCX_CZQX&_qam_dialog_state="+request.getParameter("_qam_dialog_state");
	}

%>
<html>
<head>
	<title>权限设置列表</title>
</head>
<body bottomMargin=0 leftMargin=5 topMargin=5 rightMargin=0>
<form name="form2">
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" style="position:relative;top:-8px;">
  <tr> 
	<td  width="180" valign="top"> 
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="10"></td>
			</tr>
			<tr> 
			  <td width="100%" colspan="3"> 
				<table width="100%" border="0" cellspacing="0" cellpadding="0" >
				  <tr> 
					<td width="100%" style="border:none;"><iframe width="100%" height="388" src="<%=treeUrl%>"  style="border-color:#3161C6;border-style:solid;border-width:1;"  id="LeftTree" name="LeftTree" frameborder="none"></iframe></td>
				  </tr>
				</table>
			  </td>
			</tr>
		  </table>
	</td>
	<td width="4"> 
	</td>
	<td> 
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
		  <tr> 
			<td width="100%" style="border:none;"><iframe width="100%" height="410" src="<%=listUrl%>"  style="border:none;"  id="RightTree" name="RightTree" frameborder="none"></iframe></td>
		  </tr>
		</table>
	</td>
  </tr>
</table>
</form>

</body>
</html>

 
