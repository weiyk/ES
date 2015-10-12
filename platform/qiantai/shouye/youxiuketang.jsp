<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
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
    <title>优秀课堂</title>
    <link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
    <link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
    <script src="<%=style%>/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="<%=style%>/js/base.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/common/jwplayer7/jwplayer.js"></script>
	<script type="text/javascript">jwplayer.key="49MNt4knikJicC76KViI7zoyjbOMEs69Mn9ECA==";</script>
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
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_XueXiLHT">学习联合体</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YouXiuKT" class="cur">优秀课堂</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_MingShiGZS">名师工作室</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_TongZhiGG">通知公告</a></li>
		</ul>
	</div>
</div>
    <div class="wrap clearfix">
        <div class="id-login">
	<div class="banner">
		<ul class="pic-list">
			<li rel="<%=style%>/images/banner1.jpg"></li>
			<li rel="<%=style%>/images/banner2.jpg" class="hidden"></li>
			<li rel="<%=style%>/images/banner1.jpg" class="hidden"></li>
		</ul>
	</div>
	<script type="text/javascript" src="<%=style%>/js/banner.js"></script>
	<div class="tj-wrap clearfix">
		<div class="pic-dot">
			<span class="cur"></span><span></span><span></span>
		</div>
	</div>
</div>

  <%
	// 获得课程项目
	IDataBaseAccess dbm = null;
	// 教学模式缓存
	Map<String, String> jxmsMap = new HashMap<String, String>();
	ResultSet rs = null;
	try {
		dbm = ContextService.lookupDefaultDataBaseAccess();
		dbm.openConnection();
		// 查询教学模式
		String sql = "select BianMa, Zhi from qam_jiheyz where ZhuangTai=1 and JiHeYLX='JH_JiaoXueMS'";
		rs = dbm.executeQuery(sql);
		while (rs.next()) {
			jxmsMap.put(rs.getString("BianMa"), rs.getString("Zhi"));
		}
	} catch (Exception e) {
		e.printStackTrace();	
	} finally {
		if (rs != null)
			rs.close();
	}
	
	// 按教学模式查询优秀课堂
	StringBuffer sql =new StringBuffer();
	
	// 是否为第一个课堂列表
	boolean firstItem = true;
	for (Map.Entry<String, String> entry : jxmsMap.entrySet()) {
		// 清空sql
		sql.delete(0, sql.length());
		
		sql.append("Select (select zhi from qam_jiheyz where JiHeYLX='JH_KeMu' and BianMa=JSKJ_YouXiuKT.KeMu) as di_KeMuMC,");
		sql.append("(select zhi from qam_jiheyz where JiHeYLX='JH_NianJi' and BianMa=JSKJ_KeCheng.NianJi) as di_NianJiMC,");
		sql.append("JSKJ_KeCheng.JiaoXueMS as di_JiaoXueMS");
		sql.append(",JSKJ_KeCheng.NianJi as di_NianJi");
		sql.append(",JSKJ_YouXiuKT.BianHao as di_BianHao");
		sql.append(",JSKJ_YouXiuKT.FengMianLJ as di_FengMianLJ");
		sql.append(",JSKJ_YouXiuKT.KeChengBH as di_KeChengBH");
		sql.append(",JSKJ_YouXiuKT.KeMu as di_KeMu");
		sql.append(",JSKJ_YouXiuKT.KeShiBH as di_KeShiBH");
		sql.append(",JSKJ_YouXiuKT.KeTangMC as di_KeTangMC");
		sql.append(",JSKJ_YouXiuKT.ShiPinLJ as di_ShiPinLJ");
		sql.append(",JSKJ_YouXiuKT.ZhuJiangR as di_ZhuJiangR");
		sql.append(" FROM JSKJ_YouXiuKT JSKJ_YouXiuKT, JSKJ_KeCheng JSKJ_KeCheng");
		sql.append(" WHERE JSKJ_YouXiuKT.KeChengBH =JSKJ_KeCheng.BianHao");
		sql.append(" AND JSKJ_KeCheng.JiaoXueMS = '" + entry.getKey() + "'");
		sql.append(" ORDER BY JSKJ_YouXiuKT.BianHao DESC limit 4");
		
		// 查询优秀课堂信息
		rs = dbm.executeQuery(sql.toString());
		int i = 0;
		while (rs.next()) {
			if (i == 0) {
			// 第一次循环时显示教学模式标题							
	%>
			<!-- 教学模式 	出来第一个之外，其他都要增加mt-280样式，否则界面显示异常-->
	        <div class="my-jx <% if (firstItem) {firstItem = false;} else {out.println("mt-280");}%>">
	            <div class="title-bar clearfix mt-20">
	                <h2><%=entry.getValue() %></h2>
	                <div class="rmkc-bk"><a href="#" class="td-a">查看更多>></a></div>
	            </div>
      	  </div>
         	<div class="mt-20">
	<%
			}
	%>
			<div class="<%if (i==3) {out.println("rmkc-kjyq-zh"); } else {out.println("rmkc-kjyq"); }%>">
                <div onclick="playVideo('<%=request.getContextPath() + "/" + rs.getString("di_ShiPinLJ") %>')">
					<img src="<%=request.getContextPath() + "/" + rs.getString("di_FengMianLJ") %>" style="cursor:pointer;"/>
                </div>
                <div class="mt-10 rmkc-spwz">
                	<%
                		// 课程名称
                		String fullName = "《" + rs.getString("di_KeTangMC") + "》";
                		String shortName = fullName;
                		if (fullName.length() > 7) {
                			shortName = "《" + fullName.substring(1, 8) + "...";
                		}
                	%>
                	<label><%=rs.getString("di_NianJiMC") %> </label>
                	<label><%=rs.getString("di_KeMuMC") %> </label>
                    <label title="<%=fullName %>"><%=shortName %></label>
                </div>
                <div>
                    <div class="rmkc-sj mt-10">主讲人：<%=rs.getString("di_ZhuJiangR") %></div>
                    <div class="rmkc-ks"> 科目：<%=rs.getString("di_KeMuMC") %></div>
                </div>
            </div>
	<%
			i++;
		}
		if (i>0) {
	%>
			</div>
	<%
		}
	}
	%>
    </div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />

<!-- 视频播放器弹出层 -->
<div class="pop-box-46 hidden">
    <div class="cover"></div>
    <div class="pop-content">
        <div class="title clearfix">
            <span class="to-close" style="z-index: 999"></span>
            <div id="container">Loadingthe player...</div>
        </div>
    </div>
</div>

<script type="text/javascript">
// 视频播放函数
function playVideo(filePath) {
	// 播放列表
	var operation = "[{file:\"" + filePath + "\"}]";
	// 第一次播放视频时，初始化视频播放器
    player = jwplayer("container").setup({
        flashplayer:"<%=request.getContextPath() %>/common/jwplayer7/jwplayer.flash.swf",
        playlist: eval(operation),
        height:546,
        width:960,
        autostart:true
    });
	
	// 显示播放器
	$(".pop-box-46").removeClass("hidden");
	displayMiddle();
}

// 关闭视频弹出层时停止播放视频
function stopVideo() {
	//player.stop();
	$(".pop-box-46").addClass("hidden");
}

// div弹出框显示在屏幕中间
function displayMiddle() {
	var top = ($(window).height() - $(".pop-box-46 .pop-content").height())/2;   
    var scrollTop = $(document).scrollTop();   
    $(".pop-box-46 .pop-content").css('top', top + scrollTop);
};
</script>
</body>
</html>
