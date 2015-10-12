<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<%@page import="com.rc.web.utils.SystemConfig"%>
<head>
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<!-- jquery -->
<%@include file="/common/jquery.jspf" %>
<!-- ui -->
<%@include file="/common/ui.jspf"%>
<%-- jqgrid --%>
<%@include file="/common/jqgrid.jspf"%>	
<html:dialog id="GNDH_YouXiuKTBJ" async="true"/>
<%
String path=request.getContextPath();
boolean disabled = false;
if("DHZT_DiaoKan".equalsIgnoreCase(request.getParameter("_qam_dialog_state"))){
	disabled = true;
}
String foldPath = SystemConfig.getUploadPath();
%>
<script type="text/javascript">
	var name;//文件名称
	var panfu;//盘符
	function DianXuanKC(){
		$(this)._selectValue([['cs_BianHaoKC','di_KeChengBH'],
		                      ['cs_BianHaoKS','di_KeShiBH'],
		                      ['cs_KeMu','di_KeMu'],
		                      ['cs_KeMuYC','di_KeMuYC'],//隐藏值
		                      ['cs_KeShiMC','di_KeTangMC'],
		                      ['cs_ShiPinLJ','di_ShiPinLJ'],
		                      ['cs_ZhuJiangR','di_ZhuJiangR']],
	'${path}/servlet/jspdispatchservlet?_qam_dialog=GNDH_DianXuan&_qam_dialog_state=DHZT_ChaXun','GNDH_DianXuan',730,580,'课程点选');
	}
	  //设置附件上传路径
		function beforeUpload(){
			var folder='<%=foldPath%>';
			$(this)._FJDelete("/"+folder+"/teacher/youxiuketang/ketangfengmian");
			fengmian.setFolderPath("/"+folder+"/teacher/youxiuketang/ketangfengmian");
			var fujianMC="FJ"+(new Date()).valueOf()+/\.[^\.]+$/.exec(fengmian.getFileName());
			fengmian.setFileRename(fujianMC);
			return true;
	  	}
	  //返回上传后的路径到页面
		function afterUpload(success,msg,fileName,filePath){
	        if(success){
	         	$("#di_FengMianLJ").val(filePath);
	        }
		}
	  	//删除文件
		function afterDel(success,msg,fileName,filePath){
	  		//获取要删除的文件名
	  		var path=$("#di_FengMianLJ").val();
	  		name=path.substring(path.lastIndexOf('/')+1);
	  		panfu= "<%=application.getRealPath("").replaceAll("\\\\","/")+"/"%>";
	  		//删除文件
	  		
		}
	//保存
	function save(){
		var KeChengMC=$("#di_KeTangMC").val();
		if(KeChengMC){
			//得到路径
			if(fengmian.fileList.length>0){
				$("#di_FengMianLJ").val(fengmian.fileList[0][0]);
			}else{
				ajax(name,panfu);
				$("#di_FengMianLJ").val("");
			}
			return true;
		}else{
			$(this)._alert('提示','课堂名称不允许为空，请点选赋值');
			return false;
		}
		
	}
	$(function(){
		var filepath =$('#di_FengMianLJ').val();
		var fileBH=filepath.substring(filepath.lastIndexOf('/')+1,filepath.lastIndexOf('.'));
		var fuJian=filepath.substring(filepath.lastIndexOf('/')+1);
		var bhs=fileBH.split(",");
		var fjs=fuJian.split(",");
		var bool=true;
	  	  var paths=filepath.split(",");
	  		 if(fengmian.state){
				for(var i=0;i<paths.length;i++){
					fengmian.addFile(paths[i],"",bhs[i]);
				if(!fjs[i]){
					bool=false;
				}
				fengmian.showFileList(bool);
			}
		}
	  	<%--
	  		if($.browser.msie){
	  			$("#fengmian").bind('load',function(){
	  				<fengmian.setReadOnly(<%=disabled%>);
	  			});
			}
		--%>
  		<%--for firefox--%>
	    $("#fengmian").bind('load',function(){
			if(fengmian.state){
				for(var i=0;i<paths.length;i++){
					fengmian.addFile(paths[i],"",bhs[i]);
					if(!fjs[i]){
						bool=false;
					}
					fengmian.showFileList(bool);
				}
			}
			if(<%=disabled%>){
				//fengmian.setReadOnly(true);
			}
	    });
	});
	function ajax(name,panfu){
		$.ajax({
			url:path+'/servlet/AjaxServlet',
			type:"post",
			traditional:true,
			async:false,
			data:{service:"com.rc.web.extension.ajax.DeleteUpload",
			parameter:["name","panfu"],
			value:[name,panfu]},
			success:function(data,textStatus,jqXHR){},
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
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<html:form>
	<div class="ui-layout-center">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="ui-jqdialog-content ui-widget-content">
			<html:hidden id="di_BianHao" />
			<html:hidden id="di_ShiPinLJ" />
			<html:hidden id="di_KeChengBH" />
			<html:hidden id="di_KeShiBH" />
			<tr>
				<td nowrap width="3%" class="CaptionTD" align="right">
					<html:title id="di_KeTangMC"/>
				</td>
				<td  width="15%" class="DataTD" align="left">
					<html:text readonly="true" id="di_KeTangMC" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:70%"/>
					<%if(disabled){%>
						<input type="button" disabled="disabled"   id="kechengdx" name="kechengdx" onclick="DianXuanKC()" value="课程点选"/>
					<%}else{%>
						<input type="button" id="kechengdx" name="kechengdx" onclick="DianXuanKC()" value="课程点选"/>
					<%}%>
				</td>
			</tr>
			<tr>
				<td nowrap width="3%" class="CaptionTD" align="right">
					<html:title id="di_ZhuJiangR"/>
				</td>
				<td  width="15%" class="DataTD" align="left">
					<html:text readonly="true" id="di_ZhuJiangR" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:90%"/>
				</td>
			</tr>
			<tr>	
				<td nowrap width="3%" class="CaptionTD" align="right">
					<html:title id="di_KeMu"/>
				</td>
				<td  width="15%" class="DataTD" align="left">
					<html:hidden id="di_KeMuYC" />
					<html:select disabled="true"  initText="" id="di_KeMu" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:92%"/>
				</td>
			</tr>
			<tr>	
				<td nowrap width="3%" class="CaptionTD" align="right" valign="top">
					<html:title id="di_FengMianLJ"/>
				</td>
				<td  width="15%" class="DataTD" align="left">
						<html:hidden id="di_FengMianLJ" />
						<html:upload id="fengmian" 
						frameHeight="40" 
						doBeforeUpload="beforeUpload"
						doAfterUpload="afterUpload" 
						doAfterDel="afterDel"
						useButton="true" 
						useButton_cam="false" 
						fileCount="1" 
						allowedFilesList="jpg,jpeg,png,gif"
						rename="false"
						/>
				</td>
				
			</tr>
			<tr>
			</tr>
			<tr>
				<td colspan="2" align="right" style="padding-right: 30px;">
						<html:command id="MLKZ_BaoCun" />
						<html:command id="MLKZ_XiuGai" />
						<html:command id="MLKZ_GuanBi" />
				</td>
			</tr>
		</table>		
	</div>
		<html:paraSave/>
	</html:form>
</body>
</html>