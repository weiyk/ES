<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@page import="com.rc.web.extension.component.resource.ResourceHelper"%>
<%@page import="com.qam.framework.util.CommonUtils"%>
<%@page import="java.util.*"%>
<%@ taglib uri="qamer-html" prefix="html"%>
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
	
	//判断展示方式
	String showview =request.getParameter("showview");
	String display_list="block";
	String display_grid="none";
	if(showview==null||"list".equals(showview)){
		display_list="block";
		display_grid="none";
		showview ="list";
	}else{
		display_list="none";
		display_grid="block";
		showview ="grid";
	}
%>
<html>
<head>
<base target="_self"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%-- 平台 --%>
<%@ include file="/common/script/ExtFunctionCM.jspf" %>
<title>资源中心</title>
<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
<link href="<%=resource_style%>/common.css" rel="stylesheet" type="text/css" />
<link href="<%=resource_style%>/resource.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=style%>/js/base.js"></script>
<script type="text/javascript" src="<%=style%>/js/sea.js"></script>
<style type="">
 .to-sub {
    background: #2cb4f3 none repeat scroll 0 0;
    border: 0 none;
    color: #fff;
    cursor: pointer;
    font-weight: bold;
    height: 38px;
    line-height: 38px;
    margin-left: 10px;
    vertical-align: middle;
    width: 60px;
}
</style>
</head>

