<%@page import="java.io.IOException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Properties"%>
<%@page import="com.qam.framework.context.ApplicationConfig"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
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

	// 获得课程项目
	IDataBaseAccess dbm = null;
	// 资源类型
	Map<String, String> zylxMap = new HashMap<String, String>();
	try {
		dbm = ContextService.lookupDefaultDataBaseAccess();
		dbm.openConnection();
		ResultSet rs = null;
		// 查询集合列表
		String sql = "select BianMa, Zhi from qam_jiheyz where ZhuangTai=1 and JiHeYLX='JH_ZiYuanLX'";
		rs = dbm.executeQuery(sql);
		while (rs.next()) {
			zylxMap.put(rs.getString("BianMa"), rs.getString("Zhi"));
		}
	} catch (Exception e) {
		e.printStackTrace();	
	} finally {
		if (dbm != null)
			dbm.closeConnection();
	}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>相关学习资源</title>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
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
<body>
<html:dialog id="GNDH_XueXiZY" state="DHZT_ChaXun"/>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=yonghuxm %></a><%=schoolName %> <a href="<%=path%>/desktop.html" class="to-quit">退出</a></p>
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
<%
		// 课程信息查询
		RecordSet kcRS = executeResult.getRecordSet("SWDY_KeChengXXCX");
		kcRS.next();
		
		// 查询学习资源
		RecordSet xxzyRS = executeResult.getRecordSet("SWDY_XueXiZYCX");
		xxzyRS.next();
	%>
    <div class="wrap clearfix">
        <div class="fl mt-10 w-710">
        	<html:form>
        	<!-- 保存资源使用说明 -->
        	<input type="hidden" name="di_XueXiZYBH" value="<%=xxzyRS.getString("di_XueXiZYBH")%>"/>
            <div class="td-zt">
                您所在的位置：<%=kcRS.getString("di_NianJi") + kcRS.getString("di_KeMu") %>/<%=kcRS.getString("di_KeShiMC") %>
            </div>
            <!-- 资源使用指导 -->
            <div class="my-jx mt-20">
                <div class="title-bar clearfix">
                	<a id="edit" href="#">
						<span style="float: right;margin-right: 37px;cursor: pointer; color: #2db5f3;">编辑</span>
					</a>
                    <h2>
                        资源使用指导</h2>
                </div>
            </div>
            <div class="mt-20 xxzy-zd">
            	<div id="lbl_ZiYuanSYZD">
            		<%=xxzyRS.getString("di_ZiYuanSYZD") %>
            	</div>
            	<textarea style="display: none" rows="3" cols="100" id="di_ZiYuanSYZD" name="di_ZiYuanSYZD"><%=xxzyRS.getString("di_ZiYuanSYZD") %></textarea>
            </div>
            <!-- 保存按钮 -->
            <div class="xxzy-bc mt-20">
            	<input style="display: none;" id="btnSave" type="button" value="保存" class="wlkc-150" onclick="save()"/>
            </div>
            </html:form>

            <!-- 资源列表 -->
            <div class="zy-reader-box">
			<div class="title-bar blue-title clearfix">
				<h2 class="fl">资源列表</h2>
			</div>
			
			<%
			// 读取图片所在服务器地址
			String prefix = "";
			String filePath = ApplicationConfig.getInstance().REAL_PATH+"admin.properties";
			Properties properties = new Properties();
			File configFile = new File(filePath);
			FileInputStream inputStream = null;
			try {
				inputStream=new FileInputStream(configFile);
				properties.load(inputStream);
				prefix = properties.getProperty("imgUrl");
			}catch (IOException e) {
				e.printStackTrace();
			}
			
			// 所有课件，按课件类型分类后存储结果
			Map<String, List<Map<String, String>>> zykjMap = new HashMap<String, List<Map<String, String>>>();
			// 同类型课件资源列表
			List<Map<String, String>> zykjList = null;
			// 资源类型名称
			String key;
			// 单条资源课件
			Map<String, String> zykj = null;
			
			// 资源课件
			RecordSet zykjRS = executeResult.getRecordSet("SWDY_ZiYuanKJCX");
			while (zykjRS.next()) {
				key = zykjRS.getString("di_ZiYuanLXMC");
				// 获得同类课件资源列表
				zykjList = zykjMap.get(key);
				if (zykjList == null) {
					// 创建同类型资源列表
					zykjList = new ArrayList<Map<String, String>>();
					zykjMap.put(key, zykjList);
				}
				
				zykj = new HashMap<String, String>();
				// 获得资源课件
				zykj.put("di_ZiYuanKJBH", zykjRS.getString("di_ZiYuanKJBH"));	// 资源课件编号
				zykj.put("di_ZiYuanLJ", zykjRS.getString("di_ZiYuanLJ"));	// 资源路径
				zykj.put("di_ZiYuanLX", zykjRS.getString("di_ZiYuanLX"));	// 资源类型
				zykj.put("di_ZiYuanLXMC", zykjRS.getString("di_ZiYuanLXMC"));	// 资源类型名称
				zykj.put("di_ZiYuanMC", zykjRS.getString("di_ZiYuanMC"));	// 资源名称
				
				// 封面路径
				String fmlj = zykjRS.getString("di_FengMianLJ");
				if (fmlj != null && !"".equals(fmlj)) {
					if (fmlj.indexOf("jymis") > 0) {
						fmlj = prefix + fmlj;
					} else {
						fmlj = request.getContextPath() + "/" + fmlj;
					}
				}
				zykj.put("di_FengMianLJ", fmlj);	// 封面路径
				// 添加同类资源列表
				zykjList.add(zykj);
			}
			
			// 遍历资源类型集合
			for (Map.Entry<String, String> zylxEntry : zylxMap.entrySet()) {
				// 资源类型对应的资源课件列表
				//for (Map.Entry<String, List<Map<String, String>>> entry : zykjMap.entrySet()) {
			%>
			<!-- 教学课件 -->
            <div class="mt-10">
                <label><%=zylxEntry.getValue() %></label>
            </div>
			<div class="read-list mt-20 myread-list">
				<ul class="clearfix">
			<%
				// 资源类型对应的资源课件列表
				List<Map<String, String>> list = zykjMap.get(zylxEntry.getValue());
				if (list != null) {
					for (Map<String, String> map : list) {
			%>
					<li>
						<div class="pic-box-1">
							<img src="<%=map.get("di_FengMianLJ") %>" width="141px" height="100px" alt="" />
							<div class="cover hidden"></div>
							<a href="<%=path %>/jspcontrolservlet?_qam_dialog=GNDH_ZaiXianYL&cs_ZiYuanKJBH=<%=map.get("di_ZiYuanKJBH") %>" target="_blank" class="to-read hidden">查看资源</a> 
						</div>
						<div class="zy-xh mt-10">
                            <label><%=map.get("di_ZiYuanMC") %></label>
                        </div>
					</li>
			<%
					}
				}
			%>
                    <li class="lastzj">
                    <div></div>
						<div class="zj mt-10 xxzy-jxkj" onclick="openWin('<%=zylxEntry.getKey() %>')">
                        </div>
                        <label class="xxzy-jxkj" onclick="openWin('<%=zylxEntry.getKey() %>')">
                        	增加课件
                        </label>
					</li>
				</ul>
			</div>
			<%
			}
			%>
		</div>

        </div>
        <div class="fr w-230">
        <div class="mt-10 xxzy-bk">
            <a href="<%=path %>/jspcontrolservlet?_qam_dialog=GNDH_KaiShiBK&cs_BianHao=<%=kcRS.getString("di_KeChengBH") %>" class="xxzy-bk-a">返回到备课界面》</a>
        </div>
            <!-- 课程内容 -->
            <div class="cour-mykc mykc mt-20">
                <div class="title">
                    <h2>
                        课程内容</h2>
                </div>
            </div>
            <div class="cour-kc mykc mt-10">
                <div class="title">
                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeQianDX&cs_KS_BianHao=<%=kcRS.getString("di_KeShiBH") %>">课前导学</a>
                </div>
            </div>
            <div class="cour-kc mt-1 mykc">
                <div class="title">
                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_XueXiMB&cs_KS_BianHao=<%=kcRS.getString("di_KeShiBH") %>">学习目标</a>
                </div>
            </div>
            <div class="cour-mykc mt-1 mykc">
                <div class="title">
                    	相关学习资源
                </div>
            </div>
            <div class="cour-kc mt-1 mykc">
                <div class="title">
                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_XueXiHD&cs_KeShiBH=<%=kcRS.getString("di_KeShiBH") %>">学习活动设计</a>
                </div>
            </div>
            <div class="cour-kc mt-1 mykc">
                <div class="title">
                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_JiaoXueSP&cs_KeShiBH=<%=kcRS.getString("di_KeShiBH") %>">教学视频</a>
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
		<form action="<%=path %>/uploadCourseware" method="post" enctype="multipart/form-data" onsubmit="return formValidate()">
		<!-- 资源课件上传 -->
		<input type="hidden" name="op" value="zykj"/>
		<!-- 学习资源编号 -->
		<input type="hidden" name="di_XueXiZYBH" value="<%=xxzyRS.getString("di_XueXiZYBH") %>"/>
		<!-- 课时编号 -->
		<input type="hidden" name="di_KeShiBH" value="<%=xxzyRS.getString("di_KeShiBH") %>"/>
		<!-- 资源类型 -->
		<input type="hidden" name="di_ZiYuanLX" id="di_ZiYuanLX"/>
		<div class="title clearfix">
			<h2>添加资源</h2>
			<span class="to-close"></span>
		</div>
		<div class="box-c">
			<div class="upld-form">
				<div class="one-cell clearfix">
					<label>资源名称</label>
					<div class="mation-fillin-in">
						<input type="text" style="width: 500px; height: 30px;" name="di_ZiYuanMC" id="di_ZiYuanMC"/>
					</div>
				</div>
				<div class="one-cell clearfix">
					<label>资源路径</label>
					<div class="multiselect-box">
						<div id="zyljDiv1">
							<input type="file" class="the-val" id="ZiYuanLJ" name="ZiYuanLJ"/>
						</div>
						<div id="zyljDiv2" class="hidden">
							<input type="text" readonly="readonly" id="ZiYuanLJ_Name" name="ZiYuanLJ_Name" style="width: 500px; height: 30px;"/>
							<a onclick="delResource()">删除</a>
						</div>
					</div>
				</div>
				
				<div class="one-cell clearfix">
					<label>封面路径</label>
					<div class="multiselect-box">
						<div id="fmljDiv1">
							<input type="file" class="the-val" id="FengMianLJ" name="FengMianLJ"/>
						</div>
						<div id="fmljDiv2" class="hidden">
							<input type="text" readonly="readonly" id="FengMianLJ_Name" name="FengMianLJ_Name" style="width: 500px; height: 30px;"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="box-actadd">
			<button type="submit">增加资源</button>
			<button type="button" onclick="selectResource()">使用资源中心</button>
		</div>
		</form>
	</div>
