<%@page language="java" contentType="text/html;charset=UTF-8"%>
<%
	String state=request.getParameter(QamWebDataConstants.QAM_SUBMIT_DIALOGSTATE);
	if(state==null || state.length()==0){
		state="Query";
	}
%>
<html>
<head>
	<%-- 平台 --%>
	<%@include file="/common/framework.jspf"%>
	<%-- jquery --%>	
		<%@include file="/common/jquery.jspf"%>
	<%-- jqgrid --%>
		<%@include file="/common/jqgrid.jspf"%>
	<%-- ui --%>
		<%@include file="/common/ui.jspf"%>
	<title>权限组管理</title>
</head>
<body bottomMargin=0 leftMargin=0 topMargin=0 rightMargin=0>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" >  
		  	<tr> 
				<td width="15%">
					<iframe width="100%" height="500" src="<%=request.getContextPath() %>/platform/quanxianzgl/quanxianz_tree.jsp?_qam_dialog_state=<%=state %>"   id="LeftTree" name="LeftTree" frameBorder="0" scrolling="yes"></iframe>
				</td>
				<td width="85%">
					<iframe width="100%" height="520" src="<%=request.getContextPath() %>/platform/quanxianzgl/quanxianz_ml.jsp?_qam_dialog=QuanXianZCX&_qam_dialog_state=<%=state %>&cs_ShangJiBH=rooter"   scrolling="no" id="RightTree" name="RightTree" frameBorder="0"></iframe>
				</td>
			</tr>
		</table>
	</body>
</html>