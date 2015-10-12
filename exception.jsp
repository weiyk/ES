<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<%
System.out.println(request.getParameter("errInfo"));
System.out.println(request.getParameter("fullErrInfo")); 
%>
<html>
<head>
	<title>exceptions</title>
	<%@include file="/Preamble.jspf"%>
	<style type="text/css">
		<!--
		body,input{font-size:12px;margin:0;	padding:0;font-family:verdana,Arial, Helvetica, sans-serif;	color:#000}
		
		body{text-align:center; margin:0 auto}
		
		.title{background-color:#35AEE3;font-weight:bold;color:#fff;padding:6px 10px 8px 7px;}
		
		.errMainArea{width:900px; margin:80px auto 0 auto;text-align:left; border:1px solid #aaa}	
		
			.errTxtArea{ padding:30px 34px 0 110px;}
		
				.errTxtArea .txt_title{	font-size:150%;	font-weight:bolder;	font-family:"Microsoft JhengHei","微软黑体","Microsoft YaHei","微软雅黑";}	
		
			.errBtmArea{ padding:10px 8px 25px 8px ;background-color:#fff;text-align:center; }
		
		.btnFn1 {cursor:pointer!important;cursor:hand;  height:30px; width:101px; padding:3px 5px 0 0; font-weight:bold; }
		-->
	</style>
</head>
<body >
	<p></p>
	<p></p>
	<p></p>
	<p></p>
	<p></p>
	<div class="errMainArea" >
		<div   class="title" ><font color="white">running error</font></div>
		<div class="errTxtArea">
			<p class="txt_title" >系统运行时出现不可回退时错误，错误信息如下：</p>
			<br/>
			<p class="txt_title" ><c:out value="${param.errInfo}"></c:out><c:out value="${param.fullErrInfo}"></c:out></p>
			<p class="txt_title" ><c:out value="${paramValues.errInfo}"></c:out><c:out value="${paramValues.fullErrInfo}"></c:out></p>
			</div>
		<div class="errBtmArea">
  		</div>
	</div>
</body>
</html>

