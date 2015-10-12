<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.ParseException" %>
<%@page import="com.rc.web.extension.component.getjiekouxx.GetInterfacesValue" %>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="com.rc.web.extension.component.tongxinlu.insertTongXinL"%>
<%@page import="java.util.Map,java.net.*"%>

<%
//获取样式
String style=request.getContextPath()+"/style";
//获取路径
String path=request.getContextPath();
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<%@include file="/common/framework.jspf" %>
	<%@include file="/common/jquery.jspf" %>
	<%@include file="/common/ckeditor.jspf"%>
	<title>学习目标</title>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
</head>

<body>
<%
	String kechengbh=(String)request.getParameter("KeChengBH");
	String keshibh=(String)request.getParameter("KeShiBH");
	String yonghubh=(String) session.getAttribute("XiTongHYBH");
	String schoolName=(String) session.getAttribute("schoolName");
	String key=(String) session.getAttribute("QuanZhi");
	String yonghuxm =(String)session.getAttribute("YONGHUXM");
	String image=(String)request.getSession().getAttribute("Image");
	String imgUrl=(String)request.getSession().getAttribute("imgUrl");

%>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengGRKJ&" class="user-name blk"><%=yonghuxm %></a> <%=schoolName %> <a href="<%=path%>/servlet/desktop.html" class="to-quit">退出</a></p>
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
	<%
		StringBuffer sql=new StringBuffer();
		sql.append("SELECT  DISTINCT JSKJ_KeShi.KeChengBH ,JSKJ_KeShi.KeShiMC ,JSKJ_KeCheng.NianJi  ,( (select zhi from qam_jiheyz where JiHeYLX='JH_NianJi' and BianMa=NianJi) )  ,JSKJ_KeCheng.KeMu  ,( (select zhi from qam_jiheyz where JiHeYLX='JH_KeMu' and BianMa=KeMu) ) AS KeMuMC ,JSKJ_KeShi.BianHao   FROM jskj_kecheng jskj_kecheng,jskj_keshi jskj_keshi WHERE 1=1  AND UPPER(jskj_keshi.bianhao) =UPPER('"+keshibh+"')   AND jskj_keshi.kechengbh = jskj_kecheng.bianhao   ");
		//循环生成课程列表
		String szwz="";
		String zsmb="没有填写相关信息！";
		String gcmb="没有填写相关信息！";
		String qgmb="没有填写相关信息！";
		IDataBaseAccess dbm = null;
		      try{
		      	dbm = ContextService.lookupDefaultDataBaseAccess();
		  		dbm.openConnection();
		  		ResultSet rs = dbm.executeQuery(sql.toString());
		  		while(rs.next()){
		  			szwz=rs.getString(4)+rs.getString(6)+"/"+rs.getString(2);
		  		}
		  		sql.delete(0,sql.length());
		  		sql.append("SELECT  DISTINCT JSKJ_XueXiMB.ZhiShiYNLMB  ,JSKJ_XueXiMB.GuoChengYFFMB ,JSKJ_XueXiMB.QingGanTDJZ   FROM jskj_xueximb jskj_xueximb WHERE 1=1  AND UPPER(jskj_xueximb.keshibh) =UPPER('"+keshibh+"')  ");
		  		ResultSet rsDX = dbm.executeQuery(sql.toString());
		  		while(rsDX.next()){
		  			zsmb=rsDX.getString(1);
		  			gcmb=rsDX.getString(2);
		  			qgmb=rsDX.getString(3);
		  		}
		      }
		      catch(Exception e){
		      	e.printStackTrace();
		      }finally{
			if(dbm != null) dbm.closeConnection();
		}
	%>
		<!-- 课前导学编号编号 -->
        <div class="fl mt-10 w-710">
            <div class="td-zt">
                	您所在的位置： <%=szwz %>
            </div>
           <!-- 知识与能力目标 -->
            <div class="my-jx mt-20">
                <div class="title-bar clearfix">
                    <h2>知识与能力目标</h2>
                </div>
            </div>
            <div class="mt-20">
            	<html:label id="di_ZhiShiYNLMB" value="<%=zsmb %>"/>
            </div>
            
            <!-- 过程与方法目标 -->
            <div class="my-jx mt-20">
                <div class="title-bar clearfix">
                    <h2>过程与方法目标</h2>
                </div>
            </div>
            <div class="mt-20">
            	<html:label id="di_GuoChengYFFMB" value="<%=gcmb %>"/>
            </div>

            <!-- 情感与态度价值观目标 -->
            <div class="my-jx mt-20">
                <div class="title-bar clearfix">
                    <h2>情感与态度价值观目标</h2>
                </div>
            </div>
            <div class="mt-20">
            	<html:label id="di_QingGanTDJZ" value="<%=qgmb %>"/>
            </div>
        </div>
	<div class="fr w-230 std-side">
  <!-- 查看学习指导 -->

            <div class="cour-two-line mt-60">           
            <div class="ckxxzd-kc mykc">
                <div class="title" style="color:#fff;">
                    查看学习指导
                </div>
            </div>
            <html:form>
              <input type="hidden" id="di_KeShiBH" value="<%=keshibh%>"></input>
            <div class="ckxxzd-white  mykc">
                <div class="title">
                    <a href="#" onclick="keqiandx()">课前寄语</a>
                </div>
            </div>
            <div class="ckxxzd-white  mykc">
                <div class="title">
                    <a href="#" onclick="keqiandx()">相关知识回顾</a>
                </div>
            </div>
            <div class="ckxxzd-white  mykc">
                <div class="title">
                    <a href="#" onclick="keqiandx()">学习重难点</a>
                </div>
            </div>
            <div class="ckxxzd-white  mykc">
                <div class="title">
                    <a href="#" onclick="xueximb()">学习目标</a>
                </div>
            </div>

            <div class="ckxxzd-white  mykc">
                <div class="title">
                    <a href="#" onclick="xuexizy()">获得更多学习资源</a>
                </div>
            </div>
           <div class="ckxxzd-white mykc">
                <div class="title">
                    <a href="#" onclick="xuexihd()">查看学习活动</a>
                </div>
            </div>
            </html:form>
            </div>

	 <!-- 相关学习资源 -->	
	  <!--
		<div class="more-box-res mt-20">
			<div class="side-title clearfix">
				<h3>相关学习资源</h3>
				<a href="#" class="more-link">更多》</a>
			</div>
			<div class="the-list">
				<ul class="clearfix">
					<li>
						<a href="#"><img src="<%=style%>/images/student/about-snow1.jpg" /></a>
						<p class="time">雪地里的小画家</p><br/>
                        <div class="clearfix div-dj-sy"><span class="sp-one">点击量  2463</span><span class="sp-two">开始学习</span></div>
					</li>
					<li>
						<a href="#"><img src="<%=style%>/images/student/about-aihu2.jpg" /></a>
						<p class="time">爱护环境</p><br/>
                        <div class="clearfix div-dj-sy"><span class="sp-one">点击量  2026</span><span class="sp-two">开始学习</span></div>
					</li>
					<li>
						<a href="#"><img src="<%=style%>/images/student/about-sao3.jpg" /></a>
						<p class="time">扫雪</p><br/>
                        <div class="clearfix div-dj-sy"><span class="sp-one">点击量  1924</span><span class="sp-two">开始学习</span></div>
					</li>
                   
				</ul>
			</div>
			
		</div>
		-->
	</div>
	

