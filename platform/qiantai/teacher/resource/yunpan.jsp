<%@page import="java.util.LinkedHashMap"%>
<%@page import="com.qam.framework.context.ApplicationConfig"%>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="java.util.List"%>
<%@page import="com.rc.web.extension.component.resource.ResourceHelper"%>
<%@page import="com.qam.framework.util.CommonUtils"%>
<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	//获取用户UID
	String UID = (String) request.getSession().getAttribute(
			"XiTongHYBH");
	//获取学校名字
	String schoolName = (String) session.getAttribute("schoolName");
	
	// 媒体类型
	String cs_MeiTiLX = request.getParameter("cs_MeiTiLX");
	if (cs_MeiTiLX == null)
		cs_MeiTiLX = "";
	// 资源类别
	String cs_ZiYuanLB = request.getParameter("cs_ZiYuanLB");
	if (cs_ZiYuanLB == null)
		cs_ZiYuanLB = "";
	
	// 科目集合
	Map<String, String> keMuMap = new LinkedHashMap<String, String>();
	// 年级集合
	Map<String, String> nianJiMap = new LinkedHashMap<String, String>();
	
	// 获得课程项目
	IDataBaseAccess dbm = null;
	ResultSet rs = null;
	// 资源类型
	Map<String, String> zylxMap = new HashMap<String, String>();
	try {
		dbm = ContextService.lookupDefaultDataBaseAccess();
		dbm.openConnection();
		// 查询所有科目
		String sql = "select BianMa, Zhi from qam_jiheyz where ZhuangTai=1 and JiHeYLX='JH_KeMu' order by BianMa asc";
		rs = dbm.executeQuery(sql);
		while (rs.next()) {
			keMuMap.put(rs.getString("BianMa"), rs.getString("Zhi"));
		}
		rs.close();
		
		// 查询所有年级
		sql = "select BianMa, Zhi from qam_jiheyz where ZhuangTai=1 and JiHeYLX='JH_XueDuan' order by BianMa asc";
		rs = dbm.executeQuery(sql);
		while (rs.next()) {
			nianJiMap.put(rs.getString("BianMa"), rs.getString("Zhi"));
		}
		
		request.setAttribute("keMuMap", keMuMap);
		request.setAttribute("nianJiMap", nianJiMap);
	} catch (Exception e) {
		e.printStackTrace();	
	} finally {
		if (rs != null)
			rs.close();
		if (dbm != null)
			dbm.closeConnection();
	}
	
	//imgUrl
	String imgUrl = (String) request.getSession().getAttribute("imgUrl");
	//获取搜索资源
	ResourceHelper rshelp = new ResourceHelper();
	//获取资源类别
	List<List<String>> list_restype=rshelp.getType();
	
	//总页数
	int pageCount = 0;
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>资源中心</title>
    <%@include file="/common/framework.jspf" %>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<link href="<%=resource_style%>/common.css" rel="stylesheet" type="text/css" />
	<link href="<%=resource_style%>/resource.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
	.to-save {
		background: #ff6700 none repeat scroll 0 0;
	    color: #fff;
	    display: inline-block;
	    font-size: 16px;
	    height: 40px;
	    line-height: 40px;
	    margin-right: 20px;
	    text-align: center;
	    vertical-align: middle;
	    width: 120px;
	}
	</style>
	<script type="text/javascript">
	<%
		Object msg = request.getAttribute("msg");
		if (msg != null)
			out.println("alert('" + msg.toString() + "');");
	%>
	function isEmpty(val) {
		var empty = false;
		if ($.trim(val) == "") {
			empty = true;
		}
		return empty;
	}

	function beyondTheLength(val, limit) {
		var len = 0;
		for (var i = 0; i < val.length; i++) {
			var a = val.charAt(i);
			  if (a.match(/[^\x00-\xff]/ig) != null) {
				  len += 2;
	          } else {
	        	  len += 1;
	          }
		}
		
		// éªè¯æ¯å¦è¶åºéå¶
		if (len > limit) {
			return true;
		}
		return false;
	}
	
		$().ready(function(){
			/* 滑动/展开 */
		    $(".submenu ul li>.subheader-label").click(function(){
		        $(this).parent().find(".menu-two").slideToggle();
		        // 隐藏其他的列表
		        $(this).parent().nextAll().find(".menu-two").slideUp();
		        $(this).parent().prevAll().find(".menu-two").slideUp();
		    });
		});
	</script>
