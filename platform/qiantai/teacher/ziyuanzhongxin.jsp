<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@page import="com.rc.web.extension.component.resource.ResourceHelper" %>
<%@page import="java.util.*"%>
<%
	//获取样式
	String style = request.getContextPath()
			+ "/platform/qiantai/teacher";
	//获取资源样式
	String resource_style = request.getContextPath()
			+ "/platform/qiantai/teacher/style/resource";
	//获取路径
	String path = request.getContextPath() + "/servlet";
	//获取用户姓名
	String YONGHUXM = (String) request.getSession().getAttribute(
			"YONGHUXM");
	//获取学校名字
	String schoolName = (String) session.getAttribute("schoolName");
	//获取资源分类
	ResourceHelper rshelp=new ResourceHelper();
	List<List<String>> list=rshelp.getType();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>资源中心</title>
<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
<link href="<%=resource_style%>/common.css" rel="stylesheet"
	type="text/css" />
<link href="<%=resource_style%>/resource.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=style%>/js/base.js"></script>
<script type="text/javascript" src="<%=style%>/js/sea.js"></script>
<script type="text/javascript">
$().ready(function(){
	/* 滑动/展开 */
    $(".submenu ul li>.subheader-label").click(function(){
        $(this).parent().find(".menu-two").slideToggle();
        // 隐藏其他的列表
        $(this).parent().nextAll().find(".menu-two").slideUp();
        $(this).parent().prevAll().find(".menu-two").slideUp();
    });
});
 //tab页切换
 $(function(){
     $('.res-right-tab ul li').click(function(){
         $(this).addClass('tab-click').siblings().removeClass('tab-click');
         $('.res-tab-content>div:eq('+$(this).index()+')').show().siblings().hide();
     });
 });

 $(function(){
     $('.res-right-tab-two ul li').click(function(){
         $(this).addClass('tab-click').siblings().removeClass('tab-click');
         $('.res-tab-content-two>div:eq('+$(this).index()+')').show().siblings().hide();
     });
 });
 //刷新iframe资源列表
 function doshowresource(str){
 	var showrs_url="<%=request.getContextPath()%>/platform/qiantai/teacher/resource/showresource.jsp?type="+str;
 	$("#iframe").attr("src",showrs_url);
 }
</script>
</head>