</div>
<script type="text/javascript">
//设置当图片加载失败时，显示默认图片
$(".pic-box-1>img").one("error", function() {
	$(this).attr("src", "<%=style%>/images/default.png");
});

// 保存相关学习资源
function save() {
	// 资源使用指导
	var di_ZiYuanSYZD = $("#di_ZiYuanSYZD").val();
	if (isEmpty(di_ZiYuanSYZD)) {
		alert("资源使用指导不能为空！");
		return false;
	}
	if (beyondTheLength(di_ZiYuanSYZD, 500)) {
		alert("资源使用指导不能超过500字符！");
		return false;
	}
	$(this)._submit("<%=path%>/jspcontrolservlet?_qam_command=MLKZ_XueXiZYXG&_qam_dialog=GNDH_XueXiZY&cs_KeShiBH=<%=kcRS.getString("di_KeShiBH") %>");
}
// 打开添加资源弹出框
function openWin(key){
	$("#di_ZiYuanLX").val(key);
}

// 表单提交验证
function formValidate() {
	// 资源名称
	var di_ZiYuanMC = $("#di_ZiYuanMC").val();
	if (isEmpty(di_ZiYuanMC)) {
		alert("资源名称不能为空！");
		return false;
	}
	if (beyondTheLength(di_ZiYuanMC, 50)) {
		alert("资源名称不能超过50字符！");		
		return false;
	}
	var keShiBH = "<%=kcRS.getString("di_KeShiBH") %>";
	if (ExtFunctionCM.CheckRecordCount("jskj_xuexizy x, jskj_ziyuankj z  "," WHERE x.BianHao = z.XueXiZYBH and x.KeShiBH = '" + keShiBH + "' and z.ZiYuanMC='" + di_ZiYuanMC + "'") > 0) {
		alert("资源名称已经被使用！");
		return false;
	}
	
	// 资源路径
	var ZiYuanLJ = $("#ZiYuanLJ").val();
	var ZiYuanLJ_Name = $("#ZiYuanLJ_Name").val();
	if ((ZiYuanLJ == "" || ZiYuanLJ.length == 0)
		&& (ZiYuanLJ_Name == "" || ZiYuanLJ_Name.length == 0)) {
		alert("请选择资源文件！");
		return false;
	}
	
	// 封面路径
	var FengMianLJ = $("#FengMianLJ").val();
	var FengMianLJ_Name = $("#FengMianLJ_Name").val();
	if (FengMianLJ == "" || FengMianLJ.length == 0) {
		if (FengMianLJ_Name == "" || FengMianLJ_Name.length == 0) {
			alert("请选择封面图片！");
			return false;
		}
	}
	
	if (FengMianLJ_Name == "" || FengMianLJ_Name.length == 0) {
		// 获得封面文件格式
		var picType = FengMianLJ.substring(FengMianLJ.lastIndexOf("."), FengMianLJ.length).toUpperCase();
		if (picType != ".BMP" && picType != ".PNG" && picType != ".GIF" && picType != ".JPG" && picType != ".JPEG") {
			alert("封面仅限于bmp,png,gif,jpg,jpeg格式！");
			return false;
		}
	}
	return true;
}

