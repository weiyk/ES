<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@page import="com.rc.tools.jsonexplain.*" %>
<%@page import="java.util.*"%>
<%@page import="com.rc.tools.safty.ToDate" %>
<%
//获取路径
String path=request.getContextPath()+"/servlet";

//通知公告列表
TongZhiGG TZGG=new TongZhiGG();
List<Object> obj=TZGG.getJSONGongGaoBS("","","","1","1","4");
List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
if(obj.size()>0){
	String msgCode=(String)obj.get(0);
	if(msgCode.equals("1")){
		list=TZGG.getJSONGongGaoLB(obj.get(2));
	}
	request.setAttribute("msgCode",msgCode);
}
ToDate td=new ToDate();
%>
<html>
<head>
<title>首页</title>
<%@include file="/Preamble.jspf"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/common/skins/default/eschool/css/base.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/common/skins/default/eschool/css/main.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/common/skins/default/eschool/js/base.js"></script>

<script type="text/javascript">
function submited(){	
		var ua = window.navigator.userAgent;
		if(!$("#loginName").val()){
			$(this)._alert('提示','请输入用户名!');
			return;
		}
		if(!$("#loginPwd").val()){
			$(this)._alert('提示','请输入密码!');
			return;
		}
		//验证码是否为无
		if(!$("#yanZhenM").val()){
			$(this)._alert('提示','请输入验证码!');
			return;
		}
		if($("#yanZhenM").val().length < 4){
			$(this)._alert('提示','请输入4位验证码!');
			return;
		}
		if(!$.browser.msie && !$.browser.mozilla){
			$(this)._alert('提示','请用IE或者mozilla浏览器登陆本系统!');
			return;
		}
		if($.browser.msie && $.browser.version < 8.0){
			$(this)._alert('提示','请选8.0版本以上的IE登陆本系统!');
			return;
		}
		if($.browser.mozilla && $.browser.version < 12.0){
			if(!/rv\:(\d+)/.test(ua)){
				$(this)._alert('提示','请选12.0版本以上的mozilla登陆本系统!');
				return;
			}
		}
		var userName = document.getElementById("loginName").value;
		setCookie("loginName",userName);
		document.form1.submit();
	}	
	function windowsInit(){
		//try{winResize();}catch(e){}
		document.getElementById("loginName").focus();
		var username=getCookie("loginName");
		document.getElementById('loginName').value = username;
		if(username ==""){
			document.getElementById('loginName').value="";
			document.getElementById('loginName').focus();
		}else{
			document.getElementById('loginName').value=username;
			document.getElementById('loginPwd').focus();
		}
	}
	<%--按回车登陆--%>
	$(document).keydown(function(event) {
		if (event.keyCode == 13) {
		 	if($('.ui-dialog-buttonset').attr('class') && $('.ui-dialog-buttonset').attr('class').length > 0)
		 		return;
			submited();
		}
	}); 
	<%--切换验证码--%>
	function changeImg(){
		document.form1.yzm.src = "<%=request.getContextPath()%>/common/page/image.jsp?"+ Math.random();
	}
    //验证是否包括特殊字符
	function TextValidate(id){
		var text=$("#"+id).val();//获取当前输入的用户
		var pattern = new RegExp("[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）&—|{}【】‘；：”“'。，、？]"); 
		if(pattern.test(text)==true){
			alert("用户名不允许包含特殊字符");
			$("#"+id).val("");
		}

	}
	
</script>


