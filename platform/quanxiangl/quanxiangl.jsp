<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@include file="/common/ui.jspf" %>
<html>
	<head>
		<title>
			授权管理
		</title>
		<script type="text/javascript">
			var newWin;
			$(function(){
				newWin = $("#newWin").dialog({
					autoOpen:	false
				});
			});
		</script>
	</head>
	<%String treeUrl = "";
			String listUrl = "";
			if ("liequanxian".equalsIgnoreCase(request
					.getParameter("cs_ShouQuanLX"))) {
				treeUrl = request.getContextPath()
						+ "/platform/quanxiangl/duihua_tree.jsp?_qam_dialog_state="
						+ request.getParameter("_qam_dialog_state")
						+ "&cs_QuanXianDXBH="
						+ request.getParameter("cs_QuanXianDXBH")
						+ "&cs_QuanXianDXLX="
						+ request.getParameter("cs_QuanXianDXLX");
				listUrl = request.getContextPath()
						+ "/servlet/jspdispatchservlet?_qam_dialog_state="
						+ request.getParameter("_qam_dialog_state")
						+ "&_qam_dialog=GNDH_QXSZ_LQX&cs_QuanXianDXBH="
						+ request.getParameter("cs_QuanXianDXBH")
						+ "&cs_QuanXianDXLX="
						+ request.getParameter("cs_QuanXianDXLX");
			} else if ("hangquanxian".equalsIgnoreCase(request
					.getParameter("cs_ShouQuanLX"))) {
				treeUrl = request.getContextPath()
						+ "/platform/quanxiangl/shujufl_tree.jsp?_qam_dialog_state="
						+ request.getParameter("_qam_dialog_state")
						+ "&cs_QuanXianDXBH="
						+ request.getParameter("cs_QuanXianDXBH")
						+ "&cs_QuanXianDXLX="
						+ request.getParameter("cs_QuanXianDXLX");
				listUrl = request.getContextPath()
						+ "/servlet/jspdispatchservlet?_qam_dialog_state="
						+ request.getParameter("_qam_dialog_state")
						+ "&_qam_dialog=GNDH_QXSZ_HQX&cs_QuanXianDXBH="
						+ request.getParameter("cs_QuanXianDXBH")
						+ "&cs_QuanXianDXLX="
						+ request.getParameter("cs_QuanXianDXLX")
						+ "&cs_ShuJuFLBH="
						+request.getParameter("cs_ShuJuFLBH");

			} else {
				treeUrl = request.getContextPath()
						+ "/platform/quanxiangl/gongneng_tree.jsp?_qam_dialog_state="
						+ request.getParameter("_qam_dialog_state")
						+ "&cs_QuanXianDXBH="
						+ request.getParameter("cs_QuanXianDXBH")
						+ "&cs_QuanXianDXLX="
						+ request.getParameter("cs_QuanXianDXLX")
						+ "&cs_ShouQuanLX="
						+ request.getParameter("cs_ShouQuanLX");
				listUrl = request.getContextPath()
						+ "/servlet/jspdispatchservlet?_qam_dialog_state="
						+ request.getParameter("_qam_dialog_state")
						+ "&_qam_dialog=GNDH_QXSZ_CZQXHMD&cs_QuanXianDXBH="
						+ request.getParameter("cs_QuanXianDXBH")
						+ "&cs_QuanXianDXLX="
						+ request.getParameter("cs_QuanXianDXLX")
						+ "&cs_ShouQuanLX="
						+ request.getParameter("cs_ShouQuanLX");
			}
%>
	<body bottomMargin=1 leftMargin=2 topMargin=10 rightMargin=0 >
		<form name="form2">
			<table width="100%"  border="0" cellpadding="0"  cellspacing="0" align="center" style="position:relative;top:-8px;">
				<tr>
					<td width="180" height="100%" valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="10"></td>
							</tr>
							<tr>
								<td width="100%" colspan="3">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%" style="border:none;">
												<iframe width="200px" height="620px" 
													src="<%=treeUrl%>"
													 id="LeftTree" name="LeftTree" frameborder="0" ></iframe>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td width="4">
					</td>
					<td height="100%">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" style="border:none;">
									<iframe width="100%" height="620px" align="top" 
										src="<%=listUrl%>"
										style="border:none;" id="RightTree" name="RightTree" frameborder="0" scrolling="no"></iframe>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
<div id="newWin">
</div>
	</body>
</html>
