<%@page language="java" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<%-- ztree --%>
<%@include file="/common/ztree.jspf"%>
<html:dialog id="GNDH_KeChengBMCX"  async="false"/>
<style >
	.ztree li button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
</style>
<script type="text/javascript"> 
	function afterCloseDialog(){
		$(this)._refreshTreeNode("tree",function(){
	   		$("#DHSJZ_ChaXunJG").trigger("reloadGrid");
		});
	}
	$().ready(function(){
	    $('body').layout({ 
			applyDefaultStyles: false,  
			west: {
				size: 220
			}   
	 	});
	  	$("#MLKZ_ChaXun").bind('click',function(){
	   		var con = ['dc_BianMuBM','dc_BianMuMC','cs_ShangJi'];
	   		$(this)._search('DHSJZ_ChaXunJG','MLKZ_ChaXun',con);
	   		bianHao='';
	   	});
	  	$("#MLKZ_XinZeng").bind('click',function(){
	  		var treeObj = $.fn.zTree.getZTreeObj("tree");
			var nodes = treeObj.getSelectedNodes();
			if(nodes.length==0){   
				$(this)._alert('提示',"请选择节点！"); 
				return false; 
			}
			if(nodes[0].ShiFouDC=='1'){
				$(this)._alert('提示',"该节点为底层节点，不允许添加节点，请选择节点！"); 
				return false; 
			}
			
			
			// 设置只允许添加三级
			var cs_ShiFouDC = "2";
			var pId = nodes[0].pId;
			if (pId != null && pId != 'root') {
				var shangji = ExtFunctionCM.GetOneFieldValue("jskj_kechengbm ","shangjibh"," where bianhao ='"+ pId +"'");
				if (shangji != "root") {
					$(this)._alert('提示',"该节点为底层节点，不允许添加节点，请选择节点！"); 
					return false;
				} else {
					// 当前选中的为第二层节点，设置将要添加的节点底层标识
					cs_ShiFouDC = "1";
				}
			}
			
			var sj = nodes[0].id || 'root';
			var mc=nodes[0].name || '';
			$(this)._dialog('${path}/servlet/jspdispatchservlet?_qam_dialog=GNDH_KeChengBMBJ&_qam_dialog_state=DHZT_XinZeng&&cs_ShangJi='+sj+'&cs_ShangJiMC='+nodes[0].name+"&cs_ShiFouDC=" + cs_ShiFouDC,'GNDH_KeChengBMBJ',600,300,'课程编目新增');
		});
		//编辑
		$("#MLKZ_BianJi").bind('click',function(){
			var ids = $("#DHSJZ_ChaXunJG").getGridParam('selarrrow');
			var bianhao = $("#DHSJZ_ChaXunJG").getCell(ids[0],'di_BianHao')||$("#di_BianHao_"+(ids[0]-1)).val();
			if(ids.length==1&&bianhao){
				$(this)._dialog('${path}/servlet/jspdispatchservlet?_qam_dialog=GNDH_KeChengBMBJ&_qam_dialog_state=DHZT_XiuGai&&cs_BianHao='+bianhao,'GNDH_KeChengBMBJ',600,300,'课程编目编辑');
			}else{
				$(this)._alert('提示','请选择一条记录编辑！'); 
				return false;
			}
		});
	  	<%--删除--%>
	  	$("#MLKZ_ShanChu").bind('click',function(){
	  		//var ids = $("#DHSJZ_ChaXunJG").getGridParam('selarrrow');
	  		if(!$(this)._isCheck('DHSJZ_ChaXunJG')){
				$(this)._alert('提示','请选择一条记录！');
				return ;
			}
	  		var ids = $("#DHSJZ_ChaXunJG").getGridParam("selarrrow");
	  		var ts='';
	  		$.each(ids,function(i,id){
		  		var di_BianHao = $("#di_BianHao_" + (id-1)).val() || $("#DHSJZ_ChaXunJG").getCell(id,"di_BianHao");
		  		var count = ExtFunctionCM.GetOneFieldValue("JSKJ_KeChengBM ","count(*)","where shangjibh ='"+di_BianHao+"'");
		  		if(count > 0){
		  			ts='你所选的记录存在下级编目，不允许删除！';
		  			return false;
		  		}
	  		});
	  		if(ts){
	  			$(this)._alert('提示',ts);
	  			return false;
	  		}
	  		$(this)._delRecord('DHSJZ_ChaXunJG','MLKZ_ShanChu','di_BianHao','',function(){
	  			$(this)._refreshTreeNode("tree"); 
	  			$('#MLKZ_ChaXun').click();
	  		});
		});
	});
	 //tree点击事件
	function onClick(event, treeId, treeNode){
 		if(treeNode.id){
 			$("#cs_ShangJi").val(treeNode.id);
 		}else{
 			$("#cs_ShangJi").val('');
 		}
 		$('#MLKZ_ChaXun').click();
	}	

	<%--添加管理组织--%>
	function add(){
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		var nodes = treeObj.getSelectedNodes();
		if(nodes.length==0){   
			$(this)._alert('提示',"请选择节点"); 
			return false; 
		}
		var sj = nodes[0].id || '';
		$(this)._dialog('${path}/servlet/jspdispatchservlet?_qam_dialog=GNDH_GLZZXZ&_qam_dialog_state=DHZT_XZ&cs_ShangJiZZBH='+sj+'&cs_ShangJiZZMC='+nodes[0].name+'&cs_ShangJiZZLX='+nodes[0].ZuZhiLX+'&_qam_para_source=','GNDH_GLZZXZ',800,500,'管理组织新增');
	}
	function queding(){
		$("#MLKZ_ChaXun").click();
	}		
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<html:form>
	<div class="ui-layout-west"> 
		<div class="ui-layout-content">
	    <html:ztree id="tree" tableName="JSKJ_KeChengBM" rootId="root" rootText="课程编目" events="onClick:onClick" otherField="BianMuBM,ShiFouDC" idField="BianHao" parentField="ShangJiBH" textField="BianMuMC" orderField="BianHao"/>
    </div>
    </div>
	<div class="ui-layout-center">
		<div class="ui-jqdialog-content ui-widget-content">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="ui-jqdialog-content ui-widget-content">
				<tr>
					<td  width="1%" align="left" class="CaptionTD"><html:title id="dc_BianMuBM"/></td>
					<td class="DataTD" width="18%"><html:text modeStyle="FormElement ui-widget-content ui-corner-all" style="width:95%" id="dc_BianMuBM"/></td>
					<td  width="8%" align="right" class="CaptionTD"><html:title id="dc_BianMuMC"/></td>
					<td class="DataTD" width="18%"><html:text modeStyle="FormElement ui-widget-content ui-corner-all" style="width:95%" id="dc_BianMuMC"/></td>
					
					<td align="right">
	             		<html:command id="MLKZ_ChaXun"/>
						<html:command id="MLKZ_XinZeng"/>
						<html:command id="MLKZ_BianJi"/>
						<html:command id="MLKZ_ShanChu"/>
					</td>
				</tr>
			</table>			
			<html:jqgrid id="DHSJZ_ChaXunJG" processUnitId="SWDY_CX" processId="GNSW_KeChengBMCX" rownumbers="true" doResize="" pager="pager" shrinkToFit="true" autoWidth="true"  height="350" multiSelect="true"/>
		</div>
	</div>
 	<html:paraSave/>
 		<script type="text/javascript">
		$(function(){
			$(window).wresize(function(){
				content_resize($('#DHSJZ_ChaXunJG'),window,232,$(window).height()*0.30);
			});
			content_resize($('#DHSJZ_ChaXunJG'),window,232,$(window).height()*0.30);
		});
	</script>	 
</html:form>
</body>
</html>
	