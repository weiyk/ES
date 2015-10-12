<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<%@page import="com.rc.web.utils.*"%>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.rc.web.extension.component.gethaoyouxx.GetHaoYouLB" %>
<%-- 平台 --%>
	<%@include file="/common/framework.jspf"%>
<%
	//获取样式
	String style=request.getContextPath()+"/style";
String yonghubh=(String)request.getSession().getAttribute("XiTongHYBH");
String key=(String)request.getSession().getAttribute("QuanZhi");
String imgUrl=(String)request.getSession().getAttribute("imgUrl");
	//获取路径
	String path=request.getContextPath();
	String yonghuxm =(String)session.getAttribute("YONGHUXM");
	String schoolName=(String) session.getAttribute("schoolName");
	GetHaoYouLB haoyou=new GetHaoYouLB();

%>

<html>
<head>
		
	<title>学习记录</title>
	<link rel="stylesheet" href="<%=style%>/style/page/style.css" />
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
	<html:dialog id="GNDH_XueXiJL" state="DHZT_JinRu"/>
	<%
	RecordSet rs = executeResult.getRecordSet("SWDY_ChaXun");
	int sum =(int)rs.getPageCount();
	request.setAttribute("sum",sum);//保存至内置对象
	%>
	
	<script type="text/javascript">
//提交分页查询
	    function pageSubmit(i){
			$("#_qam_turnpageflag").val('true')
			document.forms[0].action="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueXiJL&_qam_dialog_state=null&_dialog_submit_=GNDH_XueXiJL&pagesize="+i;
			document.forms[0].submit();
		}
    	//点击页码
    	function click(i){
    		$("#_qam_pagenumber_DHSJZ_ChaXunJG").val(i);//控制当前页码
    		pageSubmit(i);
    	}
    	//点击确定
    	function TiaoZhuan(){
    		var sun=$("#wenben").val();
    		var sunPage=$('#di_Sum').val();
    		if(sun*1>sunPage*1||sun<1){
    			sun=1;
    		}
    		$("#_qam_pagenumber_DHSJZ_ChaXunJG").val(sun);//控制当前页码
    		pageSubmit(sun);
    	}
    	//点击上一页和下一页
    	function SX(e,sum){
    		var s=$("#_qam_pagenumber_DHSJZ_ChaXunJG").val();
    		if(e==1){//上一页
    			if(s>1){
    				s=s-1;
    				$("#_qam_pagenumber_DHSJZ_ChaXunJG").val(s);
    				pageSubmit(s);
    			}else{
    				//alert("当前页为首页");
    			}
    		}else if(e==2){//下一页 
    			if(s<sum){
    				s=parseFloat(s)+1;
    				$("#_qam_pagenumber_DHSJZ_ChaXunJG").val(s);
    				pageSubmit(s);
    			}else{
    				//alert("当前页为尾页");
    			}
    		}
    	}
    	</script>
</head>
 <%
 String pagesize=(String)request.getParameter("pagesize");
	if("".equals(pagesize)||pagesize==null){
		pagesize="1";
	}
 		StringBuffer htmlTR=new StringBuffer();
		
		while(rs.next()){
			htmlTR.append("<tr>");
			htmlTR.append("<td>"+rs.getString("di_XueXiSJ")+"</td>");
			htmlTR.append("<td>"+rs.getString("di_KeChengMC")+"</td>");
			htmlTR.append("</tr>");
		}
		
		%>
<body>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengGRKJ" class="user-name blk"><%=yonghuxm %></a> <%=schoolName %> <a href="<%=path%>/servlet/desktop.html" class="to-quit">退出</a></p>
	</div>
</div>
<!-- 头部 -->
<div class="header green-head">
	<div class="in-box wrap clearfix">
		<div class="logo fl">
			<a href="#">双轨数字学校</a>
		</div>
		<ul class="nav fr">
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengKJ" class="cur">首页</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueYiXue">学一学</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_DuYiDu">读一读</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LianYiLian">练一练</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_CeYiCe">测一测</a></li>
		</ul>
	</div>
</div>


