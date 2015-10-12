<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
//获取样式
String style=request.getContextPath()+"/platform/qiantai/teacher";
//获取路径
String path=request.getContextPath()+"/servlet";
String yonghuxm =(String)session.getAttribute("YONGHUXM");
//获取学校名字
String schoolName=(String) session.getAttribute("schoolName");
//课时排序
String order =request.getParameter("cs_PXLX");
//获得课程项目
IDataBaseAccess dbm = null;
//课程项目集合
List<String> keShiLXList = new ArrayList<String>();
try {
	dbm = ContextService.lookupDefaultDataBaseAccess();
	dbm.openConnection();
	ResultSet rs = null;
	// 查询集合列表
	String sql = "select JiHeYLX, BianMa, Zhi from qam_jiheyz where ZhuangTai=1 and JiHeYLX='JH_KeShiLX'";
	rs = dbm.executeQuery(sql);
	while (rs.next()) {
		// 集合编码
		keShiLXList.add(rs.getString("BianMa"));
		// 集合值
		keShiLXList.add(rs.getString("Zhi"));
	}
} catch (Exception e) {
	e.printStackTrace();	
} finally {
	if (dbm != null)
		dbm.closeConnection();
}
%>
<head>
	<%@include file="/common/framework.jspf" %>
	<%@include file="/common/jquery.jspf" %>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>课程内容</title>
	<meta name="Keywords" content="">
	<meta name="Description" content="">
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style %>/js/base.js"></script>
	<script type="text/javascript">
		function message_show_success(message){
			alert(message);
		}
	</script>
</head>
<html:dialog id="GNDH_KeChengNR" state="DHZT_ChaXun"/>
<body>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=yonghuxm %></a><%=schoolName %><a href="<%=path%>/desktop.html" class="to-quit">退出</a></p>
	</div>
</div>

<!-- 头部 -->
<div class="header">
	<div class="in-box wrap clearfix">
		<div class="logo fl">
			<a href="#">双轨数字学校</a>
		</div>
		<ul class="nav fr">
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueKJ">首页</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueZB" class="cur">教学准备</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoShiFZ">教师发展</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YingYongZX">应用中心</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueGZS">教师工作室</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanZX">资源中心</a></li>
		</ul>
	</div>
</div>




