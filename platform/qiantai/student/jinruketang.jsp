<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.ParseException" %>
<%@page import="com.rc.web.extension.component.getjiekouxx.GetInterfacesValue" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="java.util.Map"%>
<%@page import="com.rc.web.extension.component.tongxinlu.insertTongXinL"%>
<%-- 平台 --%>
	<%@include file="/common/framework.jspf"%>
<%!
private static String getTime(String createDate) throws ParseException{
	createDate=Long.parseLong(createDate)+(long)8*60*60*1000+"";
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:SS");//小写的mm表示的是分钟  
	Date date =new Date();
	String value="";
	long day=(date.getTime()-Long.parseLong(createDate))/(60*1000);//
	//Date datezss= new Date(Long.parseLong(createDate));
	//System.out.println(sdf.format(datezss));
	int hh=(int)day/60;  //共计小时数
	int dd=(int)hh/24;   //共计天数
	if(day>=60){
		if(hh>=24){
			if(dd>2){
				SimpleDateFormat sdfD=new SimpleDateFormat("yyyy-MM-dd");
				Date datez= new Date(Long.parseLong(createDate));
				value=sdfD.format(datez);
			}else{
				value=dd+"天前";
			}
		}else{
			value=hh+"小时前";
		}
	}else if(day<0){
		value="1分钟前";
	}else{
		value=day+"分钟前";
	}
	return value;
}
%>
<%!
	public String getValue(String style,String json,int page,String imgUrl) throws ParseException{
		StringBuffer html=new StringBuffer();
		JSONArray array = JSONArray.fromObject(json);
		if(page>array.size()){
			page=array.size();
		}
		for(int j = 0; j < page; j++) {
			JSONObject jsonObject_post = array.getJSONObject(j);
			String createDate =jsonObject_post.get("created_at").toString();
			//String updateDate=jsonObject_post.get("updated_at").toString();
			String id=jsonObject_post.get("id").toString();
			String likeCount=jsonObject_post.get("likeCount").toString();
			String uid=jsonObject_post.get("userId").toString();
			GetInterfacesValue inter=new GetInterfacesValue();
			Map<String,String> map=inter.getUser(uid);
			html.append("<li>");
			html.append("<div class=\"cell-4\"><img width=\"50px\" height=\"50px\" src=\""+imgUrl+map.get("image")+"\" /></div>");
			html.append("<span class=\"cell-1\">");
			html.append("<div class=\"lys-wdyx\">"+map.get("xingming")+"</div> ");
			html.append("<div class=\"timefz-jrkteb\">"+getTime(createDate)+"</div><br />");
			html.append("<div class=\"ssss\"></div><br /><div class=\"content-jrkteb\">");
			html.append(jsonObject_post.get("content").toString());
			html.append("</div><br /></span>");
			//html.append("<div class=\"act clearfix\"><div class=\"alink fr\">");
			//html.append("<a id=\"tj"+id+"\" href=\"javascript:add('"+id+"','"+likeCount+"')\" class=\"cur\" ><s class=\"al-tj\"></s>推荐("+likeCount+")</a>");
			//html.append("<a href=\"#\" class=\"cur\"><s class=\"al-pl\"></s>评论("+jsonObject_post.get("commentCount").toString()+")</a>");
			//html.append("<a href=\"#\"><s class=\"al-yl\"></s>预览(16)</a>");
			//html.append("</div></div></div>");
			html.append("</li>");
		}
	return html.toString();
}
%>
<%
//获取样式
String style=request.getContextPath()+"/style";
//获取路径
String path=request.getContextPath();
%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>进入课堂</title>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
</head>
<%
	String kechengmc=(String)request.getParameter("KeChengMC");
	String schoolName=(String) session.getAttribute("schoolName");
	String kechengbh=(String)request.getParameter("KeChengBH");
	String yonghubh=(String) session.getAttribute("XiTongHYBH");
	String key=(String) session.getAttribute("QuanZhi");
	String pagesize=(String)request.getParameter("pagesize");
	if("".equals(pagesize)||pagesize==null){
		pagesize="1";
	}
	GetInterfacesValue	getInterfacesValue=new GetInterfacesValue();
	String json=getInterfacesValue.getJson(pagesize,yonghubh,key,kechengbh);
	int count=getInterfacesValue.getPageCount(yonghubh,key,kechengbh);
	String yonghuxm =(String)session.getAttribute("YONGHUXM");
	int sum=count/3;
	if(count<3){
		sum=1;
	}
	if(count%3>0){
		sum+=1;
	}
	String image=(String)request.getSession().getAttribute("Image");
	String imgUrl=(String)request.getSession().getAttribute("imgUrl");
	insertTongXinL txl=new insertTongXinL();
	txl.insertTXL(yonghubh,"",key,kechengbh);
