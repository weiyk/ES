<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="com.rc.web.extension.component.gethaoyouxx.GetHaoYouLB" %>
<%@page import="com.rc.web.extension.component.gerenziliao.GetGeRenZL" %>
	<%@page import="java.util.*" %>
	<%@page language="java" isELIgnored="false" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
	<%@include file="/common/framework.jspf"%>
<%
	//获取样式
	String style=request.getContextPath()+"/style";
	//获取路径
	String path=request.getContextPath();
	String YONGHUXM=(String)request.getSession().getAttribute("YONGHUXM");
	String yonghubh=(String)request.getSession().getAttribute("XiTongHYBH");
	String key=(String)request.getSession().getAttribute("QuanZhi");
	String DengLuM=(String)request.getSession().getAttribute("DengLuM");
	GetHaoYouLB haoyou=new GetHaoYouLB();
	String image=(String)request.getSession().getAttribute("Image");
	String imgUrl=(String)request.getSession().getAttribute("imgUrl");
	GetGeRenZL teacher=new GetGeRenZL();
 	Map<String,String> map=teacher.getGeRen(yonghubh,key);
 	String schoolName=(String) session.getAttribute("schoolName");
%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>个人中心-学生</title>
	<link rel="stylesheet" href="<%=style %>/style/common.css" />
	
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
	<style type="">
	</style>