</head>
<body>
<html:dialog id="GNDH_ZiYuanUpload" state="DHZT_ChaXun"/>
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
	
<div class="wrap clearfix">
	<div class="wrap clearfix" style="height:auto;">
		<div class="res-content">
			<div class="layout">
<!--二级导航开始-->
<div class="subnav">
	<ul>
		<li>
			<a href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanZX">资源检索</a></li>
		<li>
			<a href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanSC">资源收藏</a>
		</li>
		<li>
			<a class="subnav-click">资源上传</a>
		</li>
		<li><a
			href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanFX">资源分享</a>
		</li>
		<li><a
			href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanXZ">资源下载</a>
		</li>
		<li>
			<a href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanDY">资源订阅</a>
		</li>

	</ul>
</div><!--二级导航结束--->
<div class="clear"></div>

<!--内容1开始-->
<div class="menu fl">
    <div class="manage">
        <ul>
            <li><span class="icon-upload"></span><a id="J_upload"  class="u_addkc toup-zy-1">上传文件</a></li>
        </ul>
    </div>

	<!--左侧分类开始-->
	<div class="submenu" >
		<ul>
			<li>
				<span class="subheader-label"><a href="#">小学资源</a></span>
				<ul class="menu-two">
					<%for(int i=0;i<list_restype.get(0).size();i++ ){ String[] type=list_restype.get(0).get(i).split("&");%>
					<li><a href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanUpload&cs_MeiTiLX=<%=cs_MeiTiLX %>&cs_ZiYuanLB=<%=type[0] %>"><%=type[1] %> </a></li>
					<%} %>
				</ul>
			</li>
			<li>
				<span class="subheader-label"><a href="#">初中资源</a></span>
				<ul class="menu-two" style="display: none;">
					<%for(int i=0;i<list_restype.get(1).size();i++ ){ String[] type=list_restype.get(1).get(i).split("&");%>
					<li><a href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanUpload&cs_MeiTiLX=<%=cs_MeiTiLX %>&cs_ZiYuanLB=<%=type[0] %>"><%=type[1] %> </a></li>
					<%} %>
				</ul>
			</li>
			<li>
				<span class="subheader-label"><a href="#">高中资源</a></span>
				<ul class="menu-two" style="display: none;">
					<%for(int i=0;i<list_restype.get(2).size();i++ ){ String[] type=list_restype.get(2).get(i).split("&");%>
					<li><a href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanUpload&cs_MeiTiLX=<%=cs_MeiTiLX %>&cs_ZiYuanLB=<%=type[0] %>"><%=type[1] %> </a></li>
					<%} %>
				</ul>
			</li>
		</ul>
	</div>
</div>

