<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
 <%@include file='/common/framework.jspf' %>
 <%@ include file="/common/jquery.jspf" %>
 <%@ include file="/common/ui.jspf" %>
 <%
 request.setCharacterEncoding("UTF-8");
 
 String errInfo = request.getParameter("errInfo");
 if(errInfo==null){
 	errInfo = "";
 }
 	//errInfo = new String(errInfo.getBytes(),"UTF-8");
 
 %>
<script languag="javascript">
	$(this)._alert("提示","<%=request.getParameter("errInfo") %>",null,null,function(){
		history.back();
	});
</script>