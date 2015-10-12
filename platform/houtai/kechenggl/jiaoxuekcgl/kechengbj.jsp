<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.rc.web.utils.SystemConfig"%>
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
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
<html:dialog id="GNDH_KeChengBJ" />
<title><%=executeResult.getDialog().getName()%></title>
<%
	String foldPath = SystemConfig.getUploadPath();
	boolean disabled = false;
	String dw =(String)session.getAttribute("DanWeiBH");
	if("DHJRZT_DiaoKan".equalsIgnoreCase(request.getParameter("_qam_dialog_state"))){
		disabled = true;
	}
	//获得课程项目
	IDataBaseAccess dbm = null;
	List<String> courseItemList = new ArrayList<String>();
	try {
		dbm = ContextService.lookupDefaultDataBaseAccess();
		dbm.openConnection();
		ResultSet rs = null;
		// 查询集合列表
		String sql = "select JiHeYLX, BianMa, Zhi from qam_jiheyz where ZhuangTai=1";
		rs = dbm.executeQuery(sql);
		while (rs.next()) {
			// 集合类型
			courseItemList.add(rs.getString("JiHeYLX"));
			// 集合编码
			courseItemList.add(rs.getString("BianMa"));
			// 集合值
			courseItemList.add(rs.getString("Zhi"));
		}
		rs.close();
		} catch (Exception e) {
			e.printStackTrace();	
		} finally {
			if (dbm != null)
				dbm.closeConnection();
		}