<div class="wrap clearfix">
	<%
	// 查询课程信息
	RecordSet courseRS = executeResult.getRecordSet("SWDY_ChaKanKC");
	courseRS.next();
	
	// 编目编号
	String bianMuBH = courseRS.getString("di_BianMuBH");
	Map<String, String> bmMap = new HashMap<String, String>();
	try {
		dbm = ContextService.lookupDefaultDataBaseAccess();
		dbm.openConnection();
		ResultSet rs = null;
		// 查询集合列表
		String sql = "SELECT bm.BianHao, bm.BianMuBM, bm.BianMuMC, bm.ShangJiBH from jskj_kechengbm bm where bm.ShangJiBH = '" + bianMuBH + "'";
		rs = dbm.executeQuery(sql);
		while (rs.next()) {
			bmMap.put(rs.getString("BianHao"), rs.getString("BianMuMC"));
		}
		request.setAttribute("bmMap", bmMap);
	} catch (Exception e) {
		e.printStackTrace();	
	} finally {
		if (dbm != null)
			dbm.closeConnection();
	}
	%>
	<!--上半部分-->
	<div  class="top-banner-enjsx">
				<div class="title-bar clearfix mt-10">
			  		<h2><%=courseRS.getString("di_NianJi") + courseRS.getString("di_KeMu") %></h2>
				</div>
				<div class="title-mybanners-enjsx clearfix mt-10">
					<div class="mybanners-left-enjsx">
						<a href="#"><img src="<%=style %>/images/title-iconfont-shuss.png" alt="" /></a>
						
					</div>
					<div class="myclassroom-right-enjsx">
						<div class="myclass-right-top">
							<span class="img-enjsx">
								<a href="#"><img src="<%=style %>/images/iconfont-talk.png" alt="" /></a>
								<a title="课程信息" href="<%=path %>/jspcontrolservlet?_qam_dialog=GNDH_KaiShiBK&cs_BianHao=<%=courseRS.getString("di_KC_BianHao")%>"><img src="<%=style %>/images/iconfont-note.png" alt="" /></a>
								<a href="#"><img src="<%=style %>/images/Shape.png" alt="" /></a>
							</span>
							<a href="#"><span class="jxz-enjsx"><%=courseRS.getString("di_ZhuangTai") %></span></a>
						</div>
						<div class="myclass-right-main">
							<div class="title-dynamic">
								<div class="title-dy">
									<span class="title-jj mt-20">课程特色:</span>
								</div>
								<ul class="clearfix">
									<li>
										<%=courseRS.getString("di_KeChengTS") %>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
	</div>

	<!--左半部分-->
	<div class="fl  w-710 mt-20">
		
		<!-- 课程信息 -->
		<div class="rmtj-box">
		<div class="title-bar clearfix mt-10">
			  <h2>课时内容</h2>
		</div>
		  <div class="clearfix">

           <div class="my-kcnr-cc">
            <span class="subjecttxt"><%=courseRS.getString("di_NianJi") + courseRS.getString("di_KeMu") %></span>
            <span class="subject-pic-one"><a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeChengNR&cs_KeChengBH=<%=courseRS.getString("di_KC_BianHao") %><%if (order == null) {out.print("&cs_PXLX=DESC"); } %>"><img src="<%=style %>/images/coursesort.png" /></a></span>
            <span class="subject-pic-two"><a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_JiaoXueJHCX&cs_KeChengBH=<%=courseRS.getString("di_KC_BianHao") %>&cs_JiHuaLX=1"><img src="<%=style %>/images/search-teachprogram.png" /></a></span>
           </div>
           <div class="my-kcnr-detaillist">
               <ul>
               <%
				// 查询课时，生成课时列表
				RecordSet hourRS;
				if(order != null) {
					hourRS = executeResult.getRecordSet("SWDY_ChaKanKS_DESC");
				} else {
					hourRS = executeResult.getRecordSet("SWDY_ChaKanKS");
				}
				while (hourRS.next()) {
				%>
                  <li>
                     <div class="detaillist-mc">
                       <p><%=hourRS.getString("di_KeShiMC") %></p>
                     </div>
                     <div class="detaillist-pic">
                            <div class="inner-lpic-kcnr">
                                <a class="pic-pic-kc mt-10" href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeQianDX&cs_KS_BianHao=<%=hourRS.getString("di_KS_BianHao") %>"><img src="<%=style %>/images/iconfont-shu (1).png"/></a>
					            <a class="pic-shortword-kc" href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeQianDX&cs_KS_BianHao=<%=hourRS.getString("di_KS_BianHao") %>">课前导学</a>
                            </div>

                            <div class="inner-pic-kcnr">
                                <a class="pic-pic-kc mt-8" href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_XueXiMB&cs_KS_BianHao=<%=hourRS.getString("di_KS_BianHao") %>"><img src="<%=style %>/images/iconfont-mubiao.png"/></a>
					            <a class="pic-shortword-kc" href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_XueXiMB&cs_KS_BianHao=<%=hourRS.getString("di_KS_BianHao") %>">学习目标</a>
                            </div>
                            <div class="inner-pic-kcnr">
                                <a class="pic-pic-kc mt-10" href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_XueXiZY&cs_KeShiBH=<%=hourRS.getString("di_KS_BianHao") %>"><img src="<%=style %>/images/iconfont-ziyuanguanli (1).png"/></a>
					            <a class="pic-longword-kc" href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_XueXiZY&cs_KeShiBH=<%=hourRS.getString("di_KS_BianHao") %>">相关学习资源</a>
                            </div>
                            <div class="inner-pic-kcnr">
                                <a class="pic-pic-kc mt-10" href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_XueXiHD&cs_KeShiBH=<%=hourRS.getString("di_KS_BianHao") %>"><img src="<%=style %>/images/iconfont-huodongjingxuan.png"/></a>
					            <a class="pic-longword-kc" href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_XueXiHD&cs_KeShiBH=<%=hourRS.getString("di_KS_BianHao") %>">学习活动设计</a>
                            </div>
                            <div class="inner-rpic-kcnr">
                                <a class="pic-pic-kc mt-10" href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_JiaoXueSP&cs_KeShiBH=<%=hourRS.getString("di_KS_BianHao") %>"><img src="<%=style %>/images/iconfont-bofang.png"/></a>
					            <a class="pic-shortword-kc"  href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_JiaoXueSP&cs_KeShiBH=<%=hourRS.getString("di_KS_BianHao") %>">教学视频</a>
                            </div>
                     </div>
                     <div class="detaillist-piclist">  
                           <span class="subject-pic-one">
                           	<%if ("1".equals(hourRS.getString("di_FaBuZT"))) { %>
                           		<img src="<%=style %>/images/published.png" />
                           	<%} %>
                           	</span>
                           <span class="subject-pic-two"><a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_YuLanKC&cs_KeShiBH=<%=hourRS.getString("di_KS_BianHao") %>&cs_KeChengBH=<%=courseRS.getString("di_KC_BianHao") %>"><img src="<%=style %>/images/searchteachbag.png" /></a></span>
                           <span class="subject-pic-three"><a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_ChaKanJA&cs_KeShiBH=<%=hourRS.getString("di_KS_BianHao") %>&cs_KeChengBH=<%=courseRS.getString("di_KC_BianHao") %>"><img src="<%=style %>/images/searchjiaoan.png" /></a></span>
                     </div>
                  </li>       
                  <%} %>
               </ul>
           </div>
           <div class="my-kcnr-addcourse">
               <a href="#" class="toup-zy"><img src="<%=style %>/images/addcourse.png"/></a>
           </div>

           </div>
        
        </div>
	</div>

	<!--右半部分-->

	<div class="fr w-230 mt-30">		
		<!-- 我的全部课程 All my classes-->
		<div class="all-curriculum-jxkc ">
			<div class="one-dynamic">
				<div class="curriculum-mation-title">
						<h3>课程信息</h3>
				</div>

                <div class="curriculum-mation-subtitle">
				<ul class="clearfix">
					<li class="uncur" onclick="javascript:location.href='<%=path %>/jspcontrolservlet?_qam_dialog=GNDH_KaiShiBK&cs_BianHao=<%=courseRS.getString("di_KC_BianHao") %>'">
                        <a class="list-contenttwo-jxkc" href="#">基本信息</a>						
					</li>
					<li class="cur">
                        <span class="list-contentone-jxkc">课时内容</span>
                    </li>
				</ul>
                </div>
			</div>
		</div>
	</div>
