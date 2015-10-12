<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ page language="java"  contentType="text/html;charset=UTF-8"%>

<html>
<head>
	<title>授权设置</title>
</head>
<body bottomMargin=0 leftMargin=5 topMargin=10 rightMargin=0>

<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" style="position:relative;top:-8px;">
  <tr> 
	<td  width="280" valign="top"> 
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="10"></td>
			</tr>
			<tr> 
			  <td width="100%" colspan="3"> 
				<table width="100%" border="0" cellspacing="0" cellpadding="0" >
				  <tr> 
					<td width="100%" style="border:none;">
					<iframe width="100%" height="500" src="<%=request.getContextPath() %>/platform/quanxiangl/quanxiandx.jsp?_qam_dialog=GNDH_YongHuLB"  style="border:none;"  id="LeftTree" name="LeftTree" frameBorder="0" scrolling="no"></iframe>
					</td>
				  </tr>
				</table>
			  </td>
			</tr>
		  </table>
	</td>
	<td width="4"> 
	</td>
	<td> 
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
		  <tr> 
			<td width="100%" style="border:none;">
			<iframe width="100%" height="500" src="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog=GNDH_YSQ_CXTJ&cs_QuanXianDXBH=<%=request.getParameter("cs_QuanXianDXBH") %>"  style="border:none;" scrolling="no" id="RightTree" name="RightTree" frameBorder="0"></iframe>
			</td>
		  </tr>
		</table>
	</td>
  </tr>
</table>

</body>
</html>