<div class="reslist-right fl">
	<!-- 查询条件 -->
    <div class="reslist-right-content fl">
        <ul>
            <li class="list-class">媒体类型：</li>
            <li><a <%if("".equals(cs_MeiTiLX)) {%>class="reslist-click"<%} %> href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanUpload&cs_ZiYuanLB=<%=cs_ZiYuanLB %>">全部</a></li>
            <li><a <%if("1".equals(cs_MeiTiLX)) {%>class="reslist-click"<%} %> href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanUpload&cs_MeiTiLX=1&cs_ZiYuanLB=<%=cs_ZiYuanLB %>">电子书</a></li>
            <li><a <%if("2".equals(cs_MeiTiLX)) {%>class="reslist-click"<%} %> href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanUpload&cs_MeiTiLX=2&cs_ZiYuanLB=<%=cs_ZiYuanLB %>">视频</a></li>
            <li><a <%if("3".equals(cs_MeiTiLX)) {%>class="reslist-click"<%} %> href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanUpload&cs_MeiTiLX=3&cs_ZiYuanLB=<%=cs_ZiYuanLB %>">音频</a></li>
        </ul>
    </div>

	<html:form id="selectForm">
    <div class="lei_count">
        <!--列表内容切换开始-->
        <div class="list-content">
            <div class="switch-box">
	            <ul class="list-nav">
	            </ul>
            </div>
            
			<div class="list-wrap">
				<ul id="featured">
	            <%
	            	// 资源列表展示
					RecordSet zyRS = executeResult.getRecordSet("SWDY_ChaXun");
		       		// 总条数
		    		long total = zyRS.getRecordCount();
		    		// 每页显示条数
		    		int limit = 10;
		    		if (total%limit == 0) {
		    			pageCount = (int)total/limit;
		    			if (pageCount == 0)
		    				pageCount = 1;
		    		} else {
		    			pageCount = (int)total/limit + 1;
		    		}
		    		request.setAttribute("pageCount", pageCount);
		    		
	            	while (zyRS.next()) {
	            %>
					<li class="bd_icn"> <!--图标-->
						<div class="tu_lef">
							<!-- 预览功能 -->
							<a target="_blank" href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanYL&cs_ZiYuanBH=<%=zyRS.getString("di_ZiYuanBH") %>">
								<span class="list-bg"></span>
							</a>
						</div>
                        <div class="tu_mid">
                            <span class="sp_01">
                            	<img src="<%=request.getContextPath()+"/" + zyRS.getString("di_FengMianLJ") %>" style="widows: 30px; height: 30px;" class="tu_lei">                                
                            	<a href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanYL&cs_ZiYuanBH=<%=zyRS.getString("di_ZiYuanBH") %>" target="_blank">
                            		<%=zyRS.getString("di_ZiYuanMC") %>
                            	</a>
                            </span>
                            <p class="res-brief">简介：</p>
                           	<% 
                           		String desc = zyRS.getString("di_ZiYuanJJ");
                           		int descLength = desc.length();
                           		// 简写
                           		String shortWord = "";
                           		if (descLength > 15) {
                           			shortWord = desc.substring(0, 15) + "...";
                           		} else {
                           			shortWord = desc;
                           		}
                           	%>
                            <span class="sp_02" style="width: 300px;" title="<%=desc %>"><%=shortWord %></span>
                            <span class="sp_02"><%=zyRS.getString("di_ShangChuanSJ") %>  上传</span>
                        </div>
                        <div class="tu_rig">
							<div class="clear"></div>
                            <div class="sp_03"></div>
                            <div class="clear"></div>
                            <div class="res-button">
                                <ul>
                                    <li>
                                    	<a target="_blank" href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanYL&cs_ZiYuanBH=<%=zyRS.getString("di_ZiYuanBH") %>">
                                    		预览
                                    	</a>
                                    </li>
                                    <li>
                                    	<%-- <a href="<%=request.getContextPath() %>/platform/qiantai/teacher/resource/downloadResource.jsp?cs_ZiYuanBH=<%=zyRS.getString("di_ZiYuanBH") %>">
                                    		下载
                                    	</a> --%>
                                    	<a onclick="ExtFunctionCM.downLoadFile('<%=zyRS.getString("di_FuJianLJ") %>','<%=zyRS.getString("di_ZiYuanMC") %>')">
                                    		下载
                                    	</a>
                                    </li>
                                    <li>
                                    	<a onclick="showResourceInfo('<%=zyRS.getString("di_ZiYuanBH") %>')" class="J_edit">
                                    		修改
                                    	</a>
                                    </li>
                                    <li>
                                    	<a onclick="delResource('<%=zyRS.getString("di_ZiYuanBH") %>')">
                                    		删除
                                    	</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
					</li>
				<%
            		}
        	    %>
                        
				</ul>
			</div>
            </div>
        </div>
        
        <!--翻页插件-->
        <div class="clear"></div>
		<div class="page-list clearfix" align="center" style="width:800px;">
			<div class="hidden">
				<html:self id="SWDY_ChaXun"/>
			</div>
			<input type="hidden" id="_qam_pagenumber_DHSJZ_JiaoXueJH" name="_qam_pagenumber_DHSJZ_JiaoXueJH"/>
			<input type="hidden" id="sum" name="sum" value="<%= pageCount %>"/>
			<a id="shang" href="javascript:SX(-1)">上一页</a>
			<%
			String currentPage = request.getParameter("_qam_pagenumber_DHSJZ_JiaoXueJH");
			if(CommonUtils.null2Blank(currentPage).length() == 0){
				currentPage = "1";
			}
			int pages=Integer.parseInt(currentPage);
			int length=0;
			if(pageCount<=7){
				//循环六次
				for(int i=1;i<=pageCount;i++){%>
					<a  id="page<%=i%>" href="javascript:click(<%=i%>)"><%=i%></a>
				<%}
			}else{
				if(pages<=3){
					for(int j=1;j<=7;j++){
					%>
						<a  id="page<%=j%>" href="javascript:click(<%=j%>)"><%=j%></a>
					<% }
				}else{
					if(pageCount<pages+3){
						for(int k=pageCount-6;k<pages-3;k++){
							%>
								<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
							<% 
						}
					}
					if(pageCount>pages+3){
						for(int k=pages-3;k<pages+4;k++){
							%>
								<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
							<% 
						}
					}else{
						for(int k=pages-3;k<pageCount+1;k++){
							%>
								<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
							<% 
						}
					}
				}%>
			<%} %>
			<a id="xia" href="javascript:SX(1)">下一页</a>
			<span class="p-num">共<%=pageCount%>页</span> 到 <input id="pageNumber" type="text" class="jp-ip" /> 页	
			<button type="button" onclick="TiaoZhuan()"  style="background:red">确定</button>
		</div>
		</html:form>
        <!--翻页插件-->