</div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />



<!--弹出层-->
<div class="pop-box hidden">
	<div class="cover"></div>
	<div class="pop-content">
		<div class="title clearfix">
			<h2>课时信息</h2>
			<span class="to-close"></span>
		</div>
		<html:form>
		<!-- 课程名称 -->
		<input type="hidden" name="KeChengBH" value="<%=courseRS.getString("di_KC_BianHao") %>"/>
		<!-- 课时名称 -->
		<input type="hidden" id="di_KeShiMC" name="KeShiMC"/>
		<div class="box-c">
			<div class="upld-form">
				
				<div class="one-cell clearfix">
					<label>相关章节</label>
					<div class="select-boxs select-boxs-bl fl">
						<select style="width: 100px; height: 30px;" onchange="ajaxQueryBM()" id="xgzjSel">
							<option value="请选择" selected="selected">请选择</option>
							<c:forEach items="${bmMap }" var="bm">
								<option value="${bm.key }">${bm.value }</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<!--单选-->
				<div class="one-cell clearfix">
					<label>&nbsp;</label>
					<div id="courseList" class="radio-boxs">
						<input type='hidden' name='BianMuBH' id='di_BianMuBH' />
					</div>
				</div>
				
				<!--单选-->
				<div class="one-cell clearfix">
					<label>课时类型</label>
					<div class="radio-boxs">
						<input type="hidden" id="di_KeShiLX" name="KeShiLX" value="<%=keShiLXList.get(0)%>"/>
						<% for (int i = 0; i < keShiLXList.size(); i+=2) {%>
							<span class="one-rd <%if(i==0){ %>rd-checked<%} %>" onclick="selectClass('<%=keShiLXList.get(i) %>')"><%=keShiLXList.get(i+1) %></span>
						<%} %>
					</div>
				</div>
			</div>
		</div>
		</html:form>
		<div class="box-actadd">
			<button type="submit" onclick="save()">增加课时</button>
		</div>
	</div>