%>
<body>

<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengGRKJ"  class="user-name blk"><%=yonghuxm %></a> <%=schoolName %> <a href="<%=path%>/servlet/desktop.html" class="to-quit">退出</a></p>
	</div>
</div>
<!-- 头部 -->
<div class="header green-head">
	<div class="in-box wrap clearfix">
		<div class="logo fl">
			<a href="#">双轨数字学校</a>
		</div>
		<ul class="nav fr">
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengKJ" >首页</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueYiXue" class="cur">学一学</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_DuYiDu">读一读</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LianYiLian">练一练</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_CeYiCe">测一测</a></li>
		</ul>
	</div>
</div>
<div class="wrap clearfix">
	<div class="fl mt-20 w-710">
		<input type="hidden" id="di_BianHao" value="<%=kechengbh%>"/>

		<!-- 正在直播 -->
		<div class="at-live mt-10">
			<div class="title-bar green-title clearfix">
				<h2 class="fl">正在直播</h2>
				<a href="<%=path %>/platform/qiantai/student/jinketang.jsp"><input type="button" value="返回" class="wlkc-70" /></a>
			</div>
			<div class="box-c-jrkteb mt-10">
				<div class="pic">
					<a href="#">
						<span class="cover"></span>
						<!-- <img src="images/student/jinketang-kc1.jpg" alt="" /> -->
						 <script type="text/javascript">
						
						var swf_width=710  //改视频宽度
						var swf_height=400//改视频高度
						var texts=''
						var files='<%=style%>/video/www.flv' //视频路径地址
						var config='0:自动播放|1:连续播放|100:默认音量|0:控制栏位置|2:控制栏显示|0x000033:主体颜色|60:主体透明度|0x66ff00:光晕颜色|0xffffff:图标颜色|0xffffff:文字颜色|:logo文字|:logo地址|:结束swf地址'
						
						
						document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ swf_width +'" height="'+ swf_height +'">');
						document.write('<param name="movie" value="vcastr2.swf"><param name="quality" value="high">');
						document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
						document.write('<param name="FlashVars" value="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'">');
						document.write('<embed src="vcastr2.swf" wmode="opaque" FlashVars="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'" menu="false" quality="high" width="'+ swf_width +'" height="'+ swf_height +'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); document.write('</object>'); 
						
						
						</script>						
					</a>
				</div>
			</div>
			<div class="info-jrkreb mt-10">
				<a href="#"><img src="<%=style%>/images/app-jrkt-scwx.png" /><span>收藏</span></a>
				<a href="#"><img src="<%=style%>/images/app-jrkt-share.png" /><span>分享</span></a>
			</div>
		</div>
	</div>

	<div class="fr w-230 std-side">
	 <html:form>
		<div class="kcb-side mt-20">
			<div class="side-title clearfix">
				<h3>二年级语文《小马过河》</h3>
			</div>
			<div class="jrkteb-zjr">
				<div class="fb-msg">
					<div class="clearfix">
                        <!--新星评价-->

                        <div class="star-button">
                            <ul class="rating">
                                     <li><img src="<%=style%>/images/Star_Copy_unselected.png" /></li>
                                     <li><img src="<%=style%>/images/Star_Copy_unselected.png" /></li>
                                     <li><img src="<%=style%>/images/Star_Copy_unselected.png" /></li>
                                     <li><img src="<%=style%>/images/Star_Copy_unselected.png" /></li>
                                     <li><img src="<%=style%>/images/Star_Copy_unselected.png" /></li>
                            </ul>
                            <div class="jrktzjb-pj">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;78人评价</div>
                         </div>
                         <div class="jrktzjb-zjr-lb">主讲人：宋保华</div>
						 <div class="side-title clearfix">
							<ul class="clearfix">
								 <li class="cur"><a href="javascript:;">讨论</a></li>
								 <li ><a href="javascript:;">笔记</a></li>
								 <li ><a href="javascript:;">作业</a></li>
							</ul>
		
						</div>
						<div class="select-box select-b-dy fl">
							<input type="hidden" value=""  class="the-val" />
							<div class="select-cover">
								<span class="df-val">综合讨论区</span>
								<em class="icon"></em>
							</div>
							<ul class="clearfix hidden">
								<li><a href="javascript:;" rel="dy-1">综合讨论区</a></li>
								<li><a href="javascript:;" rel="dy-2">单独讨论区</a></li>
							</ul>
						</div>
					</div>
					<div class="fb-area-jrkteb mt-10">
						<textarea id="fabiaotl" rows="5" style="width: 100%" cols=""></textarea>
					</div>
					<div class="rjkteb-btn mt-10">
                        <input type="button" value="发起讨论" class="wlkc-81" onclick="start()"/>
					</div>
					<script type="text/javascript">
				
					function start(){
						var neirong=$('#fabiaotl').val();
						if(!neirong){
							alert('请输入内容！');
							return false;
						}else{
							var kechenbh=$('#di_BianHao').val();
							$.ajax({
								url:'/eschool/servlet/AjaxServlet',
								type:"post",
								traditional:true,
								async:false,
								data:{service:"com.rc.web.ajax.setFaBiaoTLService",
									parameter:["NeiRong","kechengbh","kechengmc"],
									value:[neirong,kechenbh,'<%=kechengmc%>']},
								success: function(result){
									document.forms[0].action="<%=path %>/platform/qiantai/student/jinruketang.jsp?pagesize=1&KeChengBH="+kechenbh;
									document.forms[0].submit();
									alert("发布成功！");
								},
								error: function(err) {
									if('_qam_ajax_error'==result){
										alert("发布失败！");
									}else{
										
									}
					                
					            }
							});
						}
					}
					function pageSubmit(i){
						var sum=$('#pageSum').val();
						var kechenbh=$('#di_BianHao').val();
						document.forms[0].action="<%=path %>/platform/qiantai/student/jinruketang.jsp?pagesize="+i+"&&KeChengBH="+kechenbh;
						document.forms[0].submit();
					}
			    	//点击确定
			    	function TiaoZhuan(){
			    		var sun=$("#wenben").val();
			    		$("#pageNumber").val(sun);//控制当前页码
			    		pageSubmit(sun);
			    	}
			    	//点击上一页和下一页
			    	function SX(e,sum){
			    		var s=$("#pageNumber").val();
			    		if(e==1){//上一页
			    			if(s>1){
			    				s=s-1;
			    				$("#pageNumber").val(s);
			    				pageSubmit(s);
			    			}else{
			    				alert("当前页为首页");
			    			}
			    		}else if(e==2){//下一页 
			    			if(s<sum){
			    				s=parseFloat(s)+1;
			    				$("#pageNumber").val(s);
			    				pageSubmit(s);
			    			}else{
			    				alert("当前页为尾页");
			    			}
			    		}
			    	}
					</script>
				</div>
			</div>
			<div class="jrkceb-centent">
						<ul class="clearfix">
							<%=getValue(style,json,3,imgUrl) %>	
						</ul>
			</div>
			<div class="page-list clearfix">
				<input type="hidden" id="pageNumber" value="<%=pagesize%>"/>
				<input type="hidden" id="pageSum" value="<%=sum%>"/>
					<a id="shang" href="javascript:SX(1,<%=sum%>)">上一页</a>
					<a id="xia" href="javascript:SX(2,<%=sum%>)">下一页</a>
				</div>
		</div>
 </html:form>
	</div>
	

</div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />


</body>
</html>

