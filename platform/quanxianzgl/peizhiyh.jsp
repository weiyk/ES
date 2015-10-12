 <%@ page language="java"  contentType="text/html;charset=UTF-8"%>

<html>
<head>
<%@include file="/common/framework.jspf"%>
	<%-- jquery --%>	
		<%@include file="/common/jquery.jspf"%>
	<%-- jqgrid --%>
		<%@include file="/common/jqgrid.jspf"%>
	<%-- ui --%>
		<%@include file="/common/ui.jspf"%>
<title>配置权限组用户</title>
<script type="text/javascript">
	function afterSelectRow(id,groupId){
		if(groupId == 'ChaXunJG'){
			$("#_qam_row_state_"+groupId+"_"+(id-1)).val("i");
		}
	}
	$().ready(function(){
		$("#ChaXun").bind('click',function(){
			var con = ['dc_XingMing','dc_DengLuM'];//查询条件
   			$(this)._search('ChaXunJG','ChaXun',con);
		});
		
		$("#QueDing").bind('click',function(){
			var ids = $('#ChaXunJG').getGridParam('selarrrow');
			$.each(ids,function(i,id){
				$("#_qam_row_state_ChaXunJG_"+(id-1)).val("i");
			});
			$(this)._submit('/eschool/servlet/jspcontrolservlet?_qam_command=QueDing&_qam_dialog=PeiZhiYH&_dialog_submit_=PeiZhiYH');
		});
		
		
	});
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<html:dialog id = "PeiZhiYH"/>
<form name="form1" method="post" cation = "">
<table width="100%" STYLE="border-collapse:collapse;" class="ui-jqdialog-content ui-widget-content">
				<!--命令控制区域，显示按按钮与标题栏-->
				<tr>
					<td colspan="99">
			  			<div class="main_title">
										<div class="title_left" id="navigation">
										</div>
											<div align="right">
						              			<html:command id="ChaXun" modeStyle="f_btn01"/>
						              			<html:command id="QueDing" modeStyle="f_btn01"/>
						              			<html:command id="GuanBi" modeStyle="f_btn01"/>
											</div>
										</div>
  					</td>
				</tr>
				<!--命令控制区域，显示按按钮与标题栏结束-->
</table>
<table width="100%" cellspacing="0" cellpadding="2" align="center" class="ui-jqdialog-content ui-widget-content">
	<tr id="" class="td02">
		<td  class="CaptionTD" align="right" width="5%">用户姓名</td>
		<td class="DataTD"  width="30%"><input  type="text" id="dc_XingMing" name="dc_XingMing" maxlength="20" class="FormElement ui-widget-content ui-corner-all" style="width:80%"></td>
		<td  class="CaptionTD"  align="right"  width="5%">登录账号</td>
		<td class="DataTD"  width="30%"><input type="text" id="dc_DengLuM" name="dc_DengLuM" maxlength="20" class="FormElement ui-widget-content ui-corner-all" style="width:80%"></td>
	</tr>
</table>
<html:jqgrid id="ChaXunJG" rownumbers="true" shrinkToFit="true" pager="pager" multiSelect="true" multiboxonly="false" autoWidth="true"  height="210" />
<html:paraSave/>
</form>
</body>
<html:insertBlankRow/>
</html>