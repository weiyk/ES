<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%
//获取样式
String style=request.getContextPath()+"/platform/qiantai/shouye";
//获取路径
String path=request.getContextPath()+"/servlet";
%>
<html>
<head>
    <title>学习联合体（省）</title>
    <link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
    <link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
    <script src="<%=style%>/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="<%=style%>/js/base.js" type="text/javascript"></script>
</head>
<body style="background:#F2FBFF">

<!-- 头部 -->
<div class="header">
	<div class="in-box wrap clearfix">
		<div class="logo fl">
			<a href="#">双轨数字学校</a>
		</div>
		<ul class="nav fr">
			<li><a href="<%=path%>/desktop.html">首页</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_XueXiLHT"  class="cur">学习联合体</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YouXiuKT" >优秀课堂</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_MingShiGZS">名师工作室</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_TongZhiGG">通知公告</a></li>
		</ul>
	</div>
</div>
    <div class="wrap clearfix h-800">
        <div class="fl mt-10 w-710">
            
            <!-- 湖北省地图 -->
            <div class="my-jx">
                <div class="title-bar clearfix">
                    <h2>
                        湖北省地图</h2>
                </div>
            </div>
            
            <!-- 地图 -->
            <div class="mt-50">
                <img src="<%=style%>/images/lh_map_s.png" alt="" border="0" usemap="#Map" />
				<map name="Map" id="Map">
				<area shape="poly" coords="24,282,32,298,33,333,46,343,65,369,83,388,109,349,123,335,177,344,183,338,163,314,173,256,175,207,167,225,161,261,132,252,95,275,59,275" href="<%=request.getContextPath() %>/platform/qiantai/shouye/xuexilianheti-enshizhou.jsp" />
					<area shape="poly" coords="484,315,472,315,449,326,434,343,442,365,445,393,455,404,477,392,494,380,525,377,542,363,531,342,507,323" href="<%=request.getContextPath() %>/platform/qiantai/shouye/xuexilianheti-xianningshi.jsp" />
				</map>
          </div>

            

        </div>
        <div class="fr w-230">
            <!-- 介绍 -->
            <div class="mt-50">
                <span class="td-js">湖北省双轨数字学校</span>
            </div>
				<div class="tb-bk-left mt-20" style="background:url(<%=style%>/images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
            <div class="td-bk mt-10">
                <p>湖北省双轨数字学校是在综合考察湖北省基础教育的现实情况和国家对教育信息化的目标下建立的一所数字学校，旨在...<a>更多</a></p>
            </div>
            
            
            
            
            
        </div>
    </div>
    
<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />

   

</body>
</html>
