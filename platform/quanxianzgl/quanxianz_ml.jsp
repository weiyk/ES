<%@page language="java"  contentType="text/html;charset=UTF-8"%>
<% 
	/**
	*@author:masheng
	*@createdate:2006-5-20	
	*@description:响应点击权限组树，查询相应的下级权限组
	*@version: masheng 2006-5-21 修改参数名
	*@version: masheng 2006-5-22 修改控件显示方式
	**/
%>
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
	<%-- 验证 --%>
	<%@include file="/common/jquery.validate.jspf" %>
		<title>权限组目录</title>
		<html:dialog id ="QuanXianZCX"/>
		<script type="text/javascript">
		$().ready(function(){
			$("#ShanChu").bind('click',function(){
				if(!$(this)._isCheck('ChaXun')){
					$(this)._alert('提示','请选择一条记录！');
					return ;
				}
	            $(this)._delRecord('ChaXun','ShanChu','di_BianHao',null,function(){
	            	var con = [];//查询条件
	    			$(this)._search('ChaXun','MLKZ_ChaXun',con);
	    			//删除后重新加载树
	    			parent.document.getElementById("LeftTree").src='<%=request.getContextPath() %>/platform/quanxianzgl/quanxianz_tree.jsp?_qam_dialog_state=Query';
	            });
	            	
	       	});
		});
		//关闭编辑窗口时重新加载数据
		function afterCloseDialog(){
			var cs_ShangJiBH=$("#cs_ShangJiBH").val();
			parent.document.getElementById("LeftTree").src='<%=request.getContextPath() %>/platform/quanxianzgl/quanxianz_tree.jsp?_qam_dialog_state=Query';
			parent.document.getElementById("RightTree").src='<%=request.getContextPath()%>/platform/quanxianzgl/quanxianz_ml.jsp?_qam_dialog=QuanXianZCX&_qam_dialog_state=Query&cs_ShangJiBH='+cs_ShangJiBH ;	
		}
		</script>
	</head>
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">		 
		<html:form>
			<table width="100%" STYLE="border-collapse:collapse;" class="ui-jqdialog-content ui-widget-content">
				<tr>
					<td colspan="78">
			  			<div class="main_title">
										<div class="title_left" id="navigation">
											
										</div>
										<div align="right">
								<%if(!"rooter".equals(request.getParameter("cs_ShangJiBH"))){%>
								<html:command id="PeiZhi" modeStyle="f_btn01"/><%}%>
								<html:command id="TianJia" modeStyle="f_btn01"/>
								<html:command id="ShanChu" modeStyle="f_btn01"/>
								<html:command id="QingChu" modeStyle="f_btn01"/>
								<html:command id="GuanBi" modeStyle="f_btn01"/>
							</div>
							</div>
  					</td>
				</tr>
			</table>
			<%
				boolean doDel = !"XuanZe".equals(dialogState);
			%>
			
			<html:jqgrid  id="ChaXun" processUnitId="ChaXun" dialogState="Query" processId="QuanXianZCX" rownumbers="true" shrinkToFit="true" pager="pager" multiSelect="true" multiboxonly="false" autoWidth="true"  height="400" />
			<html:paraSave/>
		</html:form>
		<script type="text/javascript">
		$(function(){
			$(window).wresize(function(){
				content_resize($('#DHSJZ_ChaXunJG'),window,5);
			});
			content_resize($('#DHSJZ_ChaXunJG'),window,5,$(window).height()*0.19);
		});
	</script>
	</body>
</html>
