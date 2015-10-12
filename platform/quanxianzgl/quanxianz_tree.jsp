<%@page language="java" contentType="text/html;charset=UTF-8"%>
<%-- 平台 --%>
	<%@include file="/common/framework.jspf"%>
	<%-- jquery --%>	
		<%@include file="/common/jquery.jspf"%>
	<%-- ztree --%>
		<%@include file="/common/ztree.jspf"%>
<HTML>
	<HEAD>
		<TITLE>角色树</TITLE>
	</HEAD>
	
<%
	String state=request.getParameter(QamWebDataConstants.QAM_SUBMIT_DIALOGSTATE);
	if(state==null || state.length()==0){
		state="Query";
	}
%>
<SCRIPT language=JavaScript>
	function onClick(event, treeId, treeNode) {	
		parent.document.getElementById("RightTree").src="<%=request.getContextPath()%>/platform/quanxianzgl/quanxianz_ml.jsp?_qam_dialog=QuanXianZCX&_qam_dialog_state=<%=state %>&cs_ShangJiBH="+treeNode.id ;		
		event.cancelBubble=true;
		return false;
	}
</SCRIPT>
	<BODY>
		<div>
			<html:ztree  tableName = "xt_quanxianz"  events="onClick:onClick"  rootText="权限组管理" rootId="rooter" idField="BIANHAO" parentField="ShangJiBH"   textField="MINGCHENG" async="false" />
		</div>
	</BODY>
</HTML>
