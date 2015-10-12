<%@page contentType="text/html;charset=UTF-8"%>
 <html>
 <head>
 <%@include file='/common/framework.jspf' %>
 <%@ include file="/common/jquery.jspf" %>
 <%@ include file="/common/ui.jspf" %>
<title>操作提示</title>
</head>
<body onload="showMessage()">
<%--@ include file="/common/messagebox.jspf" --%>
<script language="javascript">
	
	if(typeof(opener)!='undefined' && opener!=null){
		try{
			opener.document.forms[0].submit();
		}
		catch(e){}
		
	}
	
		function showMessage(){
	<%
		String tip = request.getParameter(com.qam.web.QamWebDataConstants.QAM_OPERATE_SUCCESS_TIP);
		if(tip!=null && tip.length()>0){
	%>	
		try{
			message_show_success('<%=tip%>');
		}
		catch(e){
			$(this)._alert('提示','<%=tip%>',null,null,function(){
				$(this)._close('1');
			});
		}
	<%		
		}
		else{
	%>
		$(this)._close('1');
	<%	}
	%>
	}
	function afterMessageBoxHide(){
		$(this)._close('2');
	}
</script>
</body>
</html>