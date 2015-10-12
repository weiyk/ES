<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<html>
	<head>
	<%-- 平台 --%>
		<%-- 平台 --%>
	<%@include file="/common/framework.jspf"%>
	<%-- jquery --%>	
		<%@include file="/common/jquery.jspf"%>
	<%-- jqgrid --%>
		<%@include file="/common/jqgrid.jspf"%>
	<%-- ui --%>
		<%@include file="/common/ui.jspf"%>
	<%-- 验证 --%>
	<%@include file="/common/jquery.validate.jspf" %>
		<html:dialog id ="QuanXianZBJ"/>
		<title>权限组编辑</title>
		<script type="text/javascript">
			$().ready(function(){
				$("#PeiZhiYH").bind('click',function(){
					var cs_QuanXianZBH=$("#cs_ShangJiBH").val();
					$(this)._otherDialog('<%=request.getContextPath()%>/platform/quanxianzgl/shezhiqxz.jsp?_qam_dialog=QuanXianZSZYH&_qam_dialog_state=Query&cs_QuanXianZBH='+cs_QuanXianZBH,'QuanXianZSZYH',0,370,'权限组设置用户');
		       	});
			});
			
		</script>
		<style type="text/css">
		.grid {position: relative; margin: 0em;padding: 0em; overflow-x: hidden; border-left: 0px none !important; border-top : 0px none !important; border-right : 0px none !important;border-bottom:solid 1px #b0d4f0;}
		.td_bg{border: 1px solid #cbe9f3;}
		.turnpage{border:0px;padding-left: 40px;}
		table{border: 1px solid #cbe9f3;}
		td{border: 1px solid #cbe9f3;}
		</style>
	</head>
	<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">	
		<html:form id="QuanXianZBJ">
			<table width="100%" STYLE="border-collapse:collapse;" class="ui-jqdialog-content ui-widget-content">
				<!--命令控制区域，显示按按钮与标题栏-->
				<tr>
					<td colspan="99">
			  			<div class="main_title">
										<div class="title_left" id="navigation">
										</div>
										<div align="right">
			              			<html:insertRowButton groupId="BianJiQXZ" value="插入空行" modeStyle="f_btn01"/><%if(!"rooter".equals(request.getParameter("cs_ShangJiBH"))){%>
			              			<html:command id="PeiZhiYH"/><%}%>
			              			<html:command id="BaoCun" modeStyle="f_btn01"/>
			              			<html:command id="GuanBi" modeStyle="f_btn01"/>
								</div>
								</div>
  					</td>
				</tr>
				<!--命令控制区域，显示按按钮与标题栏结束-->
			</table>
			<html:tabcontrol>
			<html:tabtitle tabNames="权限组,已配置用户"/>
				<html:tabpage index="1">
					<html:grid doCreateIndex="true" id="ShangJiQXZ" resetRowState="u" />
					<span class="content_L">下级权限组:</span>
					<html:grid doCreateIndex="true" id="BianJiQXZ"  doInsertRow="true"  doDelRow="false"  spanRowStyle="bordet:20px;"/>
				</html:tabpage>
				<html:tabpage index="2">
					<html:grid doCreateIndex="true" id="QuanXianZPZ"  doInsertRow="true" doDelRow="false"/>
				</html:tabpage>	
			</html:tabcontrol>
			<html:paraSave/>
		</html:form>
	</body>
	<html:insertBlankRow/><!--插入空行脚本-->
</html>