<body>
<html:form>
	<div class="wrap clearfix">
		<div class="wrap clearfix" style="height:auto;">
			<div class="res-content">
				<div class="layout">
					<!--搜索框开始-->
					<!--二级导航结束--->
					<div class="res-search fl">
						<div class="search-left fl">
							<form action="" method="post" target="spare"> 
								<input name="keyword" placeholder="请输入关键词" value="<%if(keyword!=null){out.println(keyword);} %>" onfocus="javascript:if(this.value=='请输入关键词'){this.value='';this.style.color='#666'}" onblur="javascript:if(this.value==''){this.value='请输入关键词';this.style.color='#999'}" class="search-text" type="text"/> 
								<input class="search-button" value="资源搜索" type="submit"/> 
							</form>
						</div>
						<div class="search-right fl">
							<p>检索不方便？ 试试资源搜索</p>
						</div>
					</div>
					<div class="clear"></div>
					<% if (keyword != null) {%>
						<div class="newr">
							检索到包含关键字“<span class="newr-text"><%=keyword%></span>”的资源<%=totalnum %>条
						</div>
					<% } %>
					<!--内容1开始-->
					<div class="sea-right fl">
						<div class="search-content fl">
							<ul>
								<li class="list-class">资源类别：</li>
								<% if("null".equals(ziyuanlb)||ziyuanlb==null||"total".equals(ziyuanlb)){ %>
								<li><a class="reslist-click" href="javascript:zylb_click('total')">全部</a></li>
								<%}else{ %>
								<li><a class="" href="javascript:zylb_click('total')">全部</a></li>
								<%} %>
							</ul>
							<ul>
								<%if(list_restype.size()>0){for(int i=0;i<list_restype.get(0).size();i++ ){ String[] type=list_restype.get(0).get(i).split("&"); %>
									<%if(type[0].equals(ziyuanlb)){%> 
									<li><a class="reslist-click"
										href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 10px;"><%=type[1] %>(小)</span></a>
									</li>
									<%} else{%>
									<li><a class=""
										href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 10px;"><%=type[1] %>(小)</span></a>
									</li>
									<%} %>
								<%} }%>
							</ul>
							<ul>
								<%if(list_restype.size()>0){for(int j=0;j<list_restype.get(1).size();j++ ){ String[] type=list_restype.get(1).get(j).split("&"); %>
									<%if(type[0].equals(ziyuanlb)){%>
									<li><a class="reslist-click"
										href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 10px;"><%=type[1] %>(初)</span></a>
									</li>
									<%} else{%>
									<li><a class=""
										href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 10px;"><%=type[1] %>(初)</span></a>
									</li>
									<%} %>
								<%} }%>
							</ul>
							<ul>
								<%if(list_restype.size()>0){for(int k=0;k<list_restype.get(2).size();k++ ){ String[] type=list_restype.get(2).get(k).split("&"); %>
									<%if(type[0].equals(ziyuanlb)){%>
									<li><a class="reslist-click"
										href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 10px;"><%=type[1] %>(高)</span></a>
									</li>
									<%} else{%>
									<li><a class=""
										href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 10px;"><%=type[1] %>(高)</span></a>
									</li>
									<%} %>
								<%} }%>
							</ul>
							<ul>
								<li class="list-class">媒体类型：</li>
								<%if("null".equals(meitilx)||meitilx==null||"total".equals(meitilx)){ %>
								<li><a class="reslist-click" href="javascript:mtlx_click('total')">全部</a></li>
								<%}else{ %>
								<li><a class="" href="javascript:mtlx_click('total')">全部</a></li>
								<%} %>
								
								<%if("1".equals(meitilx)){%>
								<li><a class="reslist-click"
									href="javascript:mtlx_click(1)">电子书</a>
								</li>
								<%} else{%>
								<li><a class=""
									href="javascript:mtlx_click(1)">电子书</a>
								</li>
								<%} %>
								
								<%if("2".equals(meitilx)){%>
								<li><a class="reslist-click"
									href="javascript:mtlx_click(2)">视频</a>
								</li>
								<%} else{%>
								<li><a class=""
									href="javascript:mtlx_click(2)">视频</a>
								</li>
								<%} %>
								
								<%if("3".equals(meitilx)){%>
								<li><a class="reslist-click"
									href="javascript:mtlx_click(3)">音频</a>
								</li>
								<%} else{%>
								<li><a class=""
									href="javascript:mtlx_click(3)">音频</a>
								</li>
								<%} %>
							</ul>
							<!--  
							<ul>
								<li class="list-class">文件格式：</li>
								<li><a class="reslist-click"
									href="http://localhost/hs_edu/index.php?m=resource&amp;c=index&amp;a=serach&amp;keyword=%E5%85%AD%E5%B9%B4%E7%BA%A7&amp;userType=&amp;showType=grid&amp;cateId=&amp;typeId=&amp;subjectId=&amp;gradeId=&amp;classId=&amp;chapterId=">全部</a>
								</li>
								<li><a class=""
									href="http://localhost/hs_edu/index.php?m=resource&amp;c=index&amp;a=serach&amp;keyword=%E5%85%AD%E5%B9%B4%E7%BA%A7&amp;userType=&amp;showType=grid&amp;cateId=&amp;typeId=&amp;extension=rar&amp;subjectId=&amp;gradeId=&amp;classId=&amp;chapterId=">rar</a>
								</li>
								<li><a class=""
									href="http://localhost/hs_edu/index.php?m=resource&amp;c=index&amp;a=serach&amp;keyword=%E5%85%AD%E5%B9%B4%E7%BA%A7&amp;userType=&amp;showType=grid&amp;cateId=&amp;typeId=&amp;extension=zip&amp;subjectId=&amp;gradeId=&amp;classId=&amp;chapterId=">zip</a>
								</li>
							</ul>
							-->
						</div>

						<div class="lei_count" style="width: 1000px;">
							<!--列表内容切换开始-->
							<div class="list-content">
								<div class="sea-switchbox">
								</div>
								<div class="aui-switch-list">
									<div class="list-wrap">
										<div class="aui-switch-list" style="display: <%=display_list %>;" id="list">
											<div class="list-wrap">
												<ul id="featured">
												<%if(list_res != null) {
													for ( int i = 0; i < list_res.size(); i++ ) {
														String[] res = list_res.get(i).split("&");
												%>
													<li class="sea-icn">
														<!--图标-->
														<div class="tu_lef">
															<span class="list-bg"></span>
														</div>
														<div class="tu_mid">
															<span class="sp_01">
																<img src="<%=url %><%=res[0] %>" class="tu_lei" height="20"/>
																<%=res[2] %>
															</span>
															<p class="res-brief">简介：</p>
															<%=res[3].length()<=45?res[3]:res[3].substring(0,45) %></span> 
															<span class="sp_02"></span> 
															<span class="sp_02"></span> 
															<span class="sp_02"><%=res[4] %>上传</span>
														</div>
														<div class="tu_rig">
															<div class="res-button">
																<ul>
																	<li>
																		<a onclick="selectResource('<%=res[2] %>', '<%=res[0] %>', '<%=res[6]%>')">选择</a>
																	</li>
																</ul>
															</div>
														</div>
													</li>
												<%}	// for END 
											} //IF END%>
												</ul>
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
							<input type="hidden" name="showview" value="<%=showview %>" id="showview"/>
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
	
<script type="text/javascript">
	// 提交表单后不弹出新窗口
	window.name = "spare";
	
	// 选择资源
	function selectResource(name, img, resource) {
		var obj = new Object();
		obj.name = name;
		obj.img = img;
		obj.resource = resource;
		window.returnValue = obj;
		window.close();
	}
</script>
<script type="text/javascript">
$(function(){
	//样式
	$("#page"+$("#currentPage").val()).addClass("cur");
	//给文本框赋值
	$("#wenben").val($("#currentPage").val());
});
//提交分页
    function pageSubmit(){
		document.forms[0].action="<%=request.getContextPath() %>/platform/qiantai/teacher/dianxuanziyuan.jsp";
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
</script>
</body>
</html>
