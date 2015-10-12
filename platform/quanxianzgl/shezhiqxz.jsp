<%@page language="java" contentType="text/html;charset=UTF-8"%>
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
<title>权限组用户</title>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<html:dialog id = "QuanXianZSZYH"   />
<script type="text/javascript">
		function afterCloseDialog(){
			var con = ['dc_XingMing','dc_DengLuM'];//查询条件
   			$(this)._search('QuanXianZYH','ChaXun',con);
		}
		$().ready(function(){
			$("#ChaXun").bind('click',function(){
				var con = ['dc_XingMing','dc_DengLuM'];//查询条件
    			$(this)._search('QuanXianZYH','ChaXun',con);
			});
			$("#PeiZhiYH").bind('click',function(){
				var cs_QuanXianZBH=$("#cs_QuanXianZBH").val();
				$(this)._fifthDialog('<%=request.getContextPath()%>/platform/quanxianzgl/peizhiyh.jsp?_qam_dialog=PeiZhiYH&_qam_dialog_state=Query&cs_QuanXianZBH='+cs_QuanXianZBH,'PeiZhiYH',550,370,'配置权限组用户');
	       	});
	       	$("#ShanChu").bind('click',function(){
				if(!$(this)._isCheck('QuanXianZYH')){
					$(this)._alert('提示','请选择一条记录！');
					return ;
				}
	            $(this)._delRecord('QuanXianZYH','ShanChu','di_BianHao',null,function(){
	            	var con = ['dc_XingMing','dc_DengLuM'];//查询条件
	    			$(this)._search('QuanXianZYH','ChaXun',con);
	            });
	       	});
	       
		});
		</script>
<html:form>
<table width="100%" STYLE="border-collapse:collapse;" class="ui-jqdialog-content ui-widget-content">
				<!--命令控制区域，显示按按钮与标题栏-->
				<tr>
					<td colspan="99">
			  			<div class="main_title">
										<div class="title_left" id="navigation">
										
										</div>
										<div align="right">
			              			<html:command id="ChaXun" modeStyle="f_btn01"/>
			              			<html:command id="PeiZhiYH"  modeStyle="f_btn01"/>
			              			<html:command id="ShanChu" modeStyle="f_btn01"/>
			              			<html:button id="guanBi" value="关闭" modeStyle="f_btn01" onclick="$(this)._close();"/>
								</div>
								</div>
  					</td>
				</tr>
				<!--命令控制区域，显示按按钮与标题栏结束-->
</table>
<table id="ChaXunTJ" align="center" border =0 width="100%"  class="ui-jqdialog-content ui-widget-content">
	<tr id="" class="td02">
		<td  class="CaptionTD" align="right" width="5%">用户姓名</td>
		<td class="DataTD"  width="30%"><input  type="text" id="dc_XingMing" name="dc_XingMing" maxlength="20" class="FormElement ui-widget-content ui-corner-all" style="width:80%"></td>
		<td  class="CaptionTD"  align="right"  width="5%">登录账号</td>
		<td class="DataTD"  width="30%"><input type="text" id="dc_DengLuM" name="dc_DengLuM" maxlength="20" class="FormElement ui-widget-content ui-corner-all" style="width:80%"></td>
	</tr>
</table>
<html:jqgrid id="QuanXianZYH" rownumbers="true" shrinkToFit="true" pager="pager" multiSelect="true" multiboxonly="false" autoWidth="true"  height="230" />
<html:paraSave/>
</html:form>
</body>
</html>
