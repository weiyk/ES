<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
	* @author:牟春光

	* @writedate:2008-02
	* @description: 机构树形点选

	* @Email:moucg@qam.cn
--%>
<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<html>
  <head>
  	<base target="_self">  
<%@ page import="com.qam.web.extension.tree.*" %>
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<!-- jquery -->
<%@include file="/common/jquery.jspf" %>
<!-- ui -->
<%@include file="/common/ui.jspf"%>
<%-- jqgrid --%>
<%@include file="/common/jqgrid.jspf"%>	
<%--ztree --%>
<%@include file="/common/ztree.jspf" %>
 <!--出现树形结构引入此片段文件-->
<%@ include file="/common/script/xmltree.jspf" %>
<%
	boolean multiple="true".equals(request.getParameter("cs_DuoXuan"));	
	String yixuan = request.getParameter("cs_ShuJuXZ");
	String shujuxbm = request.getParameter("cs_ShuJuXBM");
	String tablename = request.getParameter("cs_TableName");

	String select_target = request.getParameter("select_target");
	String bianhao = request.getParameter("cs_BianHao");
	String shangjibh= request.getParameter("cs_ShangJiBH");
	String mingcheng = request.getParameter("cs_MingCheng");
	TreeCallBack callback = new TreeCallBack(yixuan,shujuxbm,multiple);	
%>
<html:dialog id="GNDH_Tree"/> 
    <title>机构</title>
  </head>

  <body>
<html:form>
	<table border="0" width="100%">
		<tr>	
			<td>
				关键字：&nbsp;<input type="text" value="请输入关键字" onchange="ExtFunctionCM.getObject('btn_search').value='搜索'" onclick="if('请输入关键字'==this.value){this.value='';}" id="dc_search" size="18" onkeyup="if(13==event.keyCode ||114==event.keyCode){doSearch();return ;}else{return;}" title=""><input type="button" class="f_btn01" id="btn_search" value="搜索" onclick="doSearch();">
			</td>
		
			<td align="right">				
				<html:command id="MLKZ_ChongZhi"/>
				<input type="button" class="f_btn01" value="选择" onclick="doXuanZe()">
				<input type="button" class="f_btn01" value="清除" onclick="doClear()">
				<input type="button" class="f_btn01" value="关闭" onclick="window.close()">
			</td>
		</tr>
	</table>
	<html:splitline width="100%"/>
	<br>
	 
  		<!--普通的tree树-->
  		<html:tree dataSource="" tableName="<%=tablename %>" id="tree2" treeName="jiGouTree" rootText="选择数据项" 
					rootId="" condition="" codeField="<%=shujuxbm %>" selectedValue="<%=yixuan %>" idField="<%=bianhao %>" 
					parentIdField="<%=shangjibh %>" tipField="<%=shujuxbm %>" textField="<%=mingcheng %>" 
					multiple="<%=multiple %>" treeCallBack="<%=callback %>"/>
  

</html:form>
  <SCRIPT language="javaScript"> 	    
 	var leixing=<%=multiple%>; 		
	/**
	*@author: masheng(masheng@qam.cn)
	*@description:双击节点返回节点参数
	*@parameters: 名称[id] 类型[String] 描述 当前节点编号
	*@parameters: 名称[title] 类型[String] 描述 当前节点名称
	*@parameters: 名称[leaf] boolean 描述 当前节点是否为底层节点 true 是；false 否

	*@parameters: 名称[node]: 类型[DOM元素] 描述 返回当前点击的节点，可以参考xml，通过node.getAttribute(属性名)来获取属性值		
	*@returnValue: 无

	**/		
	function doAfterdblClick(id,text,leaf,node){
		if(!leixing){
			doXuanZe();
		}	
	}
	
	/**
	*@author: masheng(masheng@qam.cn)
	*@description:返回选中的值

	*@returnValue: 无

	**/	
	function doXuanZe(){
		var bianHao ='';
		var mingCheng='';
				
		//单选多选判断

		if(!leixing){
		    //单选时最后选中的节点通过树的selectedNode属性获得

			if(!jiGouTree.selectedNode || jiGouTree.selectedNode.parentNode.nodeName!="treenode"){
				alert("请选择一个节点");
				return;
			}
			//获取节点的值，通过getAttribute("属性")获取，树中所定义的字段都可以为;
			bm = jiGouTree.selectedNode.getAttribute("<%=shujuxbm%>"); //编号
									
		}
		else{
			//多选时，选中的节点通过checkedNodes属性获得


			var length= jiGouTree.checkedNodes.length;			
			if(length>0){
				bm = jiGouTree.checkedNodes[0].getAttribute("<%=shujuxbm%>");								
				for(var i=1;i<length;i++){				
					bm += ","+jiGouTree.checkedNodes[i].getAttribute("<%=shujuxbm%>");														
				}
			}
			
		}
		//建立返回值数组，返回值与Q8对话定义中的参数一一对应，构造成一个二维数组

		var returnValues =[['cs_ShuJuXZ',bm]];
		
		//调用平台封装的返回值构造方法

		//request.getParameter("select_target")的说明：调用平台的点选时，平台会自动将这个参数通过url传递到目标页面，该参数封装了点选参数接收规则。

		ExtFunctionCM.buildReturnValue(returnValues,'<%=request.getParameter("select_target")%>');
	}
	
	/**
	*@author: masheng(masheng@qam.cn)
	*@description:清除值

	*@returnValue: 无

	**/	
	function doClear(){
	    //建立返回值数组

		var returnValues =[['cs_ShuJuXZ','']];
		
		//调用平台封装的返回值构造方法

		ExtFunctionCM.buildReturnValue(returnValues,'<%=request.getParameter("select_target")%>');
	}
	
	/**
	*@author: masheng(masheng@qam.cn)
	*@description:快速检索树，包含关键字的节点被选中。如果多个包含关键字的节点，通过“下一个”移动

	*@returnValue: 无

	**/	
	function doSearch(){
		if(ExtFunctionCM.getObject("dc_search").value!="" ){
			//调用树的search方法 
			jiGouTree.search(ExtFunctionCM.getObject("dc_search").value);
			if(jiGouTree.searchIndex==-1){
				ExtFunctionCM.getObject("btn_search").value="搜索";
			}
			else{
				ExtFunctionCM.getObject("btn_search").value="下一个";
			}
		}
	}	
	
	function chongzhi(){	
		var url = "<%=request.getContextPath()%>/servlet/jspcontrolservlet?_qam_command=MLKZ_ChongZhi&_qam_dialog=GNDH_Tree&_dialog_submit_=GNDH_XuanZeSJX_Tree&_qam_dialog_state=DHZT_ChongZhi&cs_TableName=<%=tablename %>&cs_ShuJuXZ=<%=yixuan %>&cs_ShuJuXBM=<%=shujuxbm %>&select_target=<%=select_target%>";
		document.forms[0].action=url;
		document.forms[0].submit();

	}
  </SCRIPT>
  </body>
</html>


