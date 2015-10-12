<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.rc.web.utils.SystemConfig"%>
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>

<html>
<head>
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<!-- jquery -->
<%@include file="/common/jquery.jspf" %>
<!-- ui -->
<%@include file="/common/ui.jspf"%>
<%-- jqgrid --%>
<%@include file="/common/jqgrid.jspf"%>	
<%-- validate --%>
<%@include file="/common/jquery.validate.jspf" %>
<%@include file="/common/ckeditor.jspf"%>
<html:dialog id="GNDH_KeShiBJ" />
<title><%=executeResult.getDialog().getName()%></title>
<%
	String foldPath = SystemConfig.getUploadPath();
	//获取路径
	String path=request.getContextPath()+"/servlet";
	String value="";
	String kcbmbh=(String)request.getParameter("cs_KeChengBMBH");
	String sql_zj="select bianmumc,bianhao as bianmubm from jskj_kechengbm where shangjibh='"+kcbmbh+"'";
%>
<script type="text/javascript">
$(function(){
	// 教学计划内容
	jhnrEditor = CKEDITOR.replace( 'ZhiShiHG',
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
             ],height:150,width:573
          }
	 );
});
	var old_ksbh;
	$(function(){
		zhangjieks("");
		old_ksbh=$("#di_BianMuBH").val();
	});
	//根据章节获得课时
	function zhangjieks(zjbh){
		$("#ks_td").remove();
		var ksbmbh=$("#di_BianMuBH").val();
		$.ajax({
		type:"post",
		url:'<%=path%>/AjaxServlet',
		traditional:true,
		async:false,
		dataType: "json",
		data:{service:"com.rc.web.extension.ajax.HuoQuKS",
		parameter:["kcbmbh", "zjbh", "ksbmbh"],
		value:[<%=kcbmbh%>, zjbh, ksbmbh]},
		success:function(data,textStatus,jqXHR){}, 
		complete:function(XHR, TS){
			result = XHR.responseText;
			if('_qam_ajax_error'==result){
				$(this)._alert('\u63d0\u793a','ajax\u8c03\u7528\u5f02\u5e38');
				throw new Error("ajax\u8c03\u7528\u5f02\u5e38");
			}
			XHR = null;
			var returnstr=result.split("&");
			$("#zhangjie").val(returnstr[1]);
			$("#keshineirong").append(returnstr[0]);
		}
	});
	}
	//选择课程赋值
	function selectks(bmbh,bmmc){
		$("#di_KeShiMC").val(bmmc);
		$("#di_BianMuBH").val(bmbh);
	}
	//判断长度
	function len(s) {
		 var l = 0;
		 var a = s.split("");
		 for (var i=0;i<a.length;i++) {
		  if (a[i].charCodeAt(0)<299) {
		   l++;
		  } else {
		   l+=2;
		  }
		 }
		 return l;
		}
	//保存
	function check(){
		if(doValidate()){
			var kcbh= $("#cs_KeChengBH").val(); 
			var ksbh= $("#di_BianMuBH").val(); 
			if(old_ksbh!=ksbh){
				if(ExtFunctionCM.CheckRecordCount("jskj_keshi "," WHERE kechengbh = '"+kcbh+"' and bianmubh='"+ksbh+"'") > 0){
				    $(this)._alert('提示','此课程下已建立当前所选课时，请重新选择！');
				    return false;
				}
			}
			
			// 课前导学验证
			if (!keQianDXCheck())
				return false;
			// 学习目标验证
			if (!xueXiMBCheck())
				return false;
			// 相关学习资源
			if (!xiangGuanXXZYCheck())
				return false;
			return true;
		}
	}
	
	function afterSelectRow(id,groupId){
		//去除空行
		if(groupId == "DHSJZ_JiaoXueSP"){
			if(!(jQuery('#DHSJZ_JiaoXueSP').getCell(parseInt(id)+1,'di_ShiPinMC') || $("#di_ShiPinMC_"+(id)).val())){
				jQuery('#DHSJZ_JiaoXueSP').delRowData(parseInt(id)+1);
			}
		}
	}
	
	// 课前导学Tab页信息验证
	function keQianDXCheck() {
		// 课前寄语
		var di_KeQianJY = $("#di_KeQianJY").val();
		if (isEmpty(di_KeQianJY)) {
			$(this)._alert("提示","课前寄语不能为空！");
			return false;
		}
		if (beyondTheLength(di_KeQianJY, 500)) {
			$(this)._alert("提示","课前寄语不能超过500字符！");
			return false;
		}
		var ZhiShiHG=jhnrEditor.document.getBody().getText();
		if(!ZhiShiHG){
			$(this)._alert('提示','知识回顾不能为空！');
			return false;
		}
		if(len(ZhiShiHG)>1000){
			$(this)._alert('提示','长度不能大于1000字符(一个中文等于2个字符)');
			return false;
		}
		$("#di_ZhiShiHG").val(jhnrEditor.document.getBody().getHtml());
		
		// 教学重点
		var di_JiaoXueZD = $("#di_JiaoXueZD").val();
		if (isEmpty(di_JiaoXueZD)) {
			$(this)._alert("提示","教学重点不能为空！");
			return false;
		}
		if (beyondTheLength(di_JiaoXueZD, 500)) {
			$(this)._alert("提示","教学重点不能超过500字符！");
			return false;
		}
		
		// 教学难点
		var di_JiaoXueND = $("#di_JiaoXueND").val();
		if (isEmpty(di_JiaoXueND)) {
			$(this)._alert("提示","教学难点不能为空！");
			return false;
		}
		if (beyondTheLength(di_JiaoXueND, 500)) {
			$(this)._alert("提示","教学难点不能超过500字符！");
			return false;
		}
		return true;
	}
	// 学习目标验证
	function xueXiMBCheck() {
		// 知识与能力目标
		var di_ZhiShiYNLMB = $("#di_ZhiShiYNLMB").val();
		if (isEmpty(di_ZhiShiYNLMB)) {
			$(this)._alert("提示","知识与能力目标不能为空！");
			return false;
		}
		if (beyondTheLength(di_ZhiShiYNLMB, 500)) {
			$(this)._alert("提示","知识与能力目标不能超过500字符！");
			return false;
		}
		
		// 过程与方法目标不能为空
		var di_GuoChengYFFMB = $("#di_GuoChengYFFMB").val();
		if (isEmpty(di_GuoChengYFFMB)) {
			$(this)._alert("提示","过程与方法目标不能为空！");
			return false;
		}
		if (beyondTheLength(di_GuoChengYFFMB, 500)) {
			$(this)._alert("提示","过程与方法目标不能超过500字符！");
			return false;
		}
		
		// 情感与态度价值观目标
		var di_QingGanTDJZ = $("#di_QingGanTDJZ").val();
		if (isEmpty(di_QingGanTDJZ)) {
			$(this)._alert("提示","情感与态度价值观目标不能为空！");
			return false;
		}
		if (beyondTheLength(di_QingGanTDJZ, 500)) {
			$(this)._alert("提示","情感与态度价值观目标不能超过500字符！");
			return false;
		}
		return true;
	}
	
	// 相关学习资源验证
	function xiangGuanXXZYCheck() {
		// 资源名称
		var di_ZiYuanSYZD = $("#di_ZiYuanSYZD").val();
		if (isEmpty(di_ZiYuanSYZD)) {
			$(this)._alert("提示","资源使用指导不能为空！");
			return false;
		}
		if (beyondTheLength(di_ZiYuanSYZD, 500)) {
			$(this)._alert("提示","资源使用指导不能超过500字符！");		
			return false;
		}
		return true;
	}