</div>
<!--内容1结束-->
</div>
</div>
</div>
</div>
<div class="clear"></div>
<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />

<!--弹出层-->
<div class="pop-box-1 hidden">
	<div class="cover"></div>
	<div class="pop-content">
		<form id="uploadForm" action="<%=path %>/uploadResource" method="post" enctype="multipart/form-data">
		<!-- 资源编号 -->
		<input type="hidden" name="di_ZiYuanBH" id="di_ZiYuanBH"/>
		<!-- 附件编号 -->
		<input type="hidden" name="di_FuJianBH" id="di_FuJianBH"/>
		<div class="title clearfix">
			<h2>添加资源</h2>
			<span class="to-close"></span>
		</div>
		<div class="box-c">
			<div class="upld-form">
				<div class="one-cell clearfix">
					<label>所属学科</label>
					<div class="mation-fillin-in">
						<c:forEach items="${keMuMap }" var="keMu" varStatus="i">
							<input type="radio" name="di_SuoShuXK" <c:if test="${i.index == 0 }">checked="checked"</c:if> value="${keMu.key }">${keMu.value }&nbsp;
						</c:forEach>
					</div>
				</div>
				<div class="one-cell clearfix">
					<label>适用年级</label>
					<div class="mation-fillin-in">
						<c:forEach items="${nianJiMap }" var="nianJi" varStatus="i">
							<input type="radio" name="di_ShiYongNJ" <c:if test="${i.index == 0 }">checked="checked"</c:if> value="${nianJi.key }">${nianJi.value }&nbsp;
						</c:forEach>
					</div>
				</div>
				<div class="one-cell clearfix">
					<label>资源类别</label>
					<div class="mation-fillin-in">
						<div style="margin-left: 100px;">
							<span style="background: rgba(0, 0, 0, 0) url('<%=style%>/images/resource/icon08.png') no-repeat scroll left center;">小学资源</span><br/>
							<div>
								<%for (int i = 0; i < list_restype.get(0).size(); i++ ) { 
									String[] type = list_restype.get(0).get(i).split("&");
								%>
									<input type="radio" <%if (i==0){out.println("checked='checked'");} %> name="di_ZiYuanLB" value="<%=type[0] %>"/><%=type[1] %>&nbsp;
								<%} %>
							</div>
							<span style="background: rgba(0, 0, 0, 0) url('<%=style%>/images/resource/icon08.png') no-repeat scroll left center;">初中资源</span>
							<div>
								<%for(int i=0;i<list_restype.get(1).size();i++ ){ String[] type=list_restype.get(1).get(i).split("&");%>
									<input type="radio" name="di_ZiYuanLB" value="<%=type[0] %>"/><%=type[1] %>&nbsp;
								<%} %>
							</div>
							<span style="background: rgba(0, 0, 0, 0) url('<%=style%>/images/resource/icon08.png') no-repeat scroll left center;">高中资源</span>
							<div>
								<%for(int i=0;i<list_restype.get(2).size();i++ ){ String[] type=list_restype.get(2).get(i).split("&");%>
									<input type="radio" name="di_ZiYuanLB" value="<%=type[0] %>"/><%=type[1] %>&nbsp;
								<%} %>
							</div>
						</div>
					</div>
				</div>
				<div class="one-cell clearfix">
					<label>媒体类型</label>
					<div class="mation-fillin-in">
						<input type="radio" checked="checked" name="di_MeiTiLX" value="1"/>电子书
						<input type="radio" name="di_MeiTiLX" value="2"/>视频
						<input type="radio" name="di_MeiTiLX" value="3"/>音频
					</div>
				</div>
				<div class="one-cell clearfix">
					<label>资源简介</label>
					<div class=mation-texat>
						<textarea rows="2" cols="100" name="di_ZiYuanJJ" id="di_ZiYuanJJ"></textarea>
					</div>
				</div>
				<div class="one-cell clearfix">
					<label>附件路径</label>
					<div class="multiselect-box">
						<input type="file" class="the-val" id="di_FuJianLJ" name="di_FuJianLJ"/>
						<div id="fuJianDIV"></div>
					</div>
				</div>
				
				<div class="one-cell clearfix" id="fengMianDIV">
					<label>封面路径</label>
					<div class="multiselect-box">
						<input type="file" class="the-val" id="di_FengMianLJ" name="di_FengMianLJ"/>
					</div>
				</div>
			</div>
		</div>
		
		<div class="box-act">
			<a href="#" class="to-close">取消</a>
			<a href="#" id="save" class="to-save" onclick="formValidate()">保存</a>
			<a href="#" id="update" class="to-save" onclick="update()">修改</a>
		</div>
		</form>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$(".u_addkc").click(function () {
		$("#save").removeClass("hidden");
		$("#update").addClass("hidden");
		
		$("#di_ZiYuanJJ").val("");
		$("#fuJianDIV").text("");
		$("#fengMianDIV").removeClass("hidden");
	})
});