// 资源点选
function selectResource() {
	var obj = new Object();
	var url = "<%=request.getContextPath() %>/platform/qiantai/teacher/dianxuanziyuan.jsp";
	var returnVal = window.showModalDialog(url, obj, "dialogWidth=1100px;dialogHeight=900px");
	
	// 存在返回值时
	if (returnVal != null) {
		// 资源名称
		var name = returnVal.name;
		// 资源图片(相对)路径
		var img = returnVal.img;
		// 资源文件(相对)路径
		var resource = returnVal.resource;
		
		// 清空file并且隐藏
		var file = $("#ZiYuanLJ");
		file.after(file.clone().val("")); 
		file.remove();
		var file = $("#FengMianLJ");
		file.after(file.clone().val(""));
		file.remove();
		
		// 隐藏上传文件空间
		$("#zyljDiv1").addClass("hidden");
		$("#fmljDiv1").addClass("hidden");
		
		// 显示点选的资源信息
		$("#di_ZiYuanMC").val(name);
		$("#ZiYuanLJ_Name").val(resource);
		$("#FengMianLJ_Name").val(img);
		$("#zyljDiv2").removeClass("hidden");
		$("#fmljDiv2").removeClass("hidden");
	}
}

//删除资源
function delResource() {
	// 隐藏上传文件空间
	$("#zyljDiv1").removeClass("hidden");
	$("#fmljDiv1").removeClass("hidden");
	
	// 显示点选的资源信息
	$("#di_ZiYuanMC").val("");
	$("#ZiYuanLJ_Name").val("");
	$("#FengMianLJ_Name").val("");
	$("#zyljDiv2").addClass("hidden");
	$("#fmljDiv2").addClass("hidden");
	
}

$(function() {
	// 编辑按钮事件
	$("#edit").click(function() {
		$(this).hide();
		
		// 资源使用指导，隐藏lbl，显示输入框
		$("#lbl_ZiYuanSYZD").addClass("hidden");
		$("#lbl_ZiYuanSYZD").parent().removeClass("xxzy-zd");
		$("#di_ZiYuanSYZD").css("display", "");
		
		// 显示保存按钮
		$("#btnSave").css("display", "");
	});
});
</script>
</body>
</html>