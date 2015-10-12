<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@page import="com.rc.web.extension.component.gerenziliao.GetGeRenZL" %>
<%@page import="java.util.*" %>
<%@include file="/common/framework.jspf"%>
<%@include file="/common/jquery.jspf" %>
<head>
 <%
 	//获取样式
 	String style=request.getContextPath()+"/platform/qiantai/teacher";
 	//获取路径
 	String path=request.getContextPath();
 	String YONGHUXM=(String)request.getSession().getAttribute("YONGHUXM");
 	String DengLuM=(String)request.getSession().getAttribute("DengLuM");
 	String yonghubh=(String)request.getSession().getAttribute("XiTongHYBH");
 	String key=(String)request.getSession().getAttribute("QuanZhi");
 	String schoolName=(String) session.getAttribute("schoolName");//学校名字
 	GetGeRenZL teacher=new GetGeRenZL();
 	Map<String,String> map=teacher.getGeRen(yonghubh,key);
 	String email =map.get("email")==null?"无":map.get("email");
 	String mobile =map.get("mobile")==null?"无":map.get("mobile");
 	String birthday =map.get("birthday")==null?"无":map.get("birthday");
 	String descn =map.get("descn")==""?"无":map.get("descn");
 	
 	String imgUrl=(String)request.getSession().getAttribute("imgUrl");
 %>
<title>教师个人资料</title>
<meta name="author" content="yldigit.com" />
<meta name="generator" content="yunli" />
<meta name="copyright" content="yunli Inc. All Rights Reserved" />
<link rel="stylesheet" href="<%=style %>/style/common.css" />
<link rel="stylesheet" href="<%=style %>/style/backstage.css" />
<style type="">
.wrap{width:950px;margin:0 auto;}
.clearfix { *zoom: 1; } 
.clearfix:before, .clearfix:after { display: table; line-height: 0;  content: ""; }
.clearfix:after{clear: both} 
.fl{float:left}
.fr{float:right;}

.top-u-bar{background:#f8f8f8;}
.top-u-bar p{text-align:right;height:40px;line-height:40px;color:#888}
.top-u-bar p .user-name{margin:0 6px;}
.top-u-bar p .to-quit{color:#ff6000;margin-left:10px;}
.top-u-bar p .to-quit:hover{text-decoration:underline;}


/*-- 头部 --*/
.header{height:90px;background:#fff;border-bottom:solid 1px #ededed;padding: 0px;}
.header .logo{width:300px;height:90px;background:url(images/logo.png) center no-repeat;overflow:hidden;text-indent:-444em;}
.green-head .logo{background-image:url(images/logo-green.png);}
.header .nav li{float:left;font:16px "微软雅黑";height:90px;padding: 0px;}
.header .nav li a{display:block;padding:0 20px;line-height:90px;float:left;color:#4a4a4a;}
.header .nav li a:hover{background:#f8f8f8}
.header .nav li a.cur,.header .nav li a.cur:hover{background:#2cb4f3;color:#fff;}
.copyright{color:#999; background:#333;font-size:12px;}
</style>

<script type="text/javascript">
	var SITE_URL = "www.kcyun.net";
	var UEDITOR_HOME_URL = "/statics/web/js/dev/plugs/ueditor/";
</script></head>
<body>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=YONGHUXM %></a><%=schoolName %><a href="<%=path%>/servlet/desktop.html" class="to-quit">退出</a></p>

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
    <div class="ktxx_index">
        <div class="layout pt_lgr clear">
            <div class="popcenter_left fl mr_n">
            <div class="popcenter_left fl mr_n">
            <div class="popcenter_posted" >
            	<div align="center">
                <img class="pic" src="<%=imgUrl+map.get("image") %>" alt="<%=YONGHUXM %> " style="height: 150px;width: 150px;"/>
                <p class="txt clear">
                    	用户名：<%=YONGHUXM %>                </p>
                </div>
                
                                <div class="popcenter_nav mt_n mb_lgr">
                    <a href="<%=path %>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" ><em class="log_icons"></em>个人中心首页 </a>
                    <a href="#" ><em class="log_icons"></em>教研日志</a>
                    <!--<a href="index.php?m=member&c=home&a=album" ><em class="photo_icons"></em>活动相册</a>-->
                    <a href="#" ><em class="message_icons"></em>消息中心</a>
                    <a href="#" ><em class="message_icons"></em>研修轨迹 </a>
					<a href="#" ><em class="log_icons"></em>老师档案 </a>
                    <a href="<%=path %>/platform/qiantai/teacher/chakangerenzl.jsp" class="cur"><em class="account_icons"></em>账号设置</a>
                </div>   
            </div>
        </div>            </div>
                        <div class="fluid">
                <div class="z_popcenter_tabtit">
                    <ul class="clear">
                        <li class="cur" id="jb"><a href="#" onclick="jibenxx()">基本信息</a></li>
                        <li id="tx"><a href="#" onclick="touxiang()">头像信息</a></li>
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
                         <label class="w_auto"><%=email%> </label>
                    </div>
                    <div class="field_item">
                        <label>手机号：</label>
                        <label class="w_auto" ><%=mobile%> </label>
                    </div>
                    <div class="field_item">
                        <label>性别：</label>
                        <%
                        String sex=map.get("mobile");
                        if("1".equals(sex)){
                        	%>
                        	<label  class="w_auto">女</label>
                        	<%
                        }else{ %>
                        	<label  class="w_auto">男</label>
                        <%} %>
                     </div>
                    <div class="field_item">
                        <label>出生日期：</label>
                        <label class="w_auto"><%=birthday%> </label>
                    </div>
                    <div class="field_item">
                        <label>所在地区:</label>
                        <html:select id="J_province" onchange="changgeProvince()" style="display:none" enumSQL="select region_name,region_id from pt_region where region_type='1'" name="province" initText="请选择"></html:select>
                        <html:select id="J_city" onchange="changgeCity()"  name="province" initText="请选择" style="display:none"></html:select>
                         <html:select id="J_town"  name="province" style="display:none" initText="请选择"></html:select>
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
                    </div>
                    <div class="field_item">
                        <label>个人简介：</label>
                        <label class="w_auto" ><%=descn%> </label>
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
        </div>
    </div>
</div>
<!--引用js-->
<script type="text/javascript" src="/statics/web/js/dev/lib/jquery.js"></script>

<script type="text/javascript">
  
   

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
<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />
</body>
</html>