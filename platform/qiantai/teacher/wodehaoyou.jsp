<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="com.rc.web.extension.component.gethaoyouxx.GetHaoYouLB" %>
<%@page import="java.util.*" %>
 <%
	//获取样式
	String style=request.getContextPath()+"/style/";
	//获取路径
	String path=request.getContextPath();
	String YONGHUXM=(String)request.getSession().getAttribute("YONGHUXM");
	String yonghubh=(String)request.getSession().getAttribute("XiTongHYBH");
	//获取学校名字
	 String schoolName=(String) session.getAttribute("schoolName");
	String key=(String)request.getSession().getAttribute("QuanZhi");
	GetHaoYouLB haoyou=new GetHaoYouLB();
	String image=(String)request.getSession().getAttribute("Image");
	String imgUrl="http://118.26.134.24";
%>
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<!-- jquery -->
<%@include file="/common/jquery.jspf" %>
<!-- ui -->
<%@include file="/common/ui.jspf"%>
<%-- jqgrid --%>
<%@include file="/common/jqgrid.jspf"%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>我的好友</title>
	<link rel="stylesheet" href="<%=style%>/style/page/style.css" />
    <link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<style type="">
	.page-list .to-sub{height:30px;line-height:30px;border:0;background:#2cb4f3;color:#fff;width:60px;margin-left:10px;font-weight:bold;cursor:pointer;vertical-align:middle;}
	
	</style>
</head>

<body>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=YONGHUXM %></a><%=schoolName %> <a href="<%=path%>/servlet/desktop.html" class="to-quit">退出</a></p>
	</div>
</div>
<!-- 头部 -->
<div class="header">
	<div class="in-box wrap clearfix">
		<div class="logo fl">
			<a href="#">双轨数字学校</a>
		</div>
		<ul class="nav fr">
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueKJ" class="cur">首页</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueZB">教学准备</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoShiFZ">教师发展</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_YingYongZX">应用中心</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueGZS">教师工作室</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanZX">资源中心</a></li>
		</ul>
	</div>
</div>
<div class="wrap clearfix">
	<div class="fl mt-20 w-710">
	<div class="user-c-form">
			<div class="title-bar green-title clearfix">
				<h2 class="fl">我的好友<img onclick="addHY()" width="20px" height="20px" src="<%=path %>/style/images/add.png"></img></h2>
			</div>
		</div>
		<div id="dialogDiv" style="display: none;" align="center" class="page-list clearfix">
			账号&nbsp;<input class="input_item" style="width:50%;height: 22px " type="text" id="LoginId"></input>&nbsp;
			<button type="submit" style="height: 30px" onclick="addHaoYou()"  class="to-sub">确定</button>
		</div>
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
						document.forms[0].action="<%=path %>/platform/qiantai/teacher/wodehaoyou.jsp";
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
							document.forms[0].action="<%=path %>/platform/qiantai/teacher/wodehaoyou.jsp";
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
			List<List> list=new ArrayList<List>();
			list=haoyou.getHaoYou(yonghubh,key);
			StringBuffer tableHtml=new StringBuffer();
			if(list.size()==0){
				tableHtml.append("<tr></tr>");
			}
			for(int j=0;j<list.size();j++){
				if(j%3==0){
					tableHtml.append("<tr>");
				}
				if("2".equals(list.get(j).get(3))){
					tableHtml.append("<td width=\"30%\"><img width=\"50px\" src=\""+imgUrl+list.get(j).get(1)+"\" alt=\"\" /></br>"+list.get(j).get(0)+" &nbsp;&nbsp;&nbsp;"+list.get(j).get(2)+ "&nbsp;&nbsp;&nbsp;<img onclick=\"deleteHaoYou('"+list.get(j).get(3)+"')\" width=\"15px\"  src=\""+path+"/style/images/delete.png\" alt=\"\" /></td>");
				}else{
					tableHtml.append("<td width=\"30%\"><img width=\"50px\" src=\""+imgUrl+list.get(j).get(1)+"\" alt=\"\" /></br>"+list.get(j).get(0)+ "&nbsp;&nbsp;&nbsp;<img onclick=\"deleteHaoYou('"+list.get(j).get(3)+"')\" width=\"15px\"  src=\""+path+"/style/images/delete.png\" alt=\"\" /></td>");
				}
				
				if(j%3==2){
					tableHtml.append("</tr>");
				}
				if(j==list.size()-1&&j%3!=2){
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
	<div class="fr w-230">
    	  <!-- 个人简介 -->
          	<div class="tech-user mt-20">
			<div class="pic"><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ"><img src="<%=imgUrl+image%>" alt="" /></a></div>
			<div class="name mt-10"><%=YONGHUXM %></div>
			<div class="sc-info"><%=schoolName %></div>
			<div class="user-num clearfix">
				<div class="fd-num fl">
					<a href="#" class="blk">语文</a> <br />
					任教学科
				</div>
				<div class="std-num fl">
					<a href="#" class="blk">二年级</a> <br />
					任教年级
				</div>
			</div>
            <html:form>
            <div class="tech-btn-mc">
                <span "tech-span-one"><input type="button" value="查看个人资料" class="yx-btn" onclick="chakangrzl()"/></span>
                <span "tech-span-two"><input type="button" value="我的好友" class="yx-btn" onclick="wodehaoyou()" /></span>
                
            </div>
            </html:form>
		</div>
		<script type="text/javascript">
				function wodehaoyou(){
					document.forms[0].action="<%=path %>/platform/qiantai/teacher/wodehaoyou.jsp";
					document.forms[0].submit();
				}
				function chakangrzl(){
					document.forms[0].action="<%=path %>/platform/qiantai/teacher/chakangerenzl.jsp";
					document.forms[0].submit();
				}
		</script>
		

       <div class="tech-std mt-20">
			<div class="kc-ss">
				<h3>好友列表</h3>
			</div>
       <!--好友列表 -->   
        <div class="goodfriends-group-gr mt-20">
			<div class="the-list">
				<ul class="clearfix">
					<%
						
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

</body>
</html>