//点击事件
function onClick(event,treeId,treeNode){
	if(!treeNode.isParent){
		if(treeNode.id){
			$("#cs_YWDYBianHao").val(treeNode.id);
		}else{
			$("#cs_YWDYBianHao").val('');
		}
		$("#MLKZ_ChaXun").click();
	}else{
		$(this)._alert('提示','请选择子节点');
		return false;
	}
}
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<html:form>
  <div class="ui-layout-center ui-jqdialog-content" >
  		<html:hidden id="" />
         <span>
         <html:tabcontrol style="font-size:90%;" >
	   		<html:tabtitle tabNames="基本信息,课前导学,学习目标,相关学习资源,学习活动设计,教学视频" />
	   		<html:tabpage index="1">
		<table class="dengjibox" width="100%" border="0" height="70%" cellspacing="0" cellpadding="0">
      		<tbody>
	        <tr>
	          <td  width="14%" class="CaptionTD" align="right"><font  color="red"title="必填项">*</font>相关章节</td>
	          <td class="DataTD">
	          	<html:select id="zhangjie" enumSQL="<%=sql_zj %>" onchange="zhangjieks(this.value)" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:92%"/>
	          </td>
	        </tr>
	        <tr id ="keshineirong" style="height: 50px;" valign="top">
	          <td  width="14%" class="CaptionTD" align="right"></td>
	          
	        </tr>
	        <tr>
	          <td  width="14%" class="CaptionTD" align="right"><html:title id="di_KeShiLX" /></td>
	          <td class="DataTD">
	          <html:radiobox id="di_KeShiLX" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:5%"/>
	          </td>
	        </tr>
	        <tr >
	          <td  width="14%" class="CaptionTD" align="right" ><html:title id="di_FaBuZT" /></td>
	          <td class="DataTD" >
	          	<html:radiobox id="di_FaBuZT"  modeStyle="FormElement ui-widget-content ui-corner-all" style="width:5%"/>
	          </td>
	        </tr>
     	 </tbody>
     </table>
     </html:tabpage>
     <html:tabpage index="2">
     	<table class="dengjibox" width="100%" border="0" height="70%" cellspacing="0" cellpadding="0">
      		<tbody >
	        <tr>
	          <td  width="14%" class="CaptionTD" align="right"><html:title id="di_KeQianJY" /></td>
	          <td class="DataTD">
	          	<html:textarea id="di_KeQianJY" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:95%"/>
	          </td>
	        </tr>
	        <tr>
	          <td  width="14%" class="CaptionTD" align="right"><html:title id="di_ZhiShiHG" /></td>
	          <td class="DataTD">
	          	 <html:hidden id="di_ZhiShiHG" />
		          <textarea  id="ZhiShiHG" name="ZhiShiHG"></textarea>
	          </td>
	        </tr>
	        <tr>
	          <td  width="14%" class="CaptionTD" align="right"><html:title id="di_JiaoXueZD" /></td>
	          <td class="DataTD">
	          	<html:textarea id="di_JiaoXueZD"  modeStyle="FormElement ui-widget-content ui-corner-all" style="width:95%"/>
	          </td>
	        </tr>
	        <tr>
	          <td  width="14%" class="CaptionTD" align="right"><html:title id="di_JiaoXueND" /></td>
	          <td class="DataTD">
	          	<html:textarea id="di_JiaoXueND"  modeStyle="FormElement ui-widget-content ui-corner-all" style="width:95%"/>
	          </td>
	        </tr>
     	 </tbody>
     </table>
     </html:tabpage>
      <html:tabpage index="3">
     	<table class="dengjibox" width="100%" border="0" height="70%" cellspacing="0" cellpadding="0">
      		<tbody >
	        <tr>
	          <td  width="14%" class="CaptionTD" align="right"><html:title id="di_ZhiShiYNLMB" /></td>
	          <td class="DataTD">
	          	<html:textarea id="di_ZhiShiYNLMB" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:92%"/>
	          </td>
	        </tr>
	        <tr>
	          <td  width="14%" class="CaptionTD" align="right"><html:title id="di_GuoChengYFFMB" /></td>
	          <td class="DataTD">
	          <html:textarea id="di_GuoChengYFFMB" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:92%"/>
	          </td>
	        </tr>
	        <tr>
	          <td  width="14%" class="CaptionTD" align="right"><html:title id="di_QingGanTDJZ" /></td>
	          <td class="DataTD">
	          	<html:textarea id="di_QingGanTDJZ"  modeStyle="FormElement ui-widget-content ui-corner-all" style="width:92%"/>
	          </td>
	        </tr>
     	 </tbody>
     </table>
     </html:tabpage>
      <html:tabpage index="4">
     	<table class="dengjibox" width="100%" border="0" height="70%" cellspacing="0" cellpadding="0">
      		<tbody >
      		<tr>
	          <td  width="14%" class="CaptionTD" align="right"><html:title id="di_ZiYuanSYZD" /></td>
	          <td class="DataTD">
	          	<html:textarea id="di_ZiYuanSYZD"  modeStyle="FormElement ui-widget-content ui-corner-all" style="width:98%"/>
	          </td>
	        </tr>
				<html:jqgrid id="DHSJZ_ZiYuanKJ"  doResize="" processUnitId="SWDY_ZiYuanKJ" sortable="true" delRow="true" autoWidth="false" sortName="di_ZiYuanMC:ZiYuanMC,di_ZiYuanLX:ZiYuanLX,di_ZiYuanLJ:ZiYuanLJ,di_FengMianLJ:FengMianLJ" rownumbers="true" height="180" />
     	 	</tbody>
     	</table>
     </html:tabpage>
      <html:tabpage index="5">
     	<table class="dengjibox" width="100%" border="0" height="70%" cellspacing="0" cellpadding="0">
      		<tbody >
	          <html:jqgrid id="DHSJZ_XueXiHD"  doResize="" processUnitId="SWDY_XueXiHD" sortable="true" delRow="true" autoWidth="false" sortName="di_HuoDongMC:HuoDongMC" rownumbers="true" height="240" />
     	 </tbody>
     </table>
     </html:tabpage>
      <html:tabpage index="6">
     	<table class="dengjibox" width="100%" border="0" height="70%" cellspacing="0" cellpadding="0">
      		<tbody >
	       	<html:jqgrid id="DHSJZ_JiaoXueSP"  doResize="" processUnitId="" sortable="true" delRow="true"  autoWidth="false"  rownumbers="true" height="240" />
     	 	</tbody>
     </table>
     </html:tabpage>
     </html:tabcontrol>
    </span>
   </div>  	
   		<html:hidden id="di_KeShiMC" />
   		<html:hidden id="di_BianMuBH" />
   		<!-- 课前导学 -->
   		<html:hidden id="di_BianHao_KQDX" />
   		<!-- 学习目标 -->
   		<html:hidden id="di_BianHao_XXMB" />
   		<!-- 学习资源 -->
   		<html:hidden id="di_BianHao_XXZY"/>
   		<!-- 学习活动 -->
   		<html:hidden id="di_BianHao_XXHD"/>
   		<!-- 教学视频 -->
   		<html:hidden id="di_BianHao_JXSP"/>
		<html:paraSave />
		<html:splitline modeStyle="ui-widget-content" width="100%"/>
		<html:splitline/>
		<html:splitline/>
		<html:splitline/>
		<table width="100%" border="0"  cellspacing="0" cellpadding="0" align="center" class="dj_bg">
			<tr>
				 <td align="right">
						<div class="title_right">
							<html:command id="MLKZ_BaoCun"/>
							<html:command id="MLKZ_GuanBi"/>						
						</div>
				</td>
			</tr>
		</table>
  </html:form>
  <script type="text/javascript">
 $(function(){
		jhnrEditor.setData($("#di_ZhiShiHG").val());
	});
 </script>
</body>
</html>