</head>

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
                <div class="km-tab-bar clearfix mt-10">
					<ul class="fl">
                        <li class="cur" id="jb"><a href="#" onclick="jibenxx()">基本信息</a></li>
                        <li id="tx"><a href="#" onclick="touxiang()">头像信息</a></li>
                     <!--    <li><a href="index.php?m=member&c=password&a=edit">密码设置</a></li>--> 
                    </ul>
                </div>
                <div id="jbxx">
                <form action="" class="z_form_notice mt_lgr" id="J_form" method="post">
                    <div class="field_item">
                        <label>账户：</label>
                        <label class="w_auto"><%=DengLuM %></label>
                    </div>
                    <div class="field_item">
                        <label>真实姓名：</label>
                        <label class="w_auto"><%=YONGHUXM %> </label>
                    </div>
                   
                    <div class="field_item">
                        <label>常用邮箱：</label>
                        <label class="w_auto"><%=map.get("email")%></label>
                    </div>
                    <div class="field_item">
                        <label>手机号：</label>
                        <label class="w_auto"><%=map.get("mobile")%></label>
                    </div>
                    <div class="field_item">
                        <label>性别：</label>
                        <%
                        String sex=map.get("sex");
                        if("1".equals(sex)){
                        	%>
                        	<label for="woman"  style="text-align: left" class="radio_item">女</label>
                        	<%
                        }else{ %>
                        	<label for="man" style="text-align: left" class="radio_item">男</label>
                        <%} %>
                     </div>
                    <div class="field_item">
                        <label>出生日期：</label>
                        <label><%=map.get("birthday")%></label>
                    </div>
                    <div class="field_item">
                        <label>所在地区：</label>
                        <html:select style="display:none;" id="J_province" onchange="changgeProvince()"  enumSQL="select region_name,region_id from pt_region where region_type='1'" name="province" initText="请选择"></html:select>
                        <html:select style="display:none;" id="J_city" onchange="changgeCity()"  name="province" initText="请选择"></html:select>
                         <html:select style="display:none;" id="J_town"  name="province" initText="请选择"></html:select>
                         <label id="lab_province" class="w_auto"></label>
                         <label id="lab_city" class="w_auto"></label>
                         <label id="lab_town" class="w_auto"></label>
                        <script type="text/javascript">
                        $().ready(function(){
                        	var pro='<%=map.get("province")%>';
                        	if(pro){
                        		$('#J_province').val(pro);
                        		var result="";
								var condition =" where parent_id='"+$('#J_province').val()+"'";
								$.ajax({
									url:'<%=path%>/servlet/AjaxServlet',
									type:"post",
									traditional:true,
									async:false,
									data:{service:"com.rc.web.extension.ajax.GetOptionsService",
										parameter:["tableName","textField","valueField","condition","initText","dataSource","seletcedValue"],
										value:["pt_region","region_name","region_id",condition,"请选择","",""]},
									complete:function(XHR, TS){
										result = XHR.responseText;
										if('_qam_ajax_error'==result){
											$(this)._alert('\u63d0\u793a','ajax\u8c03\u7528\u5f02\u5e38');
											throw new Error("ajax\u8c03\u7528\u5f02\u5e38");
										}
										XHR = null;
									}
								});
								$('#J_city').html(result);
								$('#J_city').val('<%=map.get("city")%>');
								$("#lab_province").append($("#J_province").find("option:selected").text());
								$("#lab_city").append($("#J_city").find("option:selected").text());
								result="";
								condition =" where parent_id='"+$('#J_city').val()+"'";
								$.ajax({
									url:'<%=path%>/servlet/AjaxServlet',
									type:"post",
									traditional:true,
									async:false,
									data:{service:"com.rc.web.extension.ajax.GetOptionsService",
										parameter:["tableName","textField","valueField","condition","initText","dataSource","seletcedValue"],
										value:["pt_region","region_name","region_id",condition,"请选择","",""]},
									complete:function(XHR, TS){
										result = XHR.responseText;
										if('_qam_ajax_error'==result){
											$(this)._alert('\u63d0\u793a','ajax\u8c03\u7528\u5f02\u5e38');
											throw new Error("ajax\u8c03\u7528\u5f02\u5e38");
										}
										XHR = null;
									}
								});
								$('#J_town').html(result);
								$('#J_town').val('<%=map.get("town")%>');
								$("#lab_town").append($("#J_town").find("option:selected").text());
                        	}
                        })
							function changgeProvince(){
								var result="";
								var condition =" where parent_id='"+$('#J_province').val()+"'";
								$.ajax({
									url:'<%=path%>/servlet/AjaxServlet',
									type:"post",
									traditional:true,
									async:false,
									data:{service:"com.rc.web.extension.ajax.GetOptionsService",
										parameter:["tableName","textField","valueField","condition","initText","dataSource","seletcedValue"],
										value:["pt_region","region_name","region_id",condition,"请选择","",""]},
									complete:function(XHR, TS){
										result = XHR.responseText;
										if('_qam_ajax_error'==result){
											$(this)._alert('\u63d0\u793a','ajax\u8c03\u7528\u5f02\u5e38');
											throw new Error("ajax\u8c03\u7528\u5f02\u5e38");
										}
										XHR = null;
									}
								});
								$('#J_city').html(result);
								$('#J_town').html('<option value="">请选择</option>');
							}
							function changgeCity(){
								var result="";
								var condition =" where parent_id='"+$('#J_city').val()+"'";
								$.ajax({
									url:'<%=path%>/servlet/AjaxServlet',
									type:"post",
									traditional:true,
									async:false,
									data:{service:"com.rc.web.extension.ajax.GetOptionsService",
										parameter:["tableName","textField","valueField","condition","initText","dataSource","seletcedValue"],
										value:["pt_region","region_name","region_id",condition,"请选择","",""]},
									complete:function(XHR, TS){
										result = XHR.responseText;
										if('_qam_ajax_error'==result){
											$(this)._alert('\u63d0\u793a','ajax\u8c03\u7528\u5f02\u5e38');
											throw new Error("ajax\u8c03\u7528\u5f02\u5e38");
										}
										XHR = null;
									}
								});
								$('#J_town').html(result);
							}
						</script>
                        <!--<a href="" class="blue_link btn_item">设置地区</a>-->
                    </div>
                    <div class="field_item">
                        	<label>个人简介：</label>
                        	<div style="float: right; width: 570px; padding-right: 30px;">
                        水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛
                        水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛
                        水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛
                        水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛
                        水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛水电费水电费水电费水电费文热吻大赛
                        	</div>
                        <%-- <div>
                        	<%=map.get("descn")!="null"?map.get("descn"):""%>
                        </div> --%>
                    </div>
                    <div class="field_item">
                       <!--  <input type="submit" class="btn btn_blue btn_size_lg" value="保 存"/>-->
                    </div>
                <input type="hidden" name="__hash__" value="5749ff25862f8e82" /></form>
                </div>
                <div id="txxx" style="display: none">
                	<img src="<%=imgUrl+map.get("image") %>" alt="" />
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
<script>
   

    $('#J_birthday').on('click',function(){
        WdatePicker({
            'dateFmt':'yyyy-MM-dd'
        });
    })

   
    function jibenxx(){
    	$('#jbxx').show();
    	$('#txxx').hide();
    	$("#jb").addClass("cur");
    	$("#tx").removeClass();
    }
    function touxiang(){
    	$('#jbxx').hide();
    	$('#txxx').show();
    	$("#tx").addClass("cur");
    	$("#jb").removeClass();
    }
</script>

</body>
</html>

