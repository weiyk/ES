<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@page import="com.rc.web.extension.component.resource.ResourceHelper"%>
<%@page import="com.qam.framework.util.CommonUtils"%>
<%@page import="java.util.*"%>
<%@ taglib uri="qamer-html" prefix="html"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	//imgUrl
	String url = (String) request.getSession().getAttribute("imgUrl");
	//资源类型
	String keyword = request.getParameter("keyword");
	//分页相关参数 
	String currentPage = request.getParameter("currentPage");
	if(CommonUtils.null2Blank(currentPage).length() == 0){
		currentPage = "1";
	}
	//资源类别
	String ziyuanlb=request.getParameter("ziyuanlb");
	//媒体类型
	String meitilx=request.getParameter("meitilx");
	//获取搜索资源
	ResourceHelper rshelp = new ResourceHelper();
	List<List<String>> list = rshelp.getResourceBySearch(keyword,ziyuanlb,meitilx,currentPage,"10",null,null,null,null); 
	List<String> list_cout=null;
	List<String> list_res=null;
	if(list.size()>0){
		list_cout=list.get(0);
		list_res=list.get(1);
	}
	
	int sum=0;//总页数
	int totalnum=0;//总条数
	if(list_cout!=null&&list_cout.get(0)!=null){
		totalnum=Integer.parseInt(list_cout.get(0));
		sum=Integer.parseInt(list_cout.get(0));
		}
	if(sum%10==0){
		sum=(int)sum/10;
	}else{
		sum=((int)sum/10)+1;
	}
	request.setAttribute("sum",sum);//保存至内置对象
	//获取资源类别
	List<List<String>> list_restype=rshelp.getType();
	
	// 学段信息
	Map<String, String> stageMap = new LinkedHashMap<String, String>();
	// 年级信息
	Map<String, String> gradeMap = new LinkedHashMap<String, String>();
	// 出版社信息
	Map<String, String> publishMap = new LinkedHashMap<String, String>();
	// 课程科目信息
	Map<String, String> subjectMap = new LinkedHashMap<String, String>();
	
	// 查询集合域
	IDataBaseAccess dbm = null;
	ResultSet rs = null;
	try {
		dbm = ContextService.lookupDefaultDataBaseAccess();
		dbm.openConnection();
		// 查询集合列表
		String sql = "select JiHeYLX, BianMa, Zhi from qam_jiheyz where ZhuangTai=1 and " 
			+ "JiHeYLX in ('JH_XueDuan', 'JH_NianJi', 'JH_KeBenLX', 'JH_KeMu') order by JiHeYLX";
		rs = dbm.executeQuery(sql);
		
		String type = null;
		while (rs.next()) {
			// 集合域类型
			type = rs.getString("JiHeYLX");
			if (type != null) {
				if ("JH_XueDuan".equals(type)) {
					// 学段
					stageMap.put(rs.getString("BianMa"), rs.getString("Zhi"));
				} else if ("JH_NianJi".equals(type)) {
					// 年级					
					gradeMap.put(rs.getString("BianMa"), rs.getString("Zhi"));
				} else if ("JH_KeBenLX".equals(type)) {
					// 出版社					
					publishMap.put(rs.getString("BianMa"), rs.getString("Zhi"));
				} else if ("JH_KeMu".equals(type)) {
					// 科目
					subjectMap.put(rs.getString("BianMa"), rs.getString("Zhi"));
				}
			}
		}
		
		request.setAttribute("stageMap", stageMap);
		request.setAttribute("gradeMap", gradeMap);
		request.setAttribute("publishMap", publishMap);
		request.setAttribute("subjectMap", subjectMap);
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null)
			rs.close();
		if (dbm != null)
			dbm.closeConnection();
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>课程中心</title>
<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
<link href="<%=resource_style%>/common.css" rel="stylesheet" type="text/css" />
<link href="<%=resource_style%>/resource.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=style%>/js/base.js"></script>
<script type="text/javascript" src="<%=style%>/js/sea.js"></script>
</head>
<html:dialog id="GNDH_KeChengZX" state="DHZT_ChaXun"/>
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
<html:form>
	<div class="wrap clearfix">
		<div class="wrap clearfix" style="height:auto;">
			<div class="res-content">
				<div class="layout">
					<div class="res-search fl">
						<div class="search-left fl">
							<form action="" method="post" target="spare"> 
								<input name="keyword" placeholder="请输入关键词" value="<%if(keyword!=null){out.println(keyword);} %>" onfocus="javascript:if(this.value=='请输入关键词'){this.value='';this.style.color='#666'}" onblur="javascript:if(this.value==''){this.value='请输入关键词';this.style.color='#999'}" class="search-text" type="text"/> 
								<input class="search-button" value="资源搜索" type="submit"/> 
							</form>
						</div>
					</div>
					<div class="clear"></div>
					<div class="sea-right fl">
						<div class="search-content fl">
							<!-- 学段 -->
							<ul>
								<li class="list-class">学段：</li>
								<% if("null".equals(ziyuanlb)||ziyuanlb==null||"total".equals(ziyuanlb)){ %>
								<li><a class="reslist-click" href="javascript:zylb_click('total')">全部</a></li>
								<%}else{ %>
								<li><a class="" href="javascript:zylb_click('total')">全部</a></li>
								<%} %>
								<c:forEach items="${stageMap }" var="stage">
									<li><a class="" href="">${stage.value }</a></li>
								</c:forEach>
							</ul>
							
							<!-- 年级 -->
							<ul>
								<li class="list-class">年级：</li>
								<%if("null".equals(meitilx)||meitilx==null||"total".equals(meitilx)){ %>
								<li><a class="reslist-click" href="javascript:mtlx_click('total')">全部</a></li>
								<%}else{ %>
								<li><a class="" href="javascript:mtlx_click('total')">全部</a></li>
								<%} %>
								
								<c:forEach items="${gradeMap }" var="grade">
									<li><a class="" href="">${grade.value }</a></li>
								</c:forEach>
							</ul>
							
							<!-- 出版社 -->
							<ul>
								<li class="list-class">出版社：</li>
								<li><a class="reslist-click"
									href="http://localhost/hs_edu/index.php?m=resource&amp;c=index&amp;a=serach&amp;keyword=%E5%85%AD%E5%B9%B4%E7%BA%A7&amp;userType=&amp;showType=grid&amp;cateId=&amp;typeId=&amp;subjectId=&amp;gradeId=&amp;classId=&amp;chapterId=">全部</a>
								</li>
								
								<c:forEach items="${publishMap }" var="publish">
									<li>
										<a class="" href="">${publish.value }</a>
									</li>
								</c:forEach>
							</ul>
							
							<!-- 科目 -->
							<ul>
								<li class="list-class">课程科目：</li>
								<li><a class="reslist-click"
									href="http://localhost/hs_edu/index.php?m=resource&amp;c=index&amp;a=serach&amp;keyword=%E5%85%AD%E5%B9%B4%E7%BA%A7&amp;userType=&amp;showType=grid&amp;cateId=&amp;typeId=&amp;subjectId=&amp;gradeId=&amp;classId=&amp;chapterId=">全部</a>
								</li>
								
								<c:forEach items="${subjectMap }" var="subject">
									<li><a class=""
										href="">${subject.value }</a>
									</li>
								</c:forEach>
							</ul>
						</div>

						<div class="lei_count">
							<!--列表内容切换开始-->
							<div class="list-content">
								<div class="sea-switchbox">
									<ul class="search-nav">
									</ul>
								</div>
								<div class="aui-switch-list">
									<div class="list-wrap">
										<!-- grid 展示-->
										<div class="aui-switch-grid" id="grid">
                            				<div class="grid-content">
                            				<%
                            				// 课程列表
                            				RecordSet keChengRS = executeResult.getRecordSet("SWDY_KeChengCX");
                            				while (keChengRS.next()) {
                            				%>
                                            	<div class="grid-content-box">
                                   					 <div class="resource-name">
														<a href="" target="_blank">
                                                 		 <img src="<%=style%>/images/title-iconfont-shuss.png" width="177" height="200" class="tu_lei"/>
                                                 		</a>
                                                   	 	<a href="" target="_blank">
                                                   	 	 	<%=keChengRS.getString("di_XueDuan") + keChengRS.getString("di_NianJi") %>&nbsp;&nbsp;
                                                   	 	 	<%=keChengRS.getString("di_KeMu") %>&nbsp;&nbsp;
                                                   	 	 	<%=keChengRS.getString("di_JianLiR") %>
                                                   	 	</a>
                                                    	<br/>
                                   					 </div>
                               					 </div>
                            				<%	
                            				}
                            				%>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--tab结束-->

							<!--翻页插件-->
							<div class="clear"></div>
							<input type="hidden" name="currentPage" value="<%=currentPage %>" id="currentPage"/>
							<input type="hidden" name="keyword" value="<%=keyword %>" id="keyword"/>
							<input type="hidden" name="ziyuanlb" value="<%=ziyuanlb %>" id="ziyuanlb"/>
							<input type="hidden" name="meitilx" value="<%=meitilx %>" id="meitilx"/>
							<div class="page-list clearfix" align="center">
		<a id="shang" href="javascript:SX(1,<%=sum%>)">上一页</a>
		<%
		int pages=Integer.parseInt(currentPage);
		int length=0;
		if(sum<=7){
			//循环六次
			for(int i=1;i<=sum;i++){%>
				<a  id="page<%=i%>" href="javascript:click(<%=i%>)"><%=i%></a>
			<%}
		}else{
			if(pages<=3){
				for(int j=1;j<=7;j++){
				%>
					<a  id="page<%=j%>" href="javascript:click(<%=j%>)"><%=j%></a>
				<% }
			}else{
				if(sum<pages+3){
					for(int k=sum-6;k<pages-3;k++){
						%>
							<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
						<% 
					}
				}
				if(sum>pages+3){
					for(int k=pages-3;k<pages+4;k++){
						%>
							<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
						<% 
					}
				}else{
					for(int k=pages-3;k<sum+1;k++){
						%>
							<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
						<% 
					}
				}
			}%>
		<%} %>
		<a id="xia" href="javascript:SX(2,<%=sum%>)">下一页</a>
		<span class="p-num">共<%=sum%>页</span> 到 <input id="wenben" type="text" class="jp-ip" /> 页	
		<button type="button" onclick="TiaoZhuan()"  style="background:red">确定</button>
	</div>

							<!--翻页插件-->

						</div>

						<!--内容1结束-->

					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="clear"></div>
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
		document.forms[0].action="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanSS";
		document.forms[0].submit();
	}
  //点击确定
	function TiaoZhuan(){
	  	var num=$("#wenben").val();
	  	var sum='<%=sum%>';
	  	if(Number(num)>Number(sum)){
	  		$("#wenben").val("1");
	  	}
	  	var reg = new RegExp("^[0-9]*$");  
	  	if(!reg.test(num)){
	  		$("#wenben").val("1");
	  	}
	  	if(num<1){
	  		$("#wenben").val("1");
	  	}
		$("#currentPage").val($("#wenben").val());
		//控制当前页码
		pageSubmit();
	}
  //点击页码
	function click(i){
		$("#currentPage").val(i);
		pageSubmit();
  }
  //点击资源类别
  function zylb_click(i){
		$("#ziyuanlb").val(i);
		pageSubmit();
  }
  //点击媒体类型
  function mtlx_click(i){
		$("#meitilx").val(i);
		pageSubmit();
  }
//点击上一页和下一页
function SX(e,sum){
	var s=$("#currentPage").val();
	if(e==1){//上一页
		if(s>1){
			s=s-1;
			$("#currentPage").val(s);
			pageSubmit();
		}
	}else if(e==2){//下一页 
		if(s<sum){
			s=parseFloat(s)+1;
			$("#currentPage").val(s);
			pageSubmit();
		}
	}
}
}
</script>
</body>
</html>