<body>
	<div class="top-u-bar">
		<div class="wrap">
			<p>
				欢迎你！ <a href="gerenzhongxin.htm" class="user-name blk"><%=YONGHUXM%></a><%=schoolName%><a
					href="<%=path%>/desktop.html" class="to-quit">退出</a>
			</p>
		</div>
	</div>
	<!-- 头部 开始-->
	<jsp:include page="/platform/qiantai/teacher/resource/header.jsp" />
	<!-- 头部结束 -->

	<div class="wrap clearfix">
		<div class="wrap clearfix" style="height:auto;">
		<div class="res-content">
			<div class="layout">
				<!--二级导航开始-->
				<div class="subnav">
					<ul>
						<li><a href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanZX"
							class="subnav-click">资源检索</a>
						</li>
						<li><a
							href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanSC">资源收藏</a>
						</li>
						<li><a 
							href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanUpload">资源上传</a>
						</li>
						<li><a
							href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanFX">资源分享</a>
						</li>
						<li><a
							href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanXZ">资源下载</a>
						</li>
						<li><a
							href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanDY">资源订阅</a>
						</li>

					</ul>
				</div>
				<!--二级导航结束--->
				<!--搜索框开始-->
				<div class="res-search fl">
					<div class="search-left fl">
						<form action="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanSS" method="post"> 
							<input name="keyword" placeholder="请输入关键词" value="请输入关键词" onfocus="javascript:if(this.value=='请输入关键词'){this.value='';this.style.color='#666'}" onblur="javascript:if(this.value==''){this.value='请输入关键词';this.style.color='#999'}" class="search-text" type="text"/> 
							<input class="search-button" value="资源搜索" type="submit"/> 
						</form>
					</div>
					<div class="search-right fl">
						<p>检索不方便？ 试试资源搜索</p>
					</div>
				</div>
				<!--搜索框结束-->
				<div class="clear"></div>

				<!--内容1开始-->
				<div class="res-title">
					<span class="tite-icon"></span>资源中心
				</div>
				<div class="clear"></div>
				<div class="submenu">
					<ul>
						<li>
						<span class="subheader-label"><a href="#" >小学资源</a></span>
							<ul class="menu-two" >
								<%for(int i=0;i<list.get(0).size();i++ ){ String[] type=list.get(0).get(i).split("&");%>
								<li><a onclick="doshowresource('<%=type[0] %>')"><%=type[1] %> </a></li>
								<%} %>
							</ul>
						</li>
						<li>
						<span class="subheader-label"><a href="#" >初中资源</a></span>
							<ul class="menu-two"  style="display: none;">
								<%for(int i=0;i<list.get(1).size();i++ ){ String[] type=list.get(1).get(i).split("&");%>
								<li><a onclick="doshowresource('<%=type[0] %>')"><%=type[1] %> </a></li>
								<%} %>
							</ul>
						</li>
						<li>
						<span class="subheader-label"><a href="#" >高中资源</a></span>
							<ul class="menu-two"  style="display: none;">
								<%for(int i=0;i<list.get(2).size();i++ ){ String[] type=list.get(2).get(i).split("&");%>
								<li><a onclick="doshowresource('<%=type[0] %>')"><%=type[1] %> </a></li>
								<%} %>
							</ul>
						</li>
					</ul>
				</div>

				<div class="res-middle fl">
					<div class="res-middle-title">资源展示</div>
					<iframe src="<%=request.getContextPath()%>/platform/qiantai/teacher/resource/showresource.jsp?type=40992768" id="iframe" width="560" marginheight="1" height="450" name="iframe"  frameborder="0" scrolling="no" ></iframe>
				</div>

				<div class="res-right fl">
					<div class="res-right-title">
						<span class="icon-medal"></span>资源排行榜
					</div>
					<div class="res-right-tab">
						<ul>
							<li class="tab-click">下载</li>
							<li>推荐</li>
						</ul>
					</div>
					<div class="res-tab-content">
						<div class="pane" style="display:block;">
							<ul>
								<% 
								List<String> dl_list =rshelp.getRankRes("download");
								if(dl_list.size()>0){
									for(int i=0;i<dl_list.size();i++ ){ String[] rank=dl_list.get(i).split("&");
								 %>
								 		<%if(i==0){ %>
										<li>
											<span class="icon-numone">1</span>
											<a title="<%=rank[1] %>" target="_blank" href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=rank[0] %>"><%=rank[1] %></a>
										</li>
										<%} %>
										<%if(i==1){ %>
										<li>
											<span class="icon-numtwo">2</span>
											<a title="<%=rank[1] %>" target="_blank" href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=rank[0] %>"><%=rank[1] %></a>
										</li>
										<%} %>
										<%if(i==2){ %>
										<li>
											<span class="icon-numthree">3</span>
											<a title="<%=rank[1] %>" target="_blank" href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=rank[0] %>"><%=rank[1] %></a>
										</li>
										<%} %>
										<%if(i>=3){ %>
										<li>
											<span class="icon-text"><%=i+1 %></span>
											<a title="<%=rank[1] %>" target="_blank" href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=rank[0] %>"><%=rank[1] %></a>
										</li>
										<%} %>
								<%}}%>
							</ul>
						</div>

						<div class="pane">
							<ul>
								<% 
								List<String> like_list =rshelp.getRankRes("like");
								if(like_list.size()>0){
									for(int i=0;i<like_list.size();i++ ){ String[] like=like_list.get(i).split("&");
								 %>
								 		<%if(i==0){ %>
										<li>
											<span class="icon-numone">1</span>
											<a title="<%=like[1] %>" target="_blank" href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=like[0] %>"><%=like[1] %></a>
										</li>
										<%} %>
										<%if(i==1){ %>
										<li>
											<span class="icon-numtwo">2</span>
											<a title="<%=like[1] %>" target="_blank" href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=like[0] %>"><%=like[1] %></a>
										</li>
										<%} %>
										<%if(i==2){ %>
										<li>
											<span class="icon-numthree">3</span>
											<a title="<%=like[1] %>" target="_blank" href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=like[0] %>"><%=like[1] %></a>
										</li>
										<%} %>
										<%if(i>=3){ %>
										<li>
											<span class="icon-text"><%=i+1 %></span>
											<a title="<%=like[1] %>" target="_blank" href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=like[0] %>"><%=like[1] %></a>
										</li>
										<%} %>
								<%}}%>
							</ul>
						</div>
					</div>
				</div>

				<!--内容1结束-->
				
				<div class="clear"></div>

			</div>

		</div>
	</div>