</head>
<body bgcolor="#FFFFFF" text="#000000" onload="windowsInit()">
	<form name="form1" method="post" action="<%=request.getContextPath()%>/servlet/desktop.html">
		<!--头页-->
		<div class="header">
			<div class="in-box wrap clearfix">
				<div class="logo fl">
					<a href="#">双轨数字学校</a>
				</div>
				<ul class="nav fr">
					<li><a href="<%=path%>/desktop.html" class="cur">首页</a>
					</li>
					<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_XueXiLHT">学习联合体</a>
					</li>
					<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YouXiuKT">优秀课堂</a>
					</li>
					<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_MingShiGZS">名师工作室</a>
					</li>
					<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_TongZhiGG">通知公告</a>
					</li>
				</ul>
			</div>
		</div>

		<!-- 首页banner -->
		<div class="id-login">
			<div class="banner">
				<ul class="pic-list">
					<li
						rel="${skinpath}/eschool/banner11.jpg"></li>
					<li class="hidden"
						rel="${skinpath}/eschool/banner22-xa.jpg"></li>
					<li class="hidden"
						rel="${skinpath}/eschool/banner33-es.jpg"></li>
				</ul>
			</div>
			
			<script type="text/javascript"
				src="<%=request.getContextPath()%>/common/skins/default/eschool/js/banner.js"></script>
			<div class="wrap clearfix">
				<div class="pic-dot">
					<span class="cur"></span><span></span><span></span>
				</div>
				<div class="login-box">
					<h2>用户登录</h2>
					<div class="form-box">
						<div class="form-box">

							<div class="one-cell usename-ip clearfix">
								<label for="username-ip"><img
									src="${skinpath}/eschool/ip-user.gif"
									alt="" />
								</label> <input  type="text" name="loginName" id="loginName"
									placeholder="请输入用户名" onchange="TextValidate(this.id)" />
							</div>
							<div class="one-cell pw-ip clearfix">
								<label for="password-ip"><img
									src="${skinpath}/eschool/ip-pw.gif"
									alt="" />
								</label> <input type="password" name="loginPwd" id="loginPwd"
									placeholder="请输入密码" />
							</div>
							<div class="yzm-cell clearfix">
								<input type="text" name="yanZhenM" id="yanZhenM" class="input_item input_yzm" placeholder="请输入验证码" />
								<a href="#" onclick="javascript:changeImg()">
									 <span class="img-mt10">
									 	<img id="yzm" src="<%=request.getContextPath()%>/common/page/image.jsp" width="93" height="34" />
									 </span>
								</a>
							</div>
							<div class="clearfix sub-cell">
								<button type="button" id="login" name="login" class="login" onclick="submited()"></button>
								<button type="button" id="register" name="register" class="register" onclick="sendMail()"></button>
							</div>
							<div class="clearfix login-act">
								<label><a href="<%=request.getContextPath()%>/bglogin.jsp"><span class="forget-mm">管理员登录</span></a></label> 
								<span class="forget-mm">忘记密码？点 <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_ChongZhiMM" class="hl">这里</a>
								</span>
							</div>
							<input type="hidden" name="__hash__" value="874d3ded5f28f4a9" />
						</div>
					</div>
				</div>
			</div>
		</div>


		<div class="wrap">

			<!-- 公告信息 -->
			<div class="gg-box mt-15 clearfix">
				<div class="gg-list fl">
					<ul class="clearfix">
						<li>
							<b>通知公告</b>
							<span>
								<a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_TongZhiGG"
								class="more-link fr">更多》</a>
							</span>
						</li>
						
						 <%
						 	if(list.size()>0){
				      		for(int i=0;i<list.size();i++){
				      			Map<String,Object> maps=list.get(i);
			      		  %>
						<li>
							<a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_GongGaoXQ&_qam_dialog_state=DHZT_ChaXun&cs_BianHao=<%=maps.get("id")%>">【<b><%=maps.get("type")%></b>】<%=maps.get("title")%></a>
							<span><%=td.TimeConvert((String)maps.get("createTime"))%></span>
						</li>
						<%}}%>
						
					</ul>
				</div>
				<div class="ewm fr"
					style="background-image:url(${skinpath}/eschool/pic-ewm.gif);width:290px;">
					<!-- <img src="images/pic-ewm.gif" alt="qrcode" /> -->
					<img src="${skinpath}/eschool/qrcode_for_8cm.jpg" alt="qrcode" class="fl"
						style="width:134px; height:134px;" />
				</div>
			</div>
			<!-- 手拉手小学 -->
			<div class="sls-tb mt-30">
				<div class="title-bar clearfix">
					<h2 class="fl">手拉手同步课堂</h2>
					<a href="<%=request.getContextPath() %>/platform/qiantai/shouye/youxiuketang.jsp" class="more-link fr" style="text-decoration:none;">更多》</a>
				</div>
				<div class="one-box  mt-20">
					<span class="cor tl-cor"></span> <span class="cor tr-cor"></span> <span
						class="cor bl-cor"></span> <span class="cor br-cor"></span>
					<div class="clearfix">
						<dl class="fl">
							<dt>
								<a><img src="${skinpath}/eschool/pic-sjf.jpg" alt="" />
								</a>
							</dt>
							<dd>
								<h3>
									<a href="<%=request.getContextPath() %>/platform/qiantai/shouye/xuexilianheti-xiananquxiaoxue.jsp">咸安区桂花镇苏家坊村小学</a>
								</h3>
								<p>苏家坊村小学原名同心小学，后因生源减少，布局调整后，设为教学点，隶属石城小学管理。学校一二年级现有学生49人...</p>
							</dd>
						</dl>
						<dl class="fr">
							<dt>
								<a><img src="${skinpath}/eschool/pic-liuci.jpg" alt="" />
								</a>
							</dt>
							<dd>
								<h3>
									<a href="<%=request.getContextPath() %>/platform/qiantai/shouye/xuexilianheti-xiananquxiaoxue.jsp">咸安区桂花镇刘祠小学</a>
								</h3>
								<p>刘祠小学位于桂花镇南川村境内，隶属南川小学管理。现有学生73人，开办学前班、一至四年级共5个教学班，教师5人...</p>
							</dd>
						</dl>
						<div class="box-bot">
							<h3>
								<a href="<%=request.getContextPath() %>/platform/qiantai/shouye/xuexilianheti-xiananquxiaoxue.jsp" style="text-decoration:none;">咸安区外国语实验小学</a>
							</h3>
							<p>咸安区外国语实验小学和幼儿园是由咸宁碧桂园投资近4000万元，用了近两年时间新建而成的一流花园式学校和幼儿园...</p>
							<a href="<%=request.getContextPath() %>/platform/qiantai/shouye/kechengbofang.jsp" class="enter-link"><img
								src="${skinpath}/eschool/btn-enter.gif" alt="" />
							</a>
						</div>
					</div>
				</div>
				<div class="two-box mt-10">
					<span class="cor tl-cor"></span> <span class="cor tr-cor"></span> <span
						class="cor bl-cor"></span> <span class="cor br-cor"></span>
					<div class="clearfix">
						<dl class="fl">
							<dt>
								<a><img src="${skinpath}/eschool/pic-lmqb.jpg" alt="" />
								</a>
							</dt>
							<dd>
								<h3>
									<a href="<%=request.getContextPath() %>/platform/qiantai/shouye/xuexilianheti-enshishixiaoxue.jsp" style="text-decoration:none;">恩施市龙凤镇龙马青堡小学</a>
								</h3>
								<p>龙凤镇龙马青堡小学位于湖北省恩施市与重庆市奉节县交界处的青堡村，海拔1100余米，为高山地带。校舍坐落于该村一...</p>
							</dd>
						</dl>
						<div class="box-bot">
							<h3>
								<a href="<%=request.getContextPath() %>/platform/qiantai/shouye/xuexilianheti-enshishixiaoxue.jsp" style="text-decoration:none;">恩施市龙凤镇龙马民族小学</a>
							</h3>
							<p>恩施市龙凤镇龙马民族小学始建于1927年，民国时期是一所私立小学，原校址建在龙马街东侧的古庙中，新中国成立后...</p>
							<a href="<%=request.getContextPath() %>/platform/qiantai/shouye/kechengbofang.jsp" class="enter-link"><img
								src="${skinpath}/eschool/btn-enter.gif" alt="" />
							</a>
						</div>
					</div>
				</div>
			</div>

			<!--联合体风采-->
			<div class="lht-fc mt-30">
				<div class="title-bar clearfix">
					<h2 class="fl">联合体风采</h2>
					<a href="<%=request.getContextPath() %>/platform/qiantai/shouye/xuexilianheti-sheng.jsp" class="more-link fr" style="text-decoration:none;">更多》</a>
				</div>
				<ul class="the-list mt-20 clearfix">
					<li><a class="pic"><img src="${skinpath}/eschool/pic-niejia.jpg"
							alt="" />
					</a> <strong><a
							href="<%=request.getContextPath() %>/platform/qiantai/shouye/xuexilianheti-xiananquxiaoxue.jsp" style="text-decoration:none;">浮山中小学 —
								大坪-星星-聂家小学</a>
					</strong>
						<p>由咸安区浮山中小学作为中心校，咸安区汀泗桥镇大坪、星星和聂家小学作为教学点形成的一对三的教学联合体。</p></li>
					<li><a class="pic"><img src="${skinpath}/eschool/pic-nh.jpg" alt="" />
					</a> <strong><a
							href="<%=request.getContextPath() %>/platform/qiantai/shouye/xuexilianheti-enshishixiaoxue.jsp" style="text-decoration:none;">芭蕉侗族乡中心小学 —
								南河小学</a>
					</strong>
						<p>由恩施市芭蕉侗族乡中心小学作为中心校，芭蕉侗族乡南河小学作为教学点形成的一对一的教学联合体。</p></li>
					<li><a class="pic"><img
							src="${skinpath}/eschool/pic-taohuajian.jpg" alt="" />
					</a> <strong><a
							href="<%=request.getContextPath() %>/platform/qiantai/shouye/xuexilianheti-xiananquxiaoxue.jsp" style="text-decoration:none;">二号桥小学 —
								蔡桥小学-桃花尖小学</a>
					</strong>
						<p>由咸安区二号桥小学作为中心校，咸安区大幕乡蔡桥小学和桃花尖小学作为教学点形成的一对二的教学联合体。</p></li>
				</ul>
			</div>


			<!--名师工作室-->
			<div class="msgzs-box mt-30">
				<div class="title-bar clearfix">
					<h2 class="fl">名师工作室</h2>
					<a href="<%=request.getContextPath()%>/platform/qiantai/shouye/mingshigongzuoshi.jsp" class="more-link fr" style="text-decoration:none;">更多》</a>
				</div>
				<ul class="the-list mt-20 clearfix">
					<li>
						<dl class="clearfix">
							<dt>
								<a href="<%=request.getContextPath()%>/platform/qiantai/teacher/jiaoshigongzuoshi-1.jsp" class="pic"><img
									src="${skinpath}/eschool/pic-t1.png" alt="" />
								</a>
							</dt>
							<dd>
								<strong><a href="<%=request.getContextPath()%>/platform/qiantai/teacher/jiaoshigongzuoshi-1.jsp" style="text-decoration:none">余淼工作室</a>
								</strong>
								<p>
									高级教师 <span class="blk">小学英语</span> <br />人气: <span class="blk">524</span>
								</p>
							</dd>
						</dl>
						<p class="txt">简介：余淼，女，中共党员，毕业于中南财经政法大学，现任教于咸宁市咸安区外国语实验小学二（一）班，英语老师，注重快乐教学...</p>
					</li>
					<li>
						<dl class="clearfix">
							<dt>
								<a href="<%=request.getContextPath()%>/platform/qiantai/teacher/jiaoshigongzuoshi-1.jsp" class="pic"><img
									src="${skinpath}/eschool/pic-t2.png" alt="" />
								</a>
							</dt>
							<dd>
								<strong><a href="<%=request.getContextPath()%>/platform/qiantai/teacher/jiaoshigongzuoshi-1.jsp" style="text-decoration:none">宋保华工作室</a>
								</strong>
								<p>
									高级教师 <span class="blk">小学美术</span> <br />人气: <span class="blk">436</span>
								</p>
							</dd>
						</dl>
						<p class="txt">简介：宋保华，女，1968年6月18日出生，大专学历，小学高级教师。所撰写的论文、优质课获区一等奖，多次组织学生参加省、市、区少儿书画比赛，均获得好的成绩...</p>
					</li>
					<li class="last">
						<dl class="clearfix">
							<dt>
								<a href="<%=request.getContextPath()%>/platform/qiantai/teacher/jiaoshigongzuoshi-1.jsp" class="pic"><img
									src="${skinpath}/eschool/pic-t3.png" alt="" />
								</a>
							</dt>
							<dd>
								<strong><a href="<%=request.getContextPath()%>/platform/qiantai/teacher/jiaoshigongzuoshi-1.jsp" style="text-decoration:none">石萍工作室</a>
								</strong>
								<p>
									高级教师 <span class="blk">小学英语</span> <br />人气: <span class="blk">494</span>
								</p>
							</dd>
						</dl>
						<p class="txt">简介：石萍,小学高级教师，咸安区温泉二号桥小学英语教师。
							从教十几年来，为了不断地丰富自己，在平时的工作中，我非常注意收集和积累各种小资料，上网查阅对...</p></li>
				</ul>
			</div>

		</div>

		<!-- 页尾 -->
		<div style="background:#333;margin-top:50px;padding:20px;height:100px;">
			<div  style="width:950px;margin:0 auto;*zoom: 1;">
				<div  style="width:480px;float:left;">
					<p ><a style="color:#eee;font-size:12px;margin-right:12px;font-weight:bold;" href="#">关于我们</a><a style="color:#eee;font-size:12px;margin-right:12px;font-weight:bold;" href="#">联系我们</a><a style="color:#eee;font-size:12px;margin-right:12px;font-weight:bold;" href="#">法律条款</a><a style="color:#eee;font-size:12px;margin-right:12px;font-weight:bold;" href="#">帮助中心</a><a style="color:#eee;font-size:12px;margin-right:12px;font-weight:bold;" href="#">意见反馈</a></p>
		            <p style="color:#666;margin-top:10px;">版权所有：湖北省信息化与基础教育均衡发展协同创新中心</p>
		            <p style="color:#666;margin-top:10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;中邮世纪（北京）通信技术有限公司</p>
					<p style="color:#888;margin-top:10px;">技术支持：中邮世纪（北京）通信技术有限公司</p>
				</div>
				<div style="width:290px;float:right;">
					<h2 style="color:#eee;font-size: 16px;font-weight:700;margin-bottom: 5px;">联系我们 <span style="color:#666;font-size:14px;font-weight: normal;">Contact Us</span></h2>
					<p style="color:#666">
						地址：湖北省武汉市洪山区珞喻路152号 <br />
						邮编：430070<br />
						电话：400-0910-601  <br />
						E-mail:shuzixuexiao@126.com	
					</p>
				</div>
			</div>
		</div>
								
	</form>
	<script language="javascript">
	<%if (request.getParameter("errInfo") != null&& request.getParameter("errInfo").length() > 0&& !request.getParameter("errInfo").equals("null")) {%>
		$(this)._alert('提示','<%=request.getParameter("errInfo")%>',null,null,function(){
			if(<%="验证码输入错误！".equals(request.getParameter("errInfo"))%>){
				document.form1.yzm.src = "<%=request.getContextPath()%>/common/page/image.jsp?"+ Math.random();
			}
		});
	<%}%>
	
	// 打开邮件
	function sendMail() {
		jQuery('<form action="mailto:support@ifory.cn"></form>').appendTo("body").submit().remove()
	}
	</script>
</body>
</html>