<div class="wrap clearfix">

	<div class="fl mt-20 w-710">
		<div class="user-c-form">
			<div class="title-bar green-title clearfix">
				<h2 class="fl">学习记录</h2>
			</div>
		</div>
		 <html:form>
		<div class="table_a">
			<table width="100%" cellpadding="1" cellspacing="1" id="table" >
			 	<thead>
					<tr>
						<th>学习时间</th>
						<th>学习明细</th>
					</tr>
				</thead>
				<tbody id="table2">
					<%=htmlTR.toString() %>  
				</tbody>
			</table>
				  <!-- 翻页 -->
		<input type="hidden" id="di_Sum" name="di_Sum" value="<%=sum%>"/>
		<div class="page-list clearfix" align="center">
			<div style="display: none;">
				<html:self id="SWDY_ChaXun" />
			</div>
			<input type="hidden" id="_qam_turnpageflag" name="_qam_turnpageflag"/>
			<a id="shang" href="javascript:SX(1,<%=sum%>)">上一页</a>
			<%
		int pages=Integer.parseInt(pagesize);
		int length=0;
		if(sum<=7){
			//循环六次
			for(int i=1;i<=sum;i++){%>
				<a  id="page<%=i%>" href="javascript:click(<%=i%>)"><%=i%></a>
			<%}
		}else{
			if(pages<=3){
				for(int j=1;j<=7;j++){
				%>
					<a  id="page<%=j%>" href="javascript:click(<%=j%>)"><%=j%></a>
				<% }
			}else{
				if(sum<pages+3){
					for(int k=sum-6;k<pages-3;k++){
						%>
							<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
						<% 
					}
				}
				if(sum>pages+3){
					for(int k=pages-3;k<pages+4;k++){
						%>
							<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
						<% 
					}
				}else{
					for(int k=pages-3;k<sum+1;k++){
						%>
							<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
						<% 
					}
				}
			}%>
		<%} %>
		<a id="xia" href="javascript:SX(2,<%=sum%>)">下一页</a>
		<span class="p-num">共<%=sum%>页</span> 到 <input id="wenben" type="text" onkeyup="ExtFunctionCM.inputRegExp(this,'(^0$)|(^(-)?0\\.\\d{0,2}$)|(^(-)?[1-9]?[0-9]{0,12}?$)')" class="jp-ip" /> 页	
		<button type="submit" onclick="TiaoZhuan()" class="to-sub">确定</button>
		</div>
		</div>
		 </html:form>
	</div>
	
	<div class="fr w-230 std-side">

		<div class="side-user-nav mt-10">
			<h3>个人中心</h3>
			<ul class="clearfix">
				<li class="nav-1"><a href="<%=path %>/platform/qiantai/student/wodehaoyoulb.jsp">我的好友</a></li>
				<li class="nav-2"><a href="#">我的日志</a></li>
				<li class="nav-3"><a href="#">学习笔记</a></li>
				<li class="nav-4"><a href="#">消息通知</a></li>
				<li class="nav-5"><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueXiJL&_qam_dialog_state=DHZT_JinRu">学习记录</a></li>
				<li class="nav-6"><a href="<%=path %>/platform/qiantai/student/chakangerenzl.jsp">账号设置</a></li>
			</ul>
		</div>
		
		<div class="tech-std mt-20">
			<div class="side-title clearfix">
				<h3>好友列表</h3>
			</div>
           
       <!--好友列表 -->   
        <div class="goodfriends-group-gr mt-20">
			<div class="the-list">
				<ul class="clearfix">
					<%
						List<List> list=new ArrayList<List>();
						list=haoyou.getHaoYou(yonghubh,key);
						StringBuffer html=new StringBuffer();
						int size=0;
						if(list.size()>10){
							size=10;
						}else{
							size=list.size();
						}
						for(int i=0;i<size;i++){
							html.append("<li>");
							html.append("<a><img src=\""+imgUrl+list.get(i).get(1)+"\" alt=\"\" /></a>");
							html.append("<span class=\"rr\">"+list.get(i).get(0)+"</span>");
							html.append("<span class=\"fr mm\"></span>");
							html.append("</li>");
						}
					%>
				<%=html.toString() %>

				</ul>
			</div>
		</div>
		</div>
	</div>
</div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />
<script type="text/javascript" src="<%=style %>/js/page/script.js"></script>
	<script type="text/javascript">
		
		$(function(){
			//样式
			$("#page"+$("#_qam_pagenumber_DHSJZ_ChaXunJG").val()).addClass("cur");
			//给文本框赋值
			$("#wenben").val($("#_qam_pagenumber_DHSJZ_ChaXunJG").val());
		});
		
  </script>
</body>
</html>

