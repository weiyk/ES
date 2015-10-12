<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<html>
<head>
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<!-- jquery -->
<%@include file="/common/jquery.jspf" %>
<%--ztree --%>
<%@include file="/common/ztree.jspf" %>
<%-- jquery验证 --%>
<%@include file="/common/jquery.validate.jspf" %>
<!-- ui -->
<%@include file="/common/ui.jspf"%>
<%-- jqgrid --%>
<%@include file="/common/jqgrid.jspf"%>	
	
<html:dialog id="GNDH_ShuJuZDCX" />
<script type="text/javascript">
	<%--刷新树--%>
	function afterCloseDialog(){
		$(this)._refreshTreeNode('jiheytree',function(){
			$("#DHSJZ_ShuJuZDMX").trigger("reloadGrid");
		});
	}
	$().ready(function(){
		$('body').layout({ 
			applyDefaultStyles: true,  
			west: {
				size: 220
			}   	
	    });
		$("#MLKZ_TongBu").bind('click',function(){
			$.ajax({
				url:path+'/servlet/AjaxServlet',
				type:"post",
				traditional:true,
				async:false,
				data:{service:"com.rc.web.ajax.ShuJuZDTBService",
					parameter:["NeiRong"],
					value:['']},
				success: function(result){
					alert("同步成功！");
					},
				error: function(err) {
					if('_qam_ajax_error'==result){
						alert("同步失败！");
					}else{
						alert("同步成功！");
					}
	                
	            }
			});
		});
	});
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
	<%--保存校验--%>
	function save(){
		var data={};		
		data = {"_qam_dialog":"GNDH_ShuJuZDCX","_qam_command":"MLKZ_BaoCun","cs_JiHeYBM":$("#cs_JiHeYBM").val(),"rc_datatype":"json","_dialog_submit_":"GNDH_ShuJuZDCX","_rc_dialog_groupid":"DHSJZ_ShuJuZDMX","_rc_sortname":"{}","_rc_istreegrid":false,"_qam_dialog_state":"DHZT_ChaXun"};		
		var ids = $("#DHSJZ_ShuJuZDMX").getDataIDs();
		var idss = $("#DHSJZ_ShuJuZDMX").getDataIDs();
		var flag = false;//编号是否重复
		var value_flag = false;//值是否重复
		var jy ;//校验指标,金额是否为空的提示语
		$.each(ids,function(i,id){
			var bm = $("#di_BIANMA_"+(id-1)).val() || $('#DHSJZ_ShuJuZDMX').getCell(id,'di_BIANMA');
			var zhi = $("#di_ZHI_"+(id-1)).val() || $('#DHSJZ_ShuJuZDMX').getCell(id,'di_ZHI');
			if($("#_qam_row_state_DHSJZ_ShuJuZDMX_"+(id-1)).val()=='u'||$("#_qam_row_state_DHSJZ_ShuJuZDMX_"+(id-1)).val()=='i'){
				var bianma=$("#di_BIANMA_"+(id-1)).val();
				if(bianma==""||bianma==null){
					jy=("编码不能为空");
					return false;
				}
				if(!$(this)._checkLength(bianma,50)){
					jy=("编码过长,最大长度为50个字符(一个汉字为两个字符)");
					return false;
				}
				//var di_zhi=$("#di_ZHI_"+(id-1)).val();
				if((zhi=="" || zhi==null) || (zhi.indexOf('<input') != -1 || zhi.indexOf('<INPUT') != -1)){
					jy=("值不能为空");
					return false;
				}
				if(!$(this)._checkLength(zhi,50)){
					jy=("值过长,最大长度为50个字符(一个汉字为两个字符)");
					return false;
				}
			}
			if(bm && zhi){
				$.each(idss, function(i1, id1) {
					//不比较自己
					if (id != id1 &&  $("#_qam_row_state_DHSJZ_ShuJuZDMX_"+(id-1)).val()!='d' &&  $("#_qam_row_state_DHSJZ_ShuJuZDMX_"+(id1-1)).val()!='d') {
						var bm1 = $("#di_BIANMA_"+(id1-1)).val() || $('#DHSJZ_ShuJuZDMX').getCell(id1,'di_BIANMA');
						var zhi1 = $("#di_ZHI_"+(id1-1)).val() || $('#DHSJZ_ShuJuZDMX').getCell(id1,'di_ZHI');
						if (bm == bm1 ) {
							flag = true;
							return false;
						}
						if(zhi == zhi1){
							value_flag = true;
							return false;
						}
					}
				});
			}
		});
		if(jy){
			$(this)._alert('提示',jy);
			return false;
		}
		if(flag){
			$(this)._alert('提示','不能输入相同的编码');
			return false;
		}
		if(value_flag){
			$(this)._alert('提示','不能输入相同的值');
			return false;
		}
		//数据字典
		$.each(ids,function(i,id){
    		if($('#di_BIANMA_'+(id-1)).attr('id')){
   				data["di_BIANMA_"+(i)] =$("#di_BIANMA_"+(id-1)).val();
   				data["di_ZHI_"+(i)] = $("#di_ZHI_"+(id-1)).val();
   				data["di_ZHUANGTAI_"+(i)] = $("#di_ZHUANGTAI_"+(id-1)).val();
   				data["di_YC_BianMa_"+(i)] = $("#di_YC_BianMa_"+(id-1)).val();
   			}else{
   	   			//汉字强转数字
   				//data["di_BIANMA_"+(i)]= Number(jQuery("#DHSJZ_ShuJuZDMX").getCell(id,'di_BIANMA') || 0);
   				data["di_BIANMA_"+(i)]= jQuery("#DHSJZ_ShuJuZDMX").getCell(id,'di_BIANMA' ) ;
   				data["di_ZHI_"+(i)] = jQuery("#DHSJZ_ShuJuZDMX").getCell(id,'di_ZHI') ;
   				data["di_ZHUANGTAI_"+(i)] = jQuery("#DHSJZ_ShuJuZDMX").getCell(id,'di_ZHUANGTAI') ;
   				data["di_YC_BianMa_"+(i)] = jQuery("#DHSJZ_ShuJuZDMX").getCell(id,'di_YC_BianMa') ;
   			}
   			data["_qam_row_state_DHSJZ_ShuJuZDMX_"+(i)]=$("#_qam_row_state_DHSJZ_ShuJuZDMX_"+(id-1)).val();
	 	});
		data["_qam_rowcount_DHSJZ_ShuJuZDMX"]=$("#_qam_rowcount_DHSJZ_ShuJuZDMX").val() ;
		$(this)._post(data,function(){
			if(!$('#cs_JiHeYBM').val()){
				$('#cs_JiHeYBM').val('NULL');
			}
			var con = ['cs_JiHeYBM'];
			 $("#DHSJZ_ShuJuZDMX")._search("DHSJZ_ShuJuZDMX",'MLKZ_ChaXun',con,'DHZT_ChaXun');
		});
	}
	function afterSelectRow(id,groupId){
		if('DHSJZ_ShuJuZDMX' == groupId){
			if(!$("#cs_JiHeYBM").val()){
				$("#DHSJZ_ShuJuZDMX").delRowData(id);
			}
			$("#di_ZHI_"+(id-1)).bind('keyup',function(){
				ExtFunctionCM.inputRegExp(this,'(^[0-9\u4e00-\u9fa5\dA-Za-z_\(\)\（\）]{1,50}$)');
			});
		}	
	}
	//tree点击事件
	function onClick(event,treeId,treeNode){
	    var processUnitid;
		if (treeNode.id){
			processUnitid = 'SWDY_ShuJuZDMXCX';
		}	
		$("#cs_JiHeYBM").val(treeNode.id);
		$("#cs_MINGCHENG").val(treeNode.name);
		var jiheylx=treeNode.JiHeYLX;
		if(jiheylx=='3'){
			$('#MLKZ_BaoCun').hide();
		}else{
			$('#MLKZ_BaoCun').show();
		}
		var ids = $("#DHSJZ_ShuJuZDMX").getDataIDs();
		var flag = true;
		$.each(ids,function(i,id){
			var rowState =  $("#_qam_row_state_DHSJZ_ShuJuZDMX_"+(id-1)).val() || $("#DHSJZ_ShuJuZDMX").getCell(id,'_qam_row_state_DHSJZ_ShuJuZDMX');
			if('d' == rowState || 'i' == rowState || 'u' == rowState){
				flag = false;
				return false;
			}
		});
		if(flag == false){
			$(this)._confirm('确认','您是否放弃保存，确认进行下一步操作，若要保存请点取消！',350,180,function(param){
				 if(1 == param){
					<%--提交--%>
					if(treeNode.id){
						var con = ['cs_JiHeYBM'];
					    $(this)._search("DHSJZ_ShuJuZDMX",'MLKZ_ChaXun',con,'DHZT_ChaXun',processUnitid);
					}else{
						$("#cs_JiHeYBM").val("1");
						var con = ['cs_JiHeYBM'];
					    $(this)._search("DHSJZ_ShuJuZDMX",'MLKZ_ChaXun',con,'DHZT_ChaXun');
					}
					
				 }
			 });
		}
		else{
			if(treeNode.id){
				var con = ['cs_JiHeYBM'];
			    $(this)._search("DHSJZ_ShuJuZDMX",'MLKZ_ChaXun',con,'DHZT_ChaXun',processUnitid);
			}else{
				$("#cs_JiHeYBM").val("1");
				var con = ['cs_JiHeYBM'];
			    $(this)._search("DHSJZ_ShuJuZDMX",'MLKZ_ChaXun',con,'DHZT_ChaXun');
			}
		} 
	}
	
	<%--重新计算grid宽度--%>
 	function resizeGrid(groupId){
 		var ss = getPageSize();
		$("#"+groupId).jqGrid('setGridWidth', ss.WinW-250);
 	}
 	function beforeClick(treeId,treeNode,clickFlag){
 		if (!treeNode.id){
			$(this)._alert('提示','请选择下级节点');
			return false;
		}
 	}
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<html:form>
	<html:hidden id="di_JiHeYLX" />
	<div class="ui-layout-west">
		<div class="ui-layout-content">
		     <html:ztree id="jiheytree" tableName="VIEW_SHUJUZD" rootText="数据字典" events="onClick:onClick,beforeClick:beforeClick" otherField="MINGCHENG,JiHeYLX" condition=" JIHEYLX <> 0" idField="BIEMING" parentField="SHANGJI" textField="MINGCHENG" />
		</div>
	</div>
	<div class="ui-layout-center" style="overflow: hidden;">
		<table width="99%" border="0" cellspacing="0" cellpadding="0" align="center" class="ui-jqdialog-content ui-widget-content">
			<tr>
				<td align="right">
					<html:command id="MLKZ_BaoCun" />
					<!-- 
					<html:command id="MLKZ_TongBu" />
					-->
				</td>
			</tr>
		</table> 
		<div class="ui-jqdialog-content ui-widget-content">
			<html:jqgrid id="DHSJZ_ShuJuZDMX" sortable="false" shrinkToFit="false" rownumbers="true" pager="pager" autoWidth="false" doResize=""  height="340" multiSelect="false" delRow="true"/>
		</div>
		</div>
	<html:paraSave/>
		<script type="text/javascript">	
		$(function(){
			$(window).wresize(function(){
				content_resize($('#DHSJZ_ShuJuZDMX'),window,255);
			});
			content_resize($('#DHSJZ_ShuJuZDMX'),window,255,125);
		});
	</script>
</html:form>
</body>
</html>