</div> 
	<!-- 页尾 -->
	<jsp:include page="/bottomPage.jsp" />

	<!-- 弹出层 -->
	<div class="pop-box hidden">
		<div class="cover"></div>
		<div class="pop-content">
			<div class="title clearfix">
				<h2>上传资源</h2>
				<span class="to-close"></span>
			</div>
			<div class="box-c">
				<div class="upld-form">
					<div class="one-cell clearfix">
						<label>类别</label>
						<div class="radio-box">
							<input type="hidden" id="" class="the-val" value="val1" /> <span
								class="one-rd rd-checked" rel="val1">教学资源</span> <span
								class="one-rd" rel="val2">学习资源</span>
						</div>
					</div>
					<div class="one-cell clearfix">
						<label>&nbsp;</label>
						<div class="select-box select-box-bl fl">
							<input type="hidden" value="" class="the-val" />
							<div class="select-cover">
								<span class="df-val">一年级</span> <em class="icon"></em>
							</div>
							<ul class="clearfix hidden">
								<li><a href="javascript:;" rel="nj-1">一年级</a>
								</li>
								<li><a href="javascript:;" rel="nj-2">二年级</a>
								</li>
								<li><a href="javascript:;" rel="nj-3">三年级</a>
								</li>
								<li><a href="javascript:;" rel="nj-4">四年级</a>
								</li>
								<li><a href="javascript:;" rel="nj-5">五年级</a>
								</li>
								<li><a href="javascript:;" rel="nj-6">六年级</a>
								</li>
							</ul>
						</div>
					</div>

					<div class="one-cell clearfix">
						<label>年纪</label>
						<div class="select-box select-box-bl fl">
							<input type="hidden" value="" class="the-val" />
							<div class="select-cover">
								<span class="df-val">一年级</span> <em class="icon"></em>
							</div>
							<ul class="clearfix hidden">
								<li><a href="javascript:;" rel="nj-1">一年级</a>
								</li>
								<li><a href="javascript:;" rel="nj-2">二年级</a>
								</li>
								<li><a href="javascript:;" rel="nj-3">三年级</a>
								</li>
								<li><a href="javascript:;" rel="nj-4">四年级</a>
								</li>
								<li><a href="javascript:;" rel="nj-5">五年级</a>
								</li>
								<li><a href="javascript:;" rel="nj-6">六年级</a>
								</li>
							</ul>
						</div>
					</div>

					<div class="one-cell clearfix">
						<label>科目</label>
						<div class="radio-box">
							<input type="hidden" class="the-val" value="val1" id="" /> <span
								class="one-rd rd-checked" rel="val1">语文</span> <span
								class="one-rd" rel="val1">数学</span> <span class="one-rd"
								rel="val1">英语</span> <span class="one-rd" rel="val1">科学</span>
						</div>
					</div>
					<div class="one-cell clearfix">
						<label>版本</label>
						<div class="radio-box">
							<input type="hidden" class="the-val" value="val1" id="" /> <span
								class="one-rd rd-checked" rel="val1">人教版</span> <span
								class="one-rd" rel="val1">华师版</span> <span class="one-rd"
								rel="val1">英语</span> <span class="one-rd" rel="val1">科学</span>
						</div>
					</div>
					<div class="one-cell clearfix">
						<label>章节</label>
						<div class="select-box select-box-bl fl">
							<input type="hidden" value="" class="the-val" />
							<div class="select-cover">
								<span class="df-val">第一章 章节名称</span> <em class="icon"></em>
							</div>
							<ul class="clearfix hidden">
								<li><a href="javascript:;" rel="nj-1">一年级</a>
								</li>
								<li><a href="javascript:;" rel="nj-2">二年级</a>
								</li>
								<li><a href="javascript:;" rel="nj-3">三年级</a>
								</li>
								<li><a href="javascript:;" rel="nj-4">四年级</a>
								</li>
								<li><a href="javascript:;" rel="nj-5">五年级</a>
								</li>
								<li><a href="javascript:;" rel="nj-6">六年级</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="one-cell clearfix">
						<label>类型</label>
						<div class="radio-box">
							<input type="hidden" class="the-val" value="val1" id="" /> <span
								class="one-rd rd-checked" rel="val1">视频</span> <span
								class="one-rd" rel="val1">音频</span> <span class="one-rd"
								rel="val1">英语</span> <span class="one-rd" rel="val1">科学</span>
						</div>
					</div>
					<div class="one-cell clearfix">
						<label>标题</label> <input type="text" class="txt-ip" id="" />
					</div>
					<div class="one-cell clearfix">
						<label>摘要</label>
						<textarea></textarea>
					</div>

					<div class="one-cell clearfix">
						<label>上传</label>
						<div class="upfile">
							<script type="text/javascript">
								$(function() {
									$(".upload-file .btn-file").click(
											function() {
												return $(this).parent().find(
														".uf-ip").click();
											});
									$(".upload-file .uf-ip").change(
											function() {
												$(".upload-file .uf-txt").text(
														$(this).val());
											});

								});
							</script>
							<div class="upload-file clearfix">
								<input type="file" class="uf-ip" id="" value="" size="28" /> <a
									href="javascript:;" class="btn-cs btn-file fl">浏览</a> <span
									class="uf-txt fl">为选择文件</span>
							</div>
							<p>支持mp4、avi、flv、wma、mov等格式的视频文件上传，文件大小不超过1GB。</p>
							<p>支持断点续传（仅支持html5浏览器）</p>
							<p>
								视频将上传到云视频服务器，上传后会对视频进行格式转换，视频将上传到 <br />云视频服务器，上传后会对视频进行格式转换，
							</p>
						</div>
					</div>
				</div>

			</div>
			<div class="box-act">
				<a href="#" class="to-close">取消</a>
				<button type="submit">上传</button>
			</div>
		</div>
	</div>
</body>
</html>
