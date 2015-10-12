<%@page language="java" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<%-- 平台 --%>
	<%@include file="/common/framework.jspf"%>
<%-- jquery --%>	
	<%@include file="/common/jquery.jspf"%>
<%-- jqgrid --%>
	<%@include file="/common/jqgrid.jspf"%>
<%-- ui --%>
	<%@include file="/common/ui.jspf"%>
<%-- over --%>	
	<%@include file="/common/ztree.jspf" %>
		<html:dialog id="GNDH_YongHuGLCX" async="false"/>
<script type="text/javascript">
/**
 * JQGrid的默认对象为grid_+对话数据组id
 */
	var bianHao;//编号
	function afterSelectRow(id,groupId){
		var rowData = $("#"+groupId).getRowData(id);
		bianHao = rowData['di_BianHao'];
	}
	function afterCloseDialog(){
		$("#MLKZ_ChaXun").click();
	}
	$().ready(function(){
		 var pageLayout = $('body').layout({ 
				applyDefaultStyles: false,  
				south: {
					size: '50%'
				}   
			 });
		//查询
		$("#MLKZ_ChaXun").bind('click',function(){
			var con = ['dc_ZhangHu','dc_XingMing','dc_ShenFenLX'];//查询条件
			$(this)._search('DHSJZ_ChaXunJG','MLKZ_ChaXun',con);
			bianHao='';
		});
		$("#MLKZ_TongBu").bind('click',function(){
			var result='';
			$.ajax({
				url:path+'/servlet/AjaxServlet',
				type:"post",
				traditional:true,
				async:false,
				data:{service:"com.rc.web.ajax.YongHuXXTBService",
					parameter:["NeiRong"],
					value:['']},
				complete:function(XHR, TS){
					result = XHR.responseText;
					if(result){
						alert("同步失败！");
					}else{
						$("#MLKZ_ChaXun").click();
					}
					XHR = null;
				}
				
			});
		});
		//新增
		$("#MLKZ_XingZeng").bind('click',function(){
			$(this)._dialog('${path}/servlet/jspdispatchservlet?_qam_dialog=GNDH_YongHuGLBJ&_qam_dialog_state=DHZT_XinZeng&','GNDH_YongHuGLBJ',770,380,'用户管理新增');
		});
		//编辑
		$("#MLKZ_BianJi").bind('click',function(){
 	  		var ids = $("#DHSJZ_ChaXunJG").getGridParam('selarrrow');
 	  		var bianHao = jQuery('#DHSJZ_ChaXunJG').getCell(ids[0],'di_BianHao') || $("#di_BianHao_"+(ids[0]-1)).val();
 	  		var leixing = jQuery('#DHSJZ_ChaXunJG').getCell(ids[0],'di_LeiXing') || $("#di_LeiXing_"+(ids[0]-1)).val();
 	  		
  			if(ids.length==1&&bianHao){
  				if(leixing=='1'){
 					$(this)._dialog('${path}/servlet/jspdispatchservlet?_qam_dialog=GNDH_YongHuGLBJ&_qam_dialog_state=DHZT_XiuGai&cs_BianHao='+bianHao,'GNDH_YongHuGLBJ',770,380,'用户管理编辑');
  				}else{
  	 	  			$(this)._alert('提示','该记录不能修改，请重新选择！');
  	 	  		}
  			}else{
 				$(this)._alert('提示','请选择一条记录编辑！');
 				return false;
 			}

 	  		
 	  		
 	  	});
		//删除 不能跟行状态关联。
		$("#MLKZ_ShanChu").bind('click',function(){
			if(!$(this)._isCheck("DHSJZ_ChaXunJG")){
				$(this)._alert('提示','请至少选择一条记录！');
				return ;
			}
			var sc='';
			var ids = $("#DHSJZ_ChaXunJG").getGridParam('selarrrow');
			$.each(ids,function(i,id){
				var leixing = $("#di_LeiXing_"+(id-1)).val()||jQuery('#DHSJZ_ChaXunJG').getCell(id,'di_LeiXing');
				if(leixing!='1'){
					sc='第'+id+'条记录不能删除，请重新选择！';
				}
			});
			if(sc){
 	  			$(this)._alert("提示",sc);
				return false
 	  		}
            $(this)._delRecord('DHSJZ_ChaXunJG','MLKZ_ShanChu','di_BianHao',null,function(){
            	var con = ['dc_DengLuM','dc_ZhuangTai','dc_YeWuDW'];//查询条件
    			$(this)._search('DHSJZ_ChaXunJG','MLKZ_ChaXun',con);
    			bianHao='';
            });
         });
	});
	
		
	function chongzhi(){
		//重置密码
		var postData = {"_qam_dialog":"GNDH_YongHuGLCX","_qam_command":"MLKZ_CZMM","rc_datatype":"json","_dialog_submit_":"GNDH_YongHuGLCX","_rc_dialog_groupid":"DHSJZ_ChaXunJG"};
		var xuanzhong =	jQuery("#DHSJZ_ChaXunJG").getGridParam("selarrrow");
		if(xuanzhong.length>0){
			var sc='';
			$.each(xuanzhong,function(i,id){
				var leixing = $("#di_LeiXing_"+(id-1)).val()||jQuery('#DHSJZ_ChaXunJG').getCell(id,'di_LeiXing');
				if(leixing!='1'){
					sc='第'+id+'条记录不能重置密码，请重新选择！';
				}
				postData["_qam_row_state_DHSJZ_ChaXunJG_"+(id-1)] = "u";
				postData['di_BianHao_'+(id-1)] = $("#di_BianHao_"+(id-1)).val();
				postData['di_YCDLM_'+(id-1)] = $("#di_YCDLM_"+(id-1)).val();
				postData['cs_KouLing'] = "123456";
			});
			if(sc){
 	  			$(this)._alert("提示",sc);
				return false
 	  		}
			//
			<%-- grid行数 --%>
			postData['_qam_rowcount_DHSJZ_ChaXunJG'] = $("#_qam_rowcount_DHSJZ_ChaXunJG").val();
			$(this)._post(postData,function(){
				$(this)._alert('提示','重置密码成功,密码已改为初始密码:123456！');
			});
			return true ;
		}else{
			$(this)._alert('提示','请选择要重置密码的用户！！');
			return ;
		}
	}
	<%--调看--%>
	function dk (index){
		var bh =  $("#di_BianHao_"+index).val() || $('#DHSJZ_ChaXunJG').getCell((index+1),'di_BianHao');
		var leixing =  $("#di_LeiXing_"+index).val() || $('#DHSJZ_ChaXunJG').getCell((index+1),'di_LeiXing');
		var image=$("#di_Image_"+index).val() || $('#DHSJZ_ChaXunJG').getCell((index+1),'di_Image');
		if(leixing=='1'){
			$(this)._dialog('${path}/servlet/jspdispatchservlet?_qam_dialog=GNDH_YongHuGLBJ&_qam_dialog_state=DHZT_DiaoKan&cs_BianHao='+bh,'GNDH_YongHuGLBJ',770,380,'用户管理调看');
		}else{
			$(this)._dialog('${path}/servlet/jspdispatchservlet?_qam_dialog=GNDH_YongHuGLDK&_qam_dialog_state=DHZT_DiaoKan&cs_BianHao='+bh+'&cs_Image='+image,'GNDH_YongHuGLDK',850,430,'用户管理调看');
			
		}
			
		
	}
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	
	<div class="ui-layout-center" >
	<html:form other="class='FormGrid'">
   		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="ui-jqdialog-content ui-widget-content">
			<tr>
				<td  id="yonghu_more" class="CaptionTD"  width="1%"><html:title id="dc_ZhangHu"/></td>
				<td class="DataTD"   width="12%"><html:text modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_ZhangHu" style="width:95%"/></td>				
				<td  id="yonghu_more" class="CaptionTD"  width="1%">用户姓名</td>
				<td class="DataTD"   width="12%"><html:text modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_XingMing" style="width:95%"/></td>				
				<td   class="CaptionTD"  width="1%"><html:title id="dc_ShenFenLX"/></td>
				<td class="DataTD" width="12%"><html:select  modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_ShenFenLX" initText="请选择" style="WIDTH:95%" ></html:select> </td>
				<td align="right">
             		<html:command id="MLKZ_ChaXun"/>
 					<html:command id="MLKZ_XingZeng"/>
					<html:command id="MLKZ_BianJi"/>
					<html:command id="MLKZ_ShanChu"/>
					<html:command id="MLKZ_CZMM"/>	
					<html:command id="MLKZ_TongBu"/>	
				</td>
			</tr>
		</table>  	
		<%-- --%>
		<html:jqgrid doResize="" processUnitId="SWDY_ChaXun" processId="GNSW_YongHuGLCX" rownumbers="true" id="DHSJZ_ChaXunJG" pager="pager" autoWidth="true" height="300" multiSelect="true"/>
		<html:paraSave/>
	<script type="text/javascript">
		$(function(){
			$(window).wresize(function(){
				content_resize($('#DHSJZ_ChaXunJG'),window,5,$(window).height()*0.3);
			});
			content_resize($('#DHSJZ_ChaXunJG'),window,5,$(window).height()*0.3);
		});
	</script>
	</html:form>
</div>
</body>
</html>