</div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />
<script type="text/javascript">
$(function(){
	zshgEditor = CKEDITOR.replace( 'di_ZhiShiHG',
   		{
            toolbar : 
             [
				 //加粗     斜体，     下划线      穿过线      下标字        上标字
                 ['Bold','Italic','Underline','Strike','Subscript','Superscript'],
				 // 数字列表          实体列表            减小缩进    增大缩进
                 ['NumberedList','BulletedList','-','Outdent','Indent'],
				 //左对齐             居中对齐          右对齐          两端对齐
                 ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
				 // 样式       格式      字体    字体大小
                 ['Styles','Format','Font','FontSize'],
				 //文本颜色     背景颜色
                 ['TextColor','BGColor'],
				 //全屏           显示区块
                 ['Maximize', 'ShowBlocks','-']
             ],height:80,width:636
          }
	 );
});
function keqiandx(){
	var bh=$('#di_KeShiBH').val();
	document.forms[0].action="<%=path %>/platform/qiantai/student/keqiandx.jsp?KeShiBH="+bh;
	document.forms[0].submit();
}
function xueximb(){
	var bh=$('#di_KeShiBH').val();
	document.forms[0].action="<%=path %>/platform/qiantai/student/xueximb.jsp?KeShiBH="+bh;
	document.forms[0].submit();
}
function xuexizy(){
	var bh=$('#di_KeShiBH').val();
	document.forms[0].action="<%=path %>/platform/qiantai/student/xiangguanxxzy.jsp?KeShiBH="+bh;
	document.forms[0].submit();
}
function xuexihd(){
	var bh=$('#di_KeShiBH').val();
	document.forms[0].action="<%=path %>/platform/qiantai/student/xuexihd.jsp?KeShiBH="+bh;
	document.forms[0].submit();
}
</script>

</body>
</html>