%>
<c:set value="<%=disabled %>" var="disabled"></c:set>
<script type="text/javascript">
$(function(){
	// 教学计划内容
	jhnrEditor = CKEDITOR.replace( 'KeChengTS',
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
var old_nj;var old_km;
	$(function(){
		var XueDuan = $('input[name="di_XueDuan"]:checked').val(); 
		confirms(XueDuan);
		var nj=$("#di_NianJi").val();
		$("#NianJi_"+nj).attr("checked", "true");
		old_nj= $("#di_NianJi").val(); 
		old_km= $('input[name="di_KeMu"]:checked').val(); 
	});
	function confirms(id) {
		// 根据学段动态显示年级，暂时这样写
		if (id == "1") {
			$("#di_NianJi_4").css("display", "inline");
			$("#di_NianJi_5").css("display", "inline");
			$("#di_NianJi_6").css("display", "inline");
		} else if (id == "2" || id == "3") {
			$("#di_NianJi_4").css("display", "none");
			$("#di_NianJi_5").css("display", "none");
			$("#di_NianJi_6").css("display", "none");
		}
	}
	function selectradio(id){
		$("#NianJi_"+$("#di_NianJi").val()).removeAttr("checked");
		$("#di_NianJi").val(id);
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
			var nj= $("#di_NianJi").val(); 
			var km= $('input[name="di_KeMu"]:checked').val(); 
			var jlr=$("#di_JianLiR").val();
			if(old_nj!=nj||old_km!=km){
				if(ExtFunctionCM.CheckRecordCount("jskj_kecheng "," WHERE NianJi = '"+nj+"' and KeMu='"+km+"' and JianLiR='"+jlr+"'") > 0){
				    $(this)._alert('提示','建立课程用户所选的"课程年级及科目"已存在,请重新选择！');
				    return false;
				}
			}
			var KeChengTS=jhnrEditor.document.getBody().getText();
			if(!KeChengTS){
				$(this)._alert('提示','课程特色不能为空！');
				return false;
			}
			if(len(KeChengTS)>1000){
				$(this)._alert('提示','长度不能大于1000字符(一个中文等于2个字符)');
				return false;
			}
			$("#di_KeChengTS").val(jhnrEditor.document.getBody().getHtml());
			return true;
		}
	}
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<html:form>
  <div class="ui-layout-center ui-jqdialog-content" >
         <span>
		<table class="dengjibox" width="100%" border="0" height="70%" cellspacing="0" cellpadding="0">
      		<tbody>
	        <tr>
	          <td  width="14%" class="CaptionTD" align="right"><html:title id="di_BiaoTi"/></td>
	          <td class="DataTD">
	          	<html:text id="di_BiaoTi" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:92%"/>
	          </td>
	        </tr>
	        <tr>
	          <td  width="14%" class="CaptionTD" align="right"><html:title id="di_BiaoQian" /></td>
	          <td class="DataTD">
	          <html:text id="di_BiaoQian" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:92%"/>
	          </td>
	        </tr>
	        <tr>
	          <td  width="14%" class="CaptionTD" align="right"><html:title id="di_XueDuan" /></td>
	          <td class="DataTD">
	          	<html:radiobox id="di_XueDuan" onclick="confirms(this.value)" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:5%"/>
	          </td>
	        </tr>
	        <tr>
	           <td width="14%" class="CaptionTD" align="right"><html:title id="di_NianJi"/></td>
	           <td class="DataTD">
	           <html:hidden id="di_NianJi" />
	           		<%
	           			String code="";String text="";
						for(int j = 0; j < courseItemList.size(); j+=3) {
							if ("JH_NianJi".equals(courseItemList.get(j))) {
								// 编码
								code = courseItemList.get(j+1);
								// 值
								text = courseItemList.get(j+2);
						%>
						<span id="<%="di_NianJi_" + code %>" name="<%="di_NianJi_" + code %>"><input type="radio" id="<%="NianJi_" + code %>" name="<%="NianJi_" + code %>" style="width:5%" class="FormElement ui-widget-content ui-corner-all"  value="<%=code%>" onclick="selectradio(<%=code%>)"><%=text %></input></span>
						<%
							}
						}
						%>
	           </td>
	        </tr>
	        <tr>
	           <td width="14%" class="CaptionTD" align="right"><html:title id="di_KeMu"/></td>
	           <td class="DataTD">
	           		<html:radiobox id="di_KeMu"  modeStyle="FormElement ui-widget-content ui-corner-all" style="width:5%"/>
	           </td>
	        </tr>
	        <tr>
	           <td width="14%" class="CaptionTD" align="right"><html:title id="di_KeBenLX"/></td>
	           <td class="DataTD">
	           		<html:radiobox id="di_KeBenLX"  modeStyle="FormElement ui-widget-content ui-corner-all" style="width:5%"/>
	           </td>
	        </tr>
	        <tr>
	           <td width="14%" class="CaptionTD" align="right"><html:title id="di_JiaoXueMS"/></td>
	           <td class="DataTD">
	           		<html:radiobox id="di_JiaoXueMS"  modeStyle="FormElement ui-widget-content ui-corner-all" style="width:5%"/>
	           </td>
	        </tr>
	        <tr>
	           <td width="14%" class="CaptionTD" align="right"><html:title id="di_BeiKeMS"/></td>
	           <td class="DataTD">
	           		<html:radiobox id="di_BeiKeMS"  modeStyle="FormElement ui-widget-content ui-corner-all" style="width:5%"/>
	           </td>
	        </tr>
	        <tr>
	           <td width="14%" class="CaptionTD" align="right"><html:title id="di_ZhuangTai"/></td>
	           <td class="DataTD">
	           		<html:radiobox id="di_ZhuangTai"  modeStyle="FormElement ui-widget-content ui-corner-all" style="width:5%"/>
	           </td>
	        </tr>
	        <tr>
	           <td width="14%" class="CaptionTD" align="right"><html:title id="di_BianMuBH"/></td>
	           <td class="DataTD">
	           		<html:select id="di_BianMuBH" enumSQL="select bianmumc,bianhao from jskj_kechengbm where shangjibh='root'"  modeStyle="FormElement ui-widget-content ui-corner-all" style="width:92%"/>
	           </td>
	        </tr>
	         <tr>
	          <td  width="14%" class="CaptionTD" align="right"><html:title id="di_KeChengTS" /></td>
	          <td class="DataTD">
		          <html:hidden id="di_KeChengTS" />
		          <textarea  id="KeChengTS" name="KeChengTS"></textarea>
	          </td>
	        </tr>
     	 </tbody>
     </table>
    </span>
   </div>  
   		<html:hidden id="di_BianHao"/>
   		<html:hidden id="di_JianLiR" />
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
	jhnrEditor.setData($("#di_KeChengTS").val());
});
 </script>
</body>
</html>