</div>
<script type="text/javascript">
// 选择课时类型
function selectClass(t) {
	$("#di_KeShiLX").val(t);
}

// 增加课时
function save() {
	// 相关章节
	var di_BianMuBH = $("#di_BianMuBH").val();
	if (di_BianMuBH == "") {
		alert("请选择相关章节！");
		return false;
	}
	
	// 课时名称
	var di_KeShiMC = $("#di_KeShiMC").val();
	if (!isEmpty(di_KeShiMC)) {
		if (ExtFunctionCM.CheckRecordCount("jskj_keshi "," WHERE KeShiMC = '" + di_KeShiMC + "' and KeChengBH='<%=courseRS.getString("di_KC_BianHao") %>'") > 0) {
			alert("已经存在所选章节的课时！");
			return false;
		}
	}
	
	$(this)._submit('<%=path%>/jspcontrolservlet?_qam_command=MLKZ_TianJiaKS&_qam_dialog=GNDH_KeChengNR&cs_KeChengBH=<%=courseRS.getString("di_KC_BianHao") %>');
}

//选择课时类型
function selectBM(id, txt) {
	// 编目编号
	$("#di_BianMuBH").val(id);
	// 课时名称
	$("#di_KeShiMC").val(txt);
}

// 动态查询编目下面内容列表
function ajaxQueryBM() {
	$.ajax({
		type:"post",
		url:'<%=path%>/AjaxServlet',
		traditional:true,
		async:false,
		dataType: "json",
		data:{service:"com.rc.web.ajax.QuerySubject",
		parameter:["parentID"],
		value:[$("#xgzjSel").val()]},
		success:function(data,textStatus,jqXHR){
			var html = "";
			var i = 0;
			// 默认选中的编目编号
			var defaultVal = "";
			// 默认选中的编目名称
			var defaultTxt = "";
			$.each(data, function(key, val) {
				if (i==0) {
					html += "<span onclick=\"selectBM('" + key + "', '" + val + "')\" id='child" + key + "' class='one-rd rd-checked'>" + val + "</span>";
					defaultVal = key;
					defaultTxt = val;
				} else {
					html += "<span onclick=\"selectBM('" + key + "', '" + val + "')\" id='child" + key + "' class='one-rd'>" + val + "</span>";
				}
				i++;
			});
			html = "<input type='hidden' name='BianMuBH' id='di_BianMuBH' value='" + defaultVal + "'/>" + html;
			$("#courseList").text("");
			$("#courseList").append(html);
			
			// 获取编目名称赋值给课时名称
			$("#di_KeShiMC").val(defaultTxt);
			
			// 绑定事件
			$(".radio-boxs .one-rd").click(function () {
			    $(this).addClass("rd-checked").siblings().removeClass("rd-checked");
			    $(this).parent(".radio-boxs").find(".the-val").val($(this).attr("rel"));
			})
		},
		complete:function(XHR, TS){
			result = XHR.responseText;
			if('_qam_ajax_error'==result){
				$(this)._alert('\u63d0\u793a','ajax\u8c03\u7528\u5f02\u5e38');
				throw new Error("ajax\u8c03\u7528\u5f02\u5e38");
			}
			XHR = null;
		}
	});
}
</script>
</body>
</html>