// 增加资源表单验证
function formValidate() {
	// 资源简介
	var di_ZiYuanJJ = $("#di_ZiYuanJJ").val();
	if (isEmpty(di_ZiYuanJJ)) {
		alert("请输入资源简介！");
		return false;
	}
	if (beyondTheLength(di_ZiYuanJJ, 200)) {
		alert("资源简介不能超过200字符！");
		return false;
	}
	
	// 附件路径
	var di_FuJianLJ = $("#di_FuJianLJ").val();
	if (isEmpty(di_FuJianLJ)) {
		alert("请选择附件路径！");
		return false;
	}
	
	// 封面路径
	var di_FengMianLJ = $("#di_FengMianLJ").val();
	if (isEmpty(di_FengMianLJ)) {
		alert("请选择封面路径！");
		return false;
	}
	// 获得封面文件格式
	var picType = di_FengMianLJ.substring(di_FengMianLJ.lastIndexOf("."), di_FengMianLJ.length).toUpperCase();
	if (picType != ".BMP" && picType != ".PNG" && picType != ".GIF" && picType != ".JPG" && picType != ".JPEG") {
		alert("封面仅限于bmp,png,gif,jpg,jpeg格式！");
		return false;
	}
	$("#uploadForm").submit();
}

// 查看资源信息
function showResourceInfo(ziYuanBH) {
	$.ajax({
		type:"post",
		url:'<%=path%>/AjaxServlet',
		traditional:true,
		async:false,
		dataType: "json",
		data:{service:"com.rc.web.ajax.GetResourceInfo",
		parameter:["ziYuanBH"],
		value:[ziYuanBH]},
		success:function(data,textStatus,jqXHR) {
			// 显示详情弹出层
			$(".pop-box-1").removeClass("hidden");
			$("#save").addClass("hidden");
			$("#update").removeClass("hidden");
			
			// 资源信息
			var resourceInfo = data;
			// 资源编号
			$("#di_ZiYuanBH").val(resourceInfo.ZiYuanBH);
			// 附件编号
			$("#di_FuJianBH").val(resourceInfo.FuJianBH);
			
			// 所属学科
			var xueKe = resourceInfo.SuoShuXK;
			$("input[name='di_SuoShuXK']").each(function(i, e) {
				if (xueKe == e.value) {
					e.checked = "checked";
				}
			});
			// 适用年级
			var nianJi = resourceInfo.ShiYongNJ;
			$("input[name='di_ShiYongNJ']").each(function(i, e) {
				if (nianJi == e.value) {
					e.checked = "checked";
				}
			});
			// 资源类别
			var zylb = resourceInfo.ZiYuanLB;
			$("input[name='di_ZiYuanLB']").each(function(i, e) {
				if (zylb == e.value) {
					e.checked = "checked";
				}
			});
			// 媒体类型
			var mtlx = resourceInfo.MeiTiLX;
			$("input[name='di_MeiTiLX']").each(function(i, e) {
				if (mtlx == e.value) {
					e.checked = "checked";
				}
			});
			// 简介
			$("#di_ZiYuanJJ").val(resourceInfo.ZiYuanJJ);
			
			// 附件路径
			$("#fuJianDIV").text("");
			$("#fuJianDIV").append(resourceInfo.ZiYuanMC + "&nbsp;&nbsp;<a id='removeId' onclick='shanChuFJ()'>删除</a>");
			
			// 封面路径
			$("#fengMianDIV").addClass("hidden");
			
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

function shanChuFJ() {
	$("#fuJianDIV").text("");
	$("#fengMianDIV").removeClass("hidden");
}

// 修改资源
function update() {
	// 资源简介
	var di_ZiYuanJJ = $("#di_ZiYuanJJ").val();
	if (isEmpty(di_ZiYuanJJ)) {
		alert("请输入资源简介！");
		return false;
	}
	if (beyondTheLength(di_ZiYuanJJ, 200)) {
		alert("资源简介不能超过200字符！");
		return false;
	}
	
	// 原来的附件
	var old = $("#fuJianDIV").text();
	// 新附件路径
	var di_FuJianLJ = $("#di_FuJianLJ").val();
	if (!isEmpty(old)) {
		if (!isEmpty(di_FuJianLJ)) {
			alert("只能上传一个附件！");
			return false;
		}
	} else {
		if (isEmpty(di_FuJianLJ)) {
			alert("请选择附件路径！");
			return false;
		}
		
		// 封面路径
		var di_FengMianLJ = $("#di_FengMianLJ").val();
		if (isEmpty(di_FengMianLJ)) {
			alert("请选择封面路径！");
			return false;
		}
		// 获得封面文件格式
		var picType = di_FengMianLJ.substring(di_FengMianLJ.lastIndexOf("."), di_FengMianLJ.length).toUpperCase();
		if (picType != ".BMP" && picType != ".PNG" && picType != ".GIF" && picType != ".JPG" && picType != ".JPEG") {
			alert("封面仅限于bmp,png,gif,jpg,jpeg格式！");
			return false;
		}
		
	}
	
	var op = "<input type='hidden' name='operation' value='1'/>";
	$("#uploadForm").append(op);
	$("#uploadForm").submit();
}

// 删除资源
function delResource(ziYuanBH) {
	var del = confirm("确认删除？");
	if (!del)
		return;
	
	$.ajax({
		type:"post",
		url:'<%=path%>/AjaxServlet',
		traditional:true,
		async:false,
		dataType: "json",
		data:{service:"com.rc.web.ajax.DelResource",
		parameter:["ziYuanBH"],
		value:[ziYuanBH]},
		success:function(data,textStatus,jqXHR) {
			// 刷新页面
			$("#selectForm").attr("action", "<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanUpload&cs_MeiTiLX=<%=cs_MeiTiLX %>&cs_ZiYuanLB=<%=cs_ZiYuanLB %>");
			$("#selectForm").submit();
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

// 设置当图片加载失败时，显示默认图片
$(".sp_01>img").one("error", function() {
	$(this).attr("src", "<%=style%>/images/logo.png");
});
</script>
<script type="text/javascript">
	//提交分页
	function pageSubmit() {
		$("#_qam_turnpageflag").val("true");
		$("#selectForm").attr("action", "<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanUpload&cs_MeiTiLX=<%=cs_MeiTiLX %>&cs_ZiYuanLB=<%=cs_ZiYuanLB %>");
		$("#selectForm").submit();
	}
  
  	//点击确定
   	function TiaoZhuan() {
   		var num=$("#pageNumber").val();
	  	var reg = new RegExp("^[0-9]*$");  
	  	if(!reg.test(num)){
	  		// 输入的不是数字时跳转到第一页
	  		num = "1";
	  	}
	  	if($("#sum").val()==1){
	  		num = "1";
	  	}
	  	// 总页数
	  	var sum = $("#sum").val();
	  	if (parseInt(num) < 1 || parseInt(num) > sum) {
	  		num = "1";
	  	}
   		$("#_qam_pagenumber_DHSJZ_ChaXun").val(num);
   		//控制当前页码
   		pageSubmit();
   	}
  	
	//点击页码
	function click(i) {
		$("#_qam_pagenumber_DHSJZ_ChaXun").val(i);
		pageSubmit();
  	}
	
	//点击上一页和下一页
	function SX(e) {
		// 总页数
		var pageCount = "${pageCount}";
		// 当前页
		var currentPage = $("#_qam_pagenumber_DHSJZ_ChaXun").val();
		// 目标页
		var targetPage = parseInt(currentPage) + (e);
		if (targetPage >= 1 && targetPage <= parseInt(pageCount)) {
			$("#_qam_pagenumber_DHSJZ_ChaXun").val(targetPage);
			pageSubmit();
		}
	}

	$(function(){
		var currentPage = $("#_qam_pagenumber_DHSJZ_ChaXun").val();
		if (currentPage == "0") {
			currentPage = "1";
		}
		//样式
		$("#page"+$("#_qam_pagenumber_DHSJZ_ChaXun").val()).addClass("cur");
		//给文本框赋值
		$("#pageNumber").val(currentPage);
	});
</script>	
</body>
</html>