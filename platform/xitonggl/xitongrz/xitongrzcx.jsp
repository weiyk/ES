<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Calendar"%>
<%@page language="java"  isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
		<html:dialog id="GNDH_XiTongRZCX" async="false"/>
		<%
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date currentTime = new Date();
		Calendar c = Calendar.getInstance();
		c.setTime(currentTime);
		c.add(Calendar.MONTH, -1);
		Date beginDate = c.getTime();
		String beginDateStr = formatter.format(beginDate);	
	 	String dateString = formatter.format(currentTime);
	%>
<script type="text/javascript">
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
			if($('#dc_JIANLISJ').val()>$('#dc_Zhi').val()&&$('#dc_JIANLISJ').val()&&$('#dc_Zhi').val()){
	  			$(this)._alert('提示','开始时间不能超过截至时间！');
	  			return false;
			}
			var con = ['dc_XINGMING','dc_JIANLISJ','dc_Zhi'];//查询条件
			$(this)._search('DHSJZ_ChaXunJG','MLKZ_ChaXun',con);
		});
	});		
</script>
</head>
<body >
	
	<html:form >
	<div class="ui-layout-center" style="overflow: hidden;">
   		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="ui-jqdialog-content ui-widget-content">
			<tr>
				<td   class="CaptionTD" align="left" width="1%"><html:title id="dc_XINGMING"/></td>
				<td class="DataTD"   width="18%"><html:text modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_XINGMING" style="width:80%"/></td>
				<td   class="CaptionTD"  align="right" width="8%"><html:title id="dc_JIANLISJ"/></td>
				<td class="DataTD" width="18%"><html:datepick  modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_JIANLISJ"  style="WIDTH:80%" value="<%=beginDateStr%>"/></td>
				<td   class="CaptionTD"  align="center" width="2%"><html:title id="dc_Zhi"/></td>
				<td class="DataTD" width="18%"><html:datepick modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_Zhi" style="WIDTH:80%" value="<%=dateString %>"/></td>
				
				<td align="right">
             		<html:command id="MLKZ_ChaXun"/>
             		<html:command id="MLKZ_ShanChu"/>
				</td>
			</tr>
		</table>  	
		 <c:set var="dateString" value="<%=dateString%>" ></c:set>
		 <c:set var="beginDateStr" value="<%=beginDateStr%>" ></c:set>
		<%-- --%>
		<html:jqgrid id="DHSJZ_ChaXunJG" processId="GNSW_XiTongRZCX" processUnitId="SWDY_CX" rownumbers="true"  otherPostData="{dc_Zhi:'${dateString}', dc_JIANLISJ: '${beginDateStr }'}"  pager="pager" autoWidth="true" height="300" />
		</div>
		<html:paraSave/>
	<script type="text/javascript">
		$(function(){
			$(window).wresize(function(){
				content_resize($('#DHSJZ_ChaXunJG'),window,5);
			});
			content_resize($('#DHSJZ_ChaXunJG'),window,5,$(window).height()*0.30);
		});
	</script>
	</html:form>
</body>
</html>