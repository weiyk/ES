
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<%@page import="com.rc.web.extension.component.gethaoyouxx.GetHaoYouLB" %>

<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.*" %>
<%@page import="java.text.ParseException" %>
<%@page import="com.rc.web.extension.component.getjiekouxx.GetInterfacesValue" %>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="com.rc.web.extension.component.tongxinlu.insertTongXinL"%>
<%@page import="java.util.Map,java.net.*"%>
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<!-- jquery -->
<%@include file="/common/jquery.jspf" %>
<!-- ui -->
<%@include file="/common/ui.jspf"%>
<%-- jqgrid --%>
<%@include file="/common/jqgrid.jspf"%>
 <%
	//获取样式
	String style=request.getContextPath()+"/style/";
	//获取路径
	String path=request.getContextPath();
	String YONGHUXM=(String)request.getSession().getAttribute("YONGHUXM");
	String yonghubh=(String)request.getSession().getAttribute("XiTongHYBH");
	String key=(String)request.getSession().getAttribute("QuanZhi");
	GetHaoYouLB haoyou=new GetHaoYouLB();
	String image=(String)request.getSession().getAttribute("Image");
	String imgUrl=(String)request.getSession().getAttribute("imgUrl");
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>我的好友列表</title>
	<meta name="Keywords" content=""/>
	<meta name="Description" content=""/>
	<link rel="stylesheet" href="<%=style%>/style/page/style.css" />
    <link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<style type="">
	.page-list .to-sub{height:30px;line-height:30px;border:0;background:#2cb4f3;color:#fff;width:60px;margin-left:10px;font-weight:bold;cursor:pointer;vertical-align:middle;}
	
	</style>
</head>

<%
	String schoolName=(String) session.getAttribute("schoolName");
	String yonghuxm =(String)session.getAttribute("YONGHUXM");
%>
<body>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengGRKJ" class="user-name blk"><%=YONGHUXM %></a> <%=schoolName %> <a href="<%=path%>/servlet/desktop.html" class="to-quit">退出</a></p>
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
				<h2 class="fl">我的好友
				<img onclick="addHY()" width="20px" height="20px" src="<%=path %>/style/images/add.png"></img>
				</h2>
			</div>
		</div>
		<html:form>
		<div id="dialogDiv" style="display: none;" align="center" class="page-list clearfix">
			账号&nbsp;<input class="input_item" style="width:50%;height: 22px " type="text" id="LoginId"></input>&nbsp;
			<button type="submit" style="height: 30px" onclick="addHaoYou()"  class="to-sub">确定</button>
		</div>
		</html:form>
		<script type="text/javascript">
		 	function addHY(){
		 		
		 		$('#dialogDiv').dialog({
		 				hide:true, 
		 				autoOpen:true,
		 				height:90,
		 				width:320,
		 				modal:true, 
		 				title:'添加好友'
		 				
		 		}); 
		 	}
		 	function addHaoYou(){
		 		var result="";
					var LoginId=$('#LoginId').val();
					if(!LoginId){
						alert("账号不能为空，添加失败！");
						return false;
					}
					$.ajax({
					url:path+'/servlet/AjaxServlet',
					type:"post",
					traditional:true,
					async:false,
					data:{service:"com.rc.web.ajax.AddHaoYouService",
						parameter:["loginId"],
						value:[LoginId]},
					complete:function(XHR, TS){
						result = XHR.responseText;
						if(result){
							alert("添加失败！");
							return false;
						}else{
							document.forms[0].action="<%=path %>/platform/qiantai/student/wodehaoyoulb.jsp";
							document.forms[0].submit();
						}
						XHR = null;
					}
					
				});
		 	}
		 	function deleteHaoYou(uid){
		 		$.ajax({
					url:path+'/servlet/AjaxServlet',
					type:"post",
					traditional:true,
					async:false,
					data:{service:"com.rc.web.ajax.DelHaoYouService",
						parameter:["uid"],
						value:[uid]},
					complete:function(XHR, TS){
						result = XHR.responseText;
						if(result){
							alert("删除失败！");
						}else{
							document.forms[0].action="<%=path %>/platform/qiantai/student/wodehaoyoulb.jsp";
							document.forms[0].submit();
						}
						XHR = null;
					}
					
				});
		 	}
		</script>
		<div class="table_a">
			<table width="100%" cellpadding="1" cellspacing="1" id="table" >
			<%
			List<List> listHY=new ArrayList<List>();
			listHY=haoyou.getHaoYou(yonghubh,key);
			StringBuffer tableHtml=new StringBuffer();
			if(listHY.size()==0){
				tableHtml.append("<tr></tr>");
			}
			for(int j=0;j<listHY.size();j++){
				if(j%3==0){
					tableHtml.append("<tr>");
				}
				if("2".equals(listHY.get(j).get(3))){
					tableHtml.append("<td width=\"30%\"><img width=\"50px\" src=\""+imgUrl+listHY.get(j).get(1)+"\" alt=\"\" /></br>"+listHY.get(j).get(0)+" &nbsp;&nbsp;&nbsp;"+listHY.get(j).get(2)+ "&nbsp;&nbsp;&nbsp;<img onclick=\"deleteHaoYou('"+listHY.get(j).get(3)+"')\" width=\"15px\"  src=\""+path+"/style/images/delete.png\" alt=\"\" /></td>");
				}else{
					tableHtml.append("<td width=\"30%\"><img width=\"50px\" src=\""+imgUrl+listHY.get(j).get(1)+"\" alt=\"\" /></br>"+listHY.get(j).get(0)+ "&nbsp;&nbsp;&nbsp;<img onclick=\"deleteHaoYou('"+listHY.get(j).get(3)+"')\" width=\"15px\"  src=\""+path+"/style/images/delete.png\" alt=\"\" /></td>");
				}
				if(j%3==2){
					tableHtml.append("</tr>");
				}
				if(j==listHY.size()-1&&j%3!=2){
					for(int k=0;k<3-(j+1)%3;k++){
						tableHtml.append("<td width=\"30%\"></td>");
					}
					tableHtml.append("</tr>");
				}
			}
			%>
			<%=tableHtml.toString() %>
			</table>
		</div>
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
<script type="text/javascript">
					
					
					
					</script>

</body>
</html>

