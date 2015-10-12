<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.List"%>
<%@page import="com.qam.framework.util.CommonUtils"%>
<%@page
	import="com.rc.web.extension.component.mingshigongzuoshi.MingShi"%>
<%@page
	import="com.rc.web.extension.component.mingshigongzuoshi.TypeModel"%>
<%@page
	import="com.rc.web.extension.component.mingshigongzuoshi.MingshiModel"%>
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="qamer-html" prefix="html"%>
<%
	//获取样式
String style=request.getContextPath()+"/platform/qiantai/shouye";
//获取路径
String path=request.getContextPath()+ "/servlet";
int sum=0;//总页数
int count=1;//获取总条数
%>
<html>
<head>
<title>名师工作室</title>
<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>

</head>

<body>
	<!-- 头部 -->
	<div class="header">
		<div class="in-box wrap clearfix">
			<div class="logo fl">
				<a href="#">双轨数字学校</a>
			</div>
			<ul class="nav fr">
				<li><a href="<%=path%>/desktop.html">首页</a></li>
				<li><a
					href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_XueXiLHT">学习联合体</a></li>
				<li><a
					href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YouXiuKT">优秀课堂</a></li>
				<li><a
					href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_MingShiGZS"
					class="cur">名师工作室</a></li>
				<li><a
					href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_TongZhiGG">通知公告</a></li>
			</ul>
		</div>
	</div>
<html:form>
	<div class="wrap clearfix">
		<!-- 我的教学 -->
		<div class="zy-box mt-30">
			<ul class="zy-top-act clearfix">

			</ul>

			<div class="clearfix mt-20">
				<div class="fl w-230">
					<%
									String pagess = request.getParameter("currentPage");
									MingShi ms = new MingShi();
									if(null != pagess)
									{
										ms.getMingShiIndex(null, pagess);
									}
									else
									{
										ms.getMingShiIndex(null, "0");
									}
									List<TypeModel> typeList = ms.getTypeList();
					%>
					<div class="fl w-230">
						<div class="jc-tree">
							<div class="the-top clearfix">
								<h3>学科</h3>
							</div>
							<div class="one-tree curtree">
								<div class="list">
									<%
										for (TypeModel s : typeList) {
									%>
									<h5>
										<s></s><span class="yxsq-ks"><a href="<%=s.getUrl()%>"><%=s.getName()%></a></span>
									</h5>
									<%
										}
									%>

								</div>
							</div>
						</div>
					</div>

				</div>

				<!-- 高中数学 -->
				<div class="fr w-710">
					<!-- 高中数学 -->
					<div class="my-jx">
						<div class="title-bar clearfix">
							<h2>工作室</h2>
						</div>
					</div>
					<div class="tab-content clearfix">
						<div class="jx-list one-tabc clearfix mt-10">
							<%
								List<MingshiModel> studios = ms.getStudios();
													for (MingshiModel simInfo : studios) {
							%>
							<div class="yxsp-gzsx-yq">
								<div class="yxsp-gzsx-mp">
									<div class="yxsp-jstx">
										<a href="<%=simInfo.getUrl()%>"><img
											src="http://www.kcyun.net/dz/data/attachment/group/<%=simInfo.getImage()%>" /></a>
									</div>
									<div class="mt-10 pl-105">
										<div>
											<label class="yxsp-gzs"><a
												href="<%=simInfo.getUrl()%>"><%=simInfo.getName()%></a></label>
										</div>
									</div>
								</div>
								<div class="yxsp-gzsx-jj" style="height:54px;width:209px;padding:10px;overflow: hidden"><%=simInfo.getDesc()%></div>
							</div>
							<%
								}
							%>
						</div>
					</div>

					<!-- 翻页 -->
					<!--翻页插件-->
					<div class="clear"></div>
						<div class="page-list clearfix" align="center">
							<%
								count = Integer.parseInt(ms.getTotal());
								if(count%10==0){
									sum=(int)count/10;
								}else{
									sum=((int)count/10)+1;
								}
								request.setAttribute("sum",sum);//保存至内置对象
								String currentPage = request.getParameter("currentPage");
								if(CommonUtils.null2Blank(currentPage).length() == 0){
									currentPage = "1";
								}
								int pages=Integer.parseInt(ms.getPages());
							%>
							<a id="shang" href="javascript:SX(1,<%=sum%>)">上一页</a>
							<%
								int length=0;
																	if(sum<=7){
																//循环六次
																for(int i=1;i<=sum;i++){
							%>
							<a id="page<%=i%>" href="javascript:click(<%=i%>)"><%=i%></a>
							<%
								}
																	}else{
																if(pages<=3){
																	for(int j=1;j<=7;j++){
							%>
							<a id="page<%=j%>" href="javascript:click(<%=j%>)"><%=j%></a>
							<%
								}
																}else{
																	if(sum<pages+3){
																		for(int k=sum-6;k<pages-3;k++){
							%>
							<a id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
							<%
								}
																	}
																	if(sum>pages+3){
																		for(int k=pages-3;k<pages+4;k++){
							%>
							<a id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
							<%
								}
																	}else{
																		for(int k=pages-3;k<sum+1;k++){
							%>
							<a id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
							<%
								}
																	}
																}
							%>
							<%
								}
							%>
							<a id="xia" href="javascript:SX(2,<%=sum%>)">下一页</a> <span
								class="p-num">共<%=sum%>页
							</span> 到 <input id="wenben" type="text" class="jp-ip" /> 页
							<button type="button" onclick="TiaoZhuan()"
								style="background:red">确定</button>
						</div>
					

				</div>

			</div>




		</div>


	</div>
	 <input type="hidden" name="currentPage" value="<%=currentPage %>" id="currentPage"/>
</html:form>
	<!-- 页尾 -->
	<jsp:include page="/bottomPage.jsp" />
	<script type="text/javascript">
		$("img").one("error", function() {
		$(this).attr("src", "<%=style%>/images/default.png");
	});
$(function(){
	//样式
	$("#page"+$("#currentPage").val()).addClass("cur");
	//给文本框赋值
	$("#wenben").val($("#currentPage").val());
});
//提交分页
    function pageSubmit(){
		document.forms[0].action="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_MingShiGZS";
		document.forms[0].submit();
	}
  //点击确定
	function TiaoZhuan(){
	  	var num=$("#wenben").val();
	  	var sum='<%=sum %>';
			if (Number(num) > Number(sum)) {
				$("#wenben").val("1");
			}
			var reg = new RegExp("^[0-9]*$");
			if (!reg.test(num)) {
				$("#wenben").val("1");
			}
			if (num < 1) {
				$("#wenben").val("1");
			}
			$("#currentPage").val($("#wenben").val());
			//控制当前页码
			pageSubmit();
		}
		//点击页码
		function click(i) {
			$("#currentPage").val(i);
			pageSubmit();
		}
		//点击上一页和下一页
		function SX(e, sum) {
			var s = $("#currentPage").val();
			if (e == 1) {//上一页
				if (s > 1) {
					s = s - 1;
					$("#currentPage").val(s);
					pageSubmit();
				}
			} else if (e == 2) {//下一页 
				if (s < sum) {
					s = parseFloat(s) + 1;
					$("#currentPage").val(s);
					pageSubmit();
				}
			}
		}
	</script>

</body>
</html>
