package com.rc.web.facade.tablib.extension;

import java.math.BigDecimal;
import java.util.Iterator;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import com.qam.web.facade.taglib.support.TagUtil;

/**
 * 
 * @author Tim
 * @version ver 1.0
 */
public class JQChartTag extends TagSupport {
	
	private static final long serialVersionUID = 816577451190300090L;
	String[] units = {"元", "拾元", "佰元", "仟元", "万元", "十万元", "百万元", "千万元", "亿元", "十亿元", "百亿元", "千亿元"};
	// 渲染目标ID
	private String id;
	private String name;
	// 要生成的图表类型
	private String type;
	// 图表标题
	private String title;
	// JSON格式数据
	private String jsonData="{models:[{}],titles:{}}";  
	// 百分比
	private boolean usePercent = false;
	// 是否允许导出
	private boolean allowExport;
	// 导出文件类型
	private String exportType = "img";
	// 钻取时参数params
	private String drillDownParams;
	// 计量单位
	private int unit = 1;
	private String implementationClass;
	// 背景色
	private String background="white";
	//边框颜色
	private String bordercolor="black";  
	//主标题字体大小
	private String titlefontsize="15px";
	// 是否显示图例组件
	private String showLegend = "true";
	// 图例组件显示位置
	private String legendLocation = "right";
	// 倾斜角度
	private int angle = 0;
	// 图表宽度
	private String chartWidth = "100%";
	// 图表高度
	private String chartHeight = "300px";
	// 导出/返回上级/放大图片按钮宽度及高度设置
	private String btnWidth = "30px";
	private String btnHeight = "30px";
	// 是否隐藏value=0的数据项
	private boolean hideEmptyData = true;
	// 是否允许查看大图，true：允许，false:不允许
	private boolean zoom = true;
	// 设置坐标轴上显示的文字大小
	private String fontSize;
	// 设置图标最多允许显示几个数据项，默认为显示所有。
	private int maxItemCount = -1;
	
	public JQChartTag() {
		super();
	}

	public int doStartTag() throws JspException {
		// set jqChart Div
		String jqChartDivHtml = "<div id=\"" + this.getId() + "\" style=\"width:" + this.getChartWidth() + ";height:" + this.getChartHeight() + ";\"/>";
		TagUtil.write(pageContext, jqChartDivHtml);
		TagUtil.write(pageContext, outputScript());
		return SKIP_BODY;
	}

	private String outputScript() {
		StringBuffer scripts = new StringBuffer();
		scripts.append("\n<script type=\"text/javascript\">");
		scripts.append("\n$(document).ready(function () {");
		// 统一背景色
		scripts.append(this.defineBackGround());
		
		if (Chart.BAR.getName().equals(this.getType())) {
			// 生成条形图
			scripts.append(this.stackedBarChart()); 
		} else if (Chart.COLUMN.getName().equals(this.getType())) {
			// 柱状图
			scripts.append(this.columnChart());
		} else if (Chart.PIE.getName().equals(this.getType())) {
			// 饼图
			scripts.append(this.pieChart());
		} else if(Chart.LINE.getName().equals(this.getType())){
			// 折线图
			scripts.append(this.lineChart());
		}
		// 调用加载图像函数
		scripts.append("\ninitChart();");
		
		// 钻取
		if (this.getDrillDownParams() != null && !"".equals(drillDownParams.trim())) {
			
			// TODO 如果同时显示返回上一级和下载按钮时，需要计算好按钮位置以避免显示错乱。
//			String right = "5px";
//			if (this.isAllowExport()) {
//				String unit = "px";
//				int endIndex = -1;
//				while (true) {
//					endIndex = this.btnWidth.indexOf(unit);
//					if (endIndex == -1) {
//						unit = "%";
//					} else {
//						break;
//					}
//				}
//				
//				String width = this.btnWidth.substring(0, endIndex);
//				right = String.format("%.0f%s", Double.parseDouble(width) + 5, unit);
//			}
			
			String right = this.calculatePosition(2);
			// 添加返回上一级按钮
			String btnBackHtml = "<div id=\"" + this.getId() + "_bt\"   style=\"width:" + this.btnWidth + ";height:" + this.btnHeight + ";z-index: 1;position: absolute;right:" + right + ";top:5px;display: none;\" ><img style=\"cursor: pointer\" title=\"返回上一级\" width=\"" + this.btnWidth + "\" height=\"" + this.getBtnHeight() + "\" src=\"" + pageContext.getServletContext().getContextPath() + "/common/skins/default/images/back.png\"/></div>";
			try {
				TagUtil.write(pageContext, btnBackHtml);
			} catch (JspException e) {
				e.printStackTrace();
			}
			
			scripts.append(this.drillDoown()); 
			scripts.append(this.isdispalybackdiv());
		}
		// 绑定导出事件
		if (this.isAllowExport())
			scripts.append(this.exportFileEvent());
		
		// 绑定查看大图事件
		if (this.isZoom())
			scripts.append(this.zoomFunction());
		
		scripts.append("\n});");
		scripts.append("\n</script>");
		return scripts.toString();
	}

	public int doEndTag() throws JspException {
		super.release();
		return EVAL_PAGE;
	}
	
	/**
	 * 生成饼图脚本
	 * @Author    :  wyk 
	 * @return
	 */
	private String pieChart() {
		StringBuffer pieScript = new StringBuffer();
		
		pieScript.append("\nfunction initChart() {");
		pieScript.append(this.definedModel()); 
		// 
		pieScript.append("\n\nvar pieDataValuesField = 'value';");
		pieScript.append("\n$.each(model[0], function(k,v) {");
		pieScript.append("\n	if (k.match(/^value\\d*$/)) {");
		pieScript.append("\n		pieDataValuesField = k;");
		pieScript.append("\n	}");
		pieScript.append("\n});\n");  
		
		pieScript.append("\n$('#" + this.getId() + "').jqChart({"
	        + "\n    title: { text: '" + this.getTitle() + "',font: '"+this.getTitlefontsize()+" sans-serif'},"
	        + "\n		otherProerties: {unit: " + this.getUnit() + ", exportType: '" + this.getExportType() + "'},"
	        + this.initLegend() + ","
	        + "\n    border: { strokeStyle: '"+this.getBordercolor()+"' },"
	        + "\n    background: background,"
	        + "\n    animation: { duration: 1 },"
	        + "\n    shadows: {"
	        + "\n        enabled: true"
	        + "\n    },"
	        + "\n	 dataSource: model,"
	        + "\n    series: ["
	        + "\n        {"
	        + "\n            type: 'pie',"
	        + "\n            labels: {"
	        + "\n                stringFormat: '%.2f%%',"
	        + "\n                valueType: 'percentage',"
	        + "\n                font: '15px sans-serif',"
	        + "\n                fillStyle: 'black'"
	        + "\n            },"
	        + "\n            explodedRadius: 10,"
	        + "\n			 dataLabelsField: 'key',"
	        + "\n			 dataValuesField: pieDataValuesField,"
	        + "\n            labelsPosition: 'outside', // inside, outside"
	        + "\n            labelsAlign: 'circle', // circle, column"
	        + "\n            labelsExtend: 20,"
	        + "\n            leaderLineWidth: 1,"
	        + "\n            leaderLineStrokeStyle: 'black'"
	        + "\n        }"
	        + "\n    ]"
	        + "\n});");
		pieScript.append("\n}");
		return pieScript.toString();
	}
	
	/**
	 * 生成柱状图
	 * @Author    :  wyk 
	 * @return 柱状图脚本
	 */
	private String columnChart() { 
		StringBuffer columnScript = new StringBuffer();
		columnScript.append("\nfunction initChart() {");
		// script中定义models变量
		columnScript.append(this.definedModel());
		// 生成的柱状图是否以百分比显示
		columnScript.append(this.genSeries(this.isUsePercent() ? Chart.STACKEDCOLUMN.getName() : Chart.COLUMN.getName()) + 
		    "\n$('#" + this.getId() + "').jqChart({" +
	        "\n    title: { text: \"" + this.getTitle() + "\",font: '"+this.getTitlefontsize()+" sans-serif'}," +
		    "\n    tooltips: {disabled : false, type: 'normal', background : undefined,borderColor: 'auto',stringFormat: '%.2f'  }, "+
		    "\n		otherProerties: {unit: " + this.getUnit() + ", exportType: '" + this.getExportType() + "'}," +
	        this.initLegend() + "," +
	        "\n    animation: { duration: 1 }," +
	        "\n    shadows: {" +
	        "\n        enabled: true" +
	        "\n    }," +
	        "\n    background: background," +	// TODO 背景颜色
	        "\n    dataSource: model," +
	        "\n    axes: [" +
	        "\n            {" +
		    "\n                type: 'category'," +
		    "\n                location: 'bottom'," +
		    // 设置倾斜角度
		    this.configAngle() +
		    "\n            }," +
		    "\n            {" +
		    "\n                type: 'linear'," +
		    "\n                extendRangeToOrigin: true");
		if (this.isUsePercent())
			columnScript.append(
			    "\n                ,labels: {" +
			    "\n                    stringFormat: '%.2f%%'" +
			    "\n                }");
		columnScript.append(
		    "\n            }" +
	        "\n       ]," +
	        "\n		series: eval(series)" +
	        "\n});");
		columnScript.append("\n}");
		return columnScript.toString();
	}
	
	/**
	 * 生成百分比条形图
	 * @Author    :  wyk 
	 * @return	条形图脚本
	 */
	private String stackedBarChart() {
		StringBuffer stackedBar = new StringBuffer();
		
		stackedBar.append("\nfunction initChart() {");
		// script中定义models变量
		stackedBar.append(this.definedModel());
		// 设置生成的条形图是否按百分比显示
		stackedBar.append(this.genSeries(this.isUsePercent() ? Chart.STACKEDBAR.getName() : Chart.BAR.getName()) +
		    "\n$('#" + this.getId() + "').jqChart({" +
	        "\n    title: { text: \"" + this.getTitle() + "\",font: '"+this.getTitlefontsize()+" sans-serif' }," +
	        "\n		otherProerties: {unit: " + this.getUnit() + ", exportType: '" + this.getExportType() + "'}," +
	        this.initLegend() + "," + 
	        "\n    animation: { duration: 1 }," +
	        "\n    shadows: {" +
	        "\n        enabled: true" +
	        "\n    }," +
	        "\n    background: background," +
	        "\n    dataSource: model," +
	        "\n    axes: [" +
	        "\n            {" +
		    "\n                type: 'category'," +
		    "\n                location: 'left'," +
		    // 设置倾斜角度
		    this.configAngle() + 
		    "\n            }," +
		    "\n            {" +
		    "\n                type: 'linear'," +
		    "\n                location: 'bottom'," +
		    "\n                extendRangeToOrigin: true");
		if (this.isUsePercent())
			stackedBar.append(
			"\n                ,labels: {" +
		    "\n                    stringFormat: '%.2f%%'" +
		    "\n                }");
		    
	    stackedBar.append(
	    "\n            }" +
        "\n       ]," +
	    "\n		series: eval(series)" +		
        "\n});");
	    stackedBar.append("\n}");
		return stackedBar.toString();
	}
	
	/**
	 * 生成折线图
	 * @Author    :  wyk 
	 * @return 折线图脚本
	 */
	private String lineChart() { 
		StringBuffer lineScript = new StringBuffer();
		lineScript.append("\nfunction initChart() {");
		// script中定义models变量
		lineScript.append(this.definedModel());
		// 生成的柱状图是否以百分比显示
		lineScript.append(this.genSeries(Chart.LINE.getName()) + 
		    "\n$('#" + this.getId() + "').jqChart({" +
	        "\n    title: { text: \"" + this.getTitle() + "\",font: '"+this.getTitlefontsize()+" sans-serif' }," +
		    "\n		otherProerties: {unit: " + this.getUnit() + ", exportType: '" + this.getExportType() + "'}," +
	        this.initLegend() + "," +  
	        "\n    animation: { duration: 1 }," +
	        "\n    shadows: {" +
	        "\n        enabled: true" + 
	        "\n    }," +
	        "\n    background: background," +	// TODO 背景颜色
	        "\n    dataSource: model," +
	        "\n    axes: [" +
	        "\n            {" +
		    "\n                type: 'category'," +
		    "\n                location: 'bottom'," +
		    // 设置倾斜角度
		    this.configAngle() + 
		    "\n            }," +
		    "\n            {" +
		    "\n                type: 'linear'," +
		    "\n                extendRangeToOrigin: true");
		if (this.isUsePercent())
			lineScript.append(
				"\n                ,labels: {" +
			    "\n                    stringFormat: '%.2f%%'" +
			    "\n                }");
		lineScript.append(
		    "\n            }" +
	        "\n       ]," +
	        "\n		series: eval(series)" +
	        "\n});");
		lineScript.append("\n}");
		return lineScript.toString();
	}
	
	/**
	 * 背景颜色定义
	 * @Author    :  wyk 
	 * @return
	 */
	private String defineBackGround() {
		StringBuffer background = new StringBuffer();
		background.append("\nvar background = {");
		background.append("\n    type: 'linearGradient',");
		background.append("\n    x0: 0,");
		background.append("\n    y0: 0,");
		background.append("\n    x1: 0,");
		background.append("\n    y1: 1,");
		
		String color1 = "#d2e6c9";
		String color2 = "white";
		if (this.getBackground() != null && !"".equals(this.getBackground())) {
			String[] colors = this.getBackground().split("\\,");
			if (colors.length == 1) {
				color1 = colors[0];
			} else if (colors.length == 2) {
				color1 = colors[0];
				color2 = colors[1];
			}
		}
		
		background.append("\n    colorStops: [{ offset: 0, color: '" + color1 + "' },");
		background.append("\n                 { offset: 1, color: '" + color2 + "' }]");
		background.append("\n};\n\n");
		return background.toString();
	}
	
	/**
	 * 生成定义JSON数据结构脚本
	 * @Author    :  wyk 
	 * @return
	 */
	private String definedModel() {
		return "\n//定义加载图像所需的数据源" +
				"\nvar jsonData = " + this.getJsonData() + ";" +
				"\nvar model = jsonData.models;" +
				"\nvar title = jsonData.titles;\n\n";
	}
	
	/**
	 * 解析数据源生成图片数据脚本
	 * @Author    :  wyk 
	 * @param type
	 * @return
	 */
	private String genSeries(String type) {
		StringBuffer series = new StringBuffer();
		series.append("\n//生成柱状图和条形图时，定义");
		series.append("\nvar series = \"[\";");
		series.append("\nif (model !=null)");
		series.append("\n$.each(model[0], function(key, val) {");
		series.append("\nif (key.match(/^value\\d*$/)) {");
		series.append("\n	series+= \"{type: '" + type + "',");
		
		if ("true".equals(this.showLegend)) {
			series.append("title: '\" + (title[key] == undefined ? '': title[key]) + \"',");
		}
		series.append("xValuesField: 'key', yValuesField: '\" + key + \"', labels: { stringFormat: '%.2f'}},\";");
		series.append("\n}});");
		series.append("\nseries+=\"]\";\n\n");
		return series.toString();
	}
	
	/**
	 * 钻取事件
	 * @Author    :  wyk 
	 * @des	钻取后更新主标题、子标题、数据源
	 * @param type
	 * @return
	 */
	private String drillDoown() {
		StringBuffer script = new StringBuffer();
		script.append("\n\n// 绑定鼠标点击事件，用于钻取下一级");
		script.append("\n$('#" + this.getId() + "').bind('dataPointMouseDown', function(event, data){");
		// TODO 存在的问题：此IF仅当由1级向2级钻取时有效
		script.append("\n	// 如果增加以下代码将影响钻取");
		script.append("\n	//var pTitle = $('#" + this.getId() + "').jqChart('option', 'title');");
		script.append("\n	//if (pTitle.text != '" + this.getTitle() + "') {");
		script.append("\n	//	return;");
		script.append("\n	//}");
		
		script.append("\n	var jqDataSource = $('#" + this.getId() + "').jqChart('option', 'dataSource');");
		script.append("\n	var jqSeries = $('#" + this.getId() + "').jqChart('option', 'series');");
		// TODO 获得钻取时需要的ID
		script.append("\n	// Ajax请求时的参数集合");
		script.append("\n	var params = " + this.getDrillDownParams() + ";");
		script.append("\n	$.each(jqDataSource, function(no, md){");
		script.append("\n		if (data.dataItem[0] == md.key && md.id !== undefined && md.id != null && md.id != '') {");
		script.append("\n			params.id = md.id");
		script.append("\n		}");
		script.append("\n	});");
		// 获得下一级要显示的主标题名称
		script.append("\n	var subTitle = data.dataItem[0];");
		script.append("\n	$.ajax({");
		script.append("\n		type: 'post',");
		script.append("\n		url: '" + pageContext.getServletContext().getContextPath() + "/servlet/ajaxStatisticServlet',");
		script.append("\n		data: params,");
		script.append("\n		dataType: 'json',");
		script.append("\n		success: function(data) {"); 
		
		script.append("\n			var model = data.models; var new_model=[];");
		script.append("\n			if (model.length == 0 || model[0] == undefined || model[0].key == undefined) {");
		script.append("\n				return;");
		script.append("\n			}");
		
		// 根据设置额金额单位处理金额
		script.append("\n			for (var i = 0; i < model.length; i++) { ");
		script.append("\n               var empty=true;");
		script.append("\n				$.each(model[i], function(k,v) {");
		script.append("\n					if (k.match(/^value\\d*$/)) {");
		script.append("\n						model[i][k] = ((v/" + this.unit + ").toFixed(2))*100/100; if(model[i][k]>0){empty=false;}");
		script.append("\n					}");
		script.append("\n				});");
		script.append("\n				if(!empty){");
		script.append("\n               	new_model.push(model[i]);");
		script.append("\n				}");					
		script.append("\n			}");
								if(this.hideEmptyData){
		script.append("\n           model=new_model;");
								}
		// 更新主标题
		script.append("\n			var title = $('#" + this.getId() + "').jqChart('option', 'title');");
		if (this.isUsePercent()) {
			// 当使用百分比显示时，标题中不需要增加单位
			script.append("\n			title.text = subTitle;");
		} else {
			script.append("\n			title.text = subTitle + '(单位：" + units[String.valueOf(unit).length() - 1] + ")';");
		}
		
		// TODO 饼图和柱状图\条形图区别很大需要特殊处理
		// 获取原dataSource
		script.append("\n			var type = jqSeries[0].type;");
		script.append("\n			if (type == 'pie') {");
		script.append("\n				$.each(model[0], function(k,v) {");
		script.append("\n					if (k.match(/^value\\d*$/)) {");
		script.append("\n						jqSeries[0].dataValuesField = k;");
		script.append("\n					}");
		script.append("\n				});");
		
										// 饼图数据源加载方式
		script.append("\n				jqDataSource.splice(0, jqDataSource.length);");
		script.append("\n				for(i in model) {");
		script.append("\n					jqDataSource.push(model[i]);");
		script.append("\n				}");
		script.append("\n");
		script.append("\n			} else {");
		script.append("\n				jqDataSource.splice(0, jqDataSource.length);");
		script.append("\n				for(i in model) {");
		script.append("\n					jqDataSource.push(model[i]);");
		script.append("\n				}");
		// 获取原series 
		script.append("\n				jqSeries.splice(0, jqSeries.length);");
		script.append("\n				var title = data.titles;");
		// 构造新的series
		script.append("\n				var series = \"[\";");
		script.append("\n				if (model !=null)");
		script.append("\n				$.each(model[0], function(key, val) {");
		script.append("\n					if (key.match(/^value\\d*$/)) {"); 
		script.append("\n					series+= \"{type: type,title: '\" + title[key] + \"', xValuesField: 'key', yValuesField: '\" + key + \"', labels: {stringFormat: '%.2f'}},\";");
		script.append("\n				}});");
		script.append("\n				series+=\"]\";");
		script.append("\n				var newSeries = eval(series);");
		script.append("\n				for(i in newSeries) {");
		script.append("\n					jqSeries.push(newSeries[i]);");
		script.append("\n				}");
		script.append("\n			}");
		script.append("\n");
		script.append("\n			$('#" + this.getId() + "').jqChart('update');");
		//判断是否显示返回按钮
		script.append("\n           isdispalybackdiv();");
		script.append("\n		}");
		script.append("\n	});"); 
		script.append("\n});");  
		
		// 返回上一级
		script.append("\n\n// 绑定鼠标点击事件，用于返回上一级");
		script.append("\n$('#" + this.getId() + "_bt').bind('click', function(event, data){"); 
		// TODO 存在的问题：此IF仅当由1级向2级钻取时有效
		script.append("\n	// 如果增加以下代码将影响钻取");
		script.append("\n	//var pTitle = $('#" + this.getId() + "').jqChart('option', 'title');");
		script.append("\n	//if (pTitle.text != '" + this.getTitle() + "') {");
		script.append("\n	//	return;");
		script.append("\n	//}");
		
		script.append("\n	var jqDataSource = $('#" + this.getId() + "').jqChart('option', 'dataSource');");
		script.append("\n	var jqSeries = $('#" + this.getId() + "').jqChart('option', 'series');");
		// TODO 获得钻取时需要的ID
		script.append("\n	// Ajax请求时的参数集合");
		script.append("\n	var params = " + this.getDrillDownParams() + ";");
		script.append("\n	$.each(jqDataSource, function(no, md){");
		script.append("\n		if (md.pid !== undefined && md.pid != null && md.id != '') {");
		script.append("\n			params.id = md.pid");
		script.append("\n		}");
		script.append("\n	});");
		// 获得下一级要显示的主标题名称
		script.append("\n	$.ajax({");
		script.append("\n		type: 'post',");
		script.append("\n		url: '" + pageContext.getServletContext().getContextPath() + "/servlet/ajaxStatisticServlet',");
		script.append("\n		data: params,");
		script.append("\n		dataType: 'json',");
		script.append("\n		success: function(data) {");
		
		script.append("\n			var model = data.models; var new_model=[];");
		script.append("\n			if (model.length == 0 || model[0] == undefined || model[0].key == undefined) {");
		script.append("\n				return;");
		script.append("\n			}");
		
		// 根据设置额金额单位处理金额
		script.append("\n			for (var i = 0; i < model.length; i++) {");
		script.append("\n               var empty=true;");
		script.append("\n				$.each(model[i], function(k,v) {");
		script.append("\n					if (k.match(/^value\\d*$/)) {");
		script.append("\n						model[i][k] = ((v/" + this.unit + ").toFixed(2))*100/100;  if(model[i][k]>0){empty=false;}");
		script.append("\n					}");
		script.append("\n				});");
		script.append("\n				if(!empty){");
		script.append("\n               	new_model.push(model[i]);");
		script.append("\n				}");					
		script.append("\n			}");
								if(this.hideEmptyData){
		script.append("\n           model=new_model;");
								}
		// 更新主标题
		script.append("\n			var title = $('#" + this.getId() + "').jqChart('option', 'title');");
		script.append("\n			if(model[0].ptitle=='null' || model[0].ptitle == undefined){ ");
		// 如果上级ptitle为空时，表示已经返回到了顶级，该title需要获取jqChart标签设置的title值。
		script.append("\n				title.text ='" + this.getTitle() + "';");
		script.append("\n			}else{"); 
		if (this.isUsePercent()) {
			// 如果使用百分比显示时，title中不需要增加单位信息。eg:3级返回2级时
			script.append("\n				title.text = model[0].ptitle;");
		} else {
			script.append("\n				title.text = model[0].ptitle + '(单位：" + units[String.valueOf(unit).length() - 1] + ")';");
		}
		script.append("\n			}"); 
		
		// TODO 饼图和柱状图\条形图区别很大需要特殊处理
		// 获取原dataSource
		script.append("\n			var type = jqSeries[0].type;");
		script.append("\n			if (type == 'pie') {");
		script.append("\n				$.each(model[0], function(k,v) {");
		script.append("\n					if (k.match(/^value\\d*$/)) {");
		script.append("\n						jqSeries[0].dataValuesField = k;");
		script.append("\n					}");
		script.append("\n				});");
		
										// 饼图数据源加载方式
		script.append("\n				jqDataSource.splice(0, jqDataSource.length);");
		script.append("\n				for(i in model) {");
		script.append("\n					jqDataSource.push(model[i]);");
		script.append("\n				}");
		script.append("\n");
		script.append("\n			} else {");
		script.append("\n				jqDataSource.splice(0, jqDataSource.length);");
		script.append("\n				for(i in model) {");
		script.append("\n					jqDataSource.push(model[i]);");
		script.append("\n				}");
		// 获取原series 
		script.append("\n				jqSeries.splice(0, jqSeries.length);");
		script.append("\n				var title = data.titles;");
		// 构造新的series
		script.append("\n				var series = \"[\";");
		script.append("\n				if (model !=null)");
		script.append("\n				$.each(model[0], function(key, val) {");
		script.append("\n					if (key.match(/^value\\d*$/)) {"); 
		script.append("\n					series+= \"{type: type,title: '\" + title[key] + \"', xValuesField: 'key', yValuesField: '\" + key + \"', labels: {stringFormat: '%.2f'}},\";");
		script.append("\n				}});");
		script.append("\n				series+=\"]\";");
		script.append("\n				var newSeries = eval(series);");
		script.append("\n				for(i in newSeries) {");
		script.append("\n					jqSeries.push(newSeries[i]);");
		script.append("\n				}");
		script.append("\n			}");
		script.append("\n");
		script.append("\n			$('#" + this.getId() + "').jqChart('update');");
		//判断是否显示返回按钮
		script.append("\n           isdispalybackdiv();");  
		script.append("\n		}");
		script.append("\n	});");
		script.append("\n});");
		/*script.append("\n// 绑定右键菜单事件，用于返回上一级");
		script.append("\n$('#" + this.getId() + "').bind('contextmenu', function(e){");
		script.append("\n	// 如果增加以下代码将影响钻取");
		script.append("\n	//var title = $('#" + this.getId() + "').jqChart('option', 'title');");
		script.append("\n	//if (title.text == '" + this.getTitle() + "') {");
		script.append("\n	//	return;");
		script.append("\n	//}");
		// 加载上级图像	TODO 存在的问题：仅适用于由2->1
		script.append("\n	initChart();");
		script.append("\n	return false;");
		script.append("\n});");*/
		return script.toString();
	}
	
	/**
	 * 判断是否显示返回按钮
	 * @Author    :  wyk 
	 * @return
	 */
	private String isdispalybackdiv() {
		StringBuffer backScript = new StringBuffer();
		backScript.append("\n //判断是否显示返回按钮"); 
		backScript.append("\n function isdispalybackdiv(){");
		backScript.append("\n    var jqDS = $('#");
		backScript.append(this.getId()+"').jqChart('option', 'dataSource');");  
		backScript.append("\n    if(jqDS[0].ptitle=='null' || jqDS[0].ptitle == undefined){");
		backScript.append("\n       $('#");backScript.append(this.getId()+"_bt')");
		backScript.append(".css('display','none');");
		backScript.append("\n    }else{");
		backScript.append("\n       $('#");backScript.append(this.getId()+"_bt')");
		backScript.append(".css('display','block');");
		backScript.append("\n    }"); 
		backScript.append("\n }");
		return backScript.toString();
	}
	
	private String compatibilityForIE8() {
		StringBuffer script = new StringBuffer();
		script.append("\n/**");
		script.append("\n * IE<9时在新窗口打开图表页面");
		script.append("\n */");
		script.append("\nfunction downloadInIE8() {");
		script.append("\n	// jqChart图表对象");
		script.append("\n	var JQChart = $(\"#" + this.getId() + "\");");
		script.append("\n	");
		
		
		script.append("\n	// JQChart JSON格式数据");
		script.append("\n	var cData = JSON.stringify(" + this.jsonData + ");");
		script.append("\n	// 要显示的图表类型");
		script.append("\n	var cType = JQChart.jqChart('option', 'series')[0].type;");
		script.append("\n	// 图表标题");
		script.append("\n	var cTitle = JQChart.jqChart('option', 'title').text; ");
		script.append("\n	cTitle = cTitle.substr(0,cTitle.lastIndexOf('('));");
		script.append("\n	// 单位");
		script.append("\n	var cUnit = JQChart.jqChart('option', 'otherProerties').unit;");
		script.append("\n	// 导出类型");
		script.append("\n	var exportType = JQChart.jqChart('option', 'otherProerties').exportType;");		
		script.append("\n	var data = {chartData:cData, chartTitle:cTitle, chartUnit:cUnit, exportType:exportType, chartType:cType};");
		
		script.append("\n	// 是否使用百分比");
		script.append("\n	var cUsePercent = " + this.usePercent + ";");
		script.append("\n	data.cUsePercent = cUsePercent;");
		script.append("\n	// 背景颜色");
		script.append("\n	var cBackground = '" + this.background + "';");
		script.append("\n	data.cBackground = cBackground;");
		script.append("\n	// 边框颜色");
		script.append("\n	var cBordercolor = '" + this.bordercolor + "';");
		script.append("\n	data.cBordercolor = cBordercolor;");
		script.append("\n	// 主标题字体大小");
		script.append("\n	var cTitlefontsize='" + this.titlefontsize + "';");
		script.append("\n	data.cTitlefontsize = cTitlefontsize;");
		script.append("\n	// 是否显示图例组件");
		script.append("\n	var cShowLegend=" + this.showLegend +";");
		script.append("\n	data.cShowLegend = cShowLegend;");
		script.append("\n	// legendLocation");
		script.append("\n	var cLegendLocation = '" + this.legendLocation + "';");
		script.append("\n	data.cLegendLocation = cLegendLocation;");
		script.append("\n	// 倾斜角度");
		script.append("\n	var cAngle = " + this.angle + ";");
		script.append("\n	data.cAngle = cAngle;");
		script.append("\n	// 图表宽度");
		script.append("\n	var cWidth = '" + this.chartWidth + "';");
		script.append("\n	data.cWidth = cWidth;");
		script.append("\n	// 图表高度");
		script.append("\n	var cHeight = '" + this.chartHeight + "';");
		script.append("\n	data.cHeight = cHeight;");
		script.append("\n	// 导出/返回上级图片宽度");
		script.append("\n	var cBtnWidth = '" + this.btnWidth + "';");
		script.append("\n	data.cBtnWidth = cBtnWidth;");
		script.append("\n	var cBtnHeight = '" + this.btnHeight + "';");
		script.append("\n	data.cBtnHeight = cBtnHeight;");
		
		script.append("\n	var url = '" + pageContext.getServletContext().getContextPath() + "/platform/tongjifenxi/juecefenxi/yusuanguanli/iehelper/iehelperexec.jsp';");
		script.append("\n	");
		script.append("\n	openPostWindow(url,data);");
		script.append("\n}");
		script.append("\n");
		script.append("\nfunction openPostWindow(url, data) {    ");
		script.append("\n     var tempForm = document.createElement(\"form\");    ");
		script.append("\n     tempForm.id=\"tempForm1\";    ");
		script.append("\n     tempForm.method=\"post\";    ");
		script.append("\n     tempForm.action=url; ");
		script.append("\n	 tempForm.target='0'; ");
		script.append("\n	 ");
		script.append("\n 	 $.each(data, function(key, val) {");
		script.append("\n	     var hideInput = document.createElement(\"input\");    ");
		script.append("\n	     hideInput.type = \"hidden\";    ");
		script.append("\n	     hideInput.name= key;");
		script.append("\n	     hideInput.value= val;  ");
		script.append("\n	     tempForm.appendChild(hideInput);  ");
		script.append("\n     });");
		script.append("\n  ");
		script.append("\n    tempForm.attachEvent(\"onsubmit\", function(){ openWindow(); });  ");
		script.append("\n    document.body.appendChild(tempForm);    ");
		script.append("\n    tempForm.fireEvent(\"onsubmit\");  ");
		script.append("\n    tempForm.submit();  ");
		script.append("\n    document.body.removeChild(tempForm);  ");
		script.append("\n}  ");
		script.append("\n");
		script.append("\nfunction openWindow() {    ");
		script.append("\n  window.open('','0','height=400, width=800, scrollbars=yes, resizable=yes, status=yes, status=yes');     ");
		script.append("\n}   ");
		script.append("\n");
		script.append("\n\n	function IE8Ver() {");
		script.append("\n		var ua = navigator.userAgent; //获取用户端信息");
		script.append("\n		var b = ua.indexOf(\"MSIE \"); //检测特殊字符串MSIE的位置");
		script.append("\n		if (b < 0) {");
		script.append("\n			return false;");
		script.append("\n		}");
		script.append("\n		");
		script.append("\n		var version = parseFloat(ua.substring(b + 5, ua.indexOf(\";\", b))); //截取版本号字符串，并转换为数值");
		script.append("\n		if (version < 9) {");
		script.append("\n			return true;");
		script.append("\n		}");
		script.append("\n		return false;");
		script.append("\n	}\n\n");
		return script.toString();
	}
	
	/**
	 * 生成图片导出事件脚本
	 * @Author    :  wyk 
	 * @return
	 */
	private String exportFileEvent() {
		String right = this.calculatePosition(1);
		String exportBtnHtml = "<div id=\"" + this.getId() + "_export\"   style=\"width:" + this.btnWidth + ";height:" + this.btnHeight + ";z-index: 1;position: absolute;right:" + right + ";top:5px;display: block;\" ><img style=\"cursor: pointer\" title=\"保存图片\" width=\"" + this.getBtnWidth() + "\" height=\"" + this.getBtnHeight() + "\" src=\"" + pageContext.getServletContext().getContextPath() + "/common/skins/default/images/download.png\"/></div>";
		try {
			TagUtil.write(pageContext, exportBtnHtml);
		} catch (JspException e) {
			e.printStackTrace();
		}
		
		StringBuffer exportScript = new StringBuffer();
		/**
		 * If IE && IE<9
		 * 	Re-open in a new window
		 * else
		 * 	gen download script
		 */
		exportScript.append(compatibilityForIE8());
			
		exportScript.append("\n$('#" + this.getId() + "_export').click(function () {");
		exportScript.append("\n		if (IE8Ver()) {");
		exportScript.append("\n			return downloadInIE8();");
		exportScript.append("\n		}");
		exportScript.append("\n");
		
		exportScript.append("\nvar config = {"
			+ "\n    fileName: '" + this.getTitle() + "',"
			+ "\n    type: 'image/png',"	// 'image/png' or 'image/jpeg
			+ "\n	 server: '" + pageContext.getServletContext().getContextPath() + "/servlet/jQChartExport?type=" + this.getExportType() + "'"
			+ "\n};");
		
		if ("pdf".equalsIgnoreCase(this.getExportType())) {
			// 导出PDF
			exportScript.append("\n$('#" + this.getId() + "').jqChart('exportToPdf', config);");
		} else {
			// 默认为导出图片
			exportScript.append("\n$('#" + this.getId() + "').jqChart('exportToImage', config);");
		}
			
		exportScript.append("\n});");
		
		return exportScript.toString();
	}
	
	/**
	 * 放大图片函数
	 * @return
	 */
	private String zoomFunction() {
		/**
		 * 显示放大图表
		 */
		String zoomBtnHtml = "<div id=\"" + this.getId() + "_zoom\"   style=\"width:" + this.btnWidth + ";height:" + this.btnHeight + ";z-index: 1;position: absolute;right:5px;top:5px;display: block;\" ><img style=\"cursor: pointer\" title=\"查看大图\" width=\"" + this.getBtnWidth() + "\" height=\"" + this.getBtnHeight() + "\" src=\"" + pageContext.getServletContext().getContextPath() + "/common/skins/default/images/zoom.png\"/></div>";
		try {
			TagUtil.write(pageContext, zoomBtnHtml);
		} catch (JspException e) {
			e.printStackTrace();
		}
		
		StringBuffer script = new StringBuffer("\n\n");
		// 图表绑定点击事件：查看大图
		script.append("\n$('#" + this.getId() + "_zoom').click(function () {");
		script.append("\n		seeLargerImage();");
		script.append("\n	});");
		
		script.append("\n/**");
		script.append("\n * 查看大图");
		script.append("\n */");
		script.append("\nfunction seeLargerImage() {");
		
		script.append("\n	// jqChart图表对象");
		script.append("\n	var JQChart = $(\"#" + this.getId() + "\");");
		script.append("\n	// JQChart JSON格式数据");
		script.append("\n	var cjson = " + this.jsonData + ";");
		script.append("\n    cjson.models=JQChart.jqChart('option', 'dataSource');");
		script.append("\n	var cData = JSON.stringify(cjson); ");
		script.append("\n	// 要显示的图表类型");
		script.append("\n	var cType = JQChart.jqChart('option', 'series')[0].type;");
		// 如果原图使用百分比显示时，获取图表类型时需要处理一下
		script.append("\n	if (cType == \"stackedBar\") {");
		script.append("\n		cType = 'bar';");
		script.append("\n	} else if (cType == \"stackedColumn\") {");
		script.append("\n		cType = 'column';");
		script.append("\n	}");
		
		script.append("\n	// 图表标题");
		script.append("\n	var cTitle = JQChart.jqChart('option', 'title').text; ");
		//script.append("\n	if(cTitle.lastIndexOf('(')!=-1){cTitle = cTitle.substr(0,cTitle.lastIndexOf('('));}");
		script.append("\n	// 单位");
		//script.append("\n	var cUnit = JQChart.jqChart('option', 'otherProerties').unit;");
		script.append("\n	// 导出类型");
		script.append("\n	var exportType = JQChart.jqChart('option', 'otherProerties').exportType;");		
		script.append("\n	var data = {chartData:cData, chartTitle:cTitle, exportType:exportType, chartType:cType};");
		
		script.append("\n	// 是否使用百分比");
		script.append("\n	var cUsePercent = " + this.usePercent + ";");
		script.append("\n	data.cUsePercent = cUsePercent;");
		script.append("\n	// 背景颜色");
		script.append("\n	var cBackground = '" + this.background + "';");
		script.append("\n	data.cBackground = cBackground;");
		script.append("\n	// 边框颜色");
		script.append("\n	var cBordercolor = '" + this.bordercolor + "';");
		script.append("\n	data.cBordercolor = cBordercolor;");
		script.append("\n	// 主标题字体大小");
		script.append("\n	var cTitlefontsize='" + this.titlefontsize + "';");
		script.append("\n	data.cTitlefontsize = cTitlefontsize;");
		script.append("\n	// 是否显示图例组件");
		script.append("\n	var cShowLegend=" + this.showLegend +";");
		script.append("\n	data.cShowLegend = cShowLegend;");
		script.append("\n	// legendLocation");
		script.append("\n	var cLegendLocation = '" + this.legendLocation + "';");
		script.append("\n	data.cLegendLocation = cLegendLocation;");
		script.append("\n	// 倾斜角度");
		script.append("\n	var cAngle = " + this.angle + ";");
		script.append("\n	data.cAngle = cAngle;");
		script.append("\n	// 图表宽度");
		script.append("\n	var cWidth = '" + this.chartWidth + "';");
		script.append("\n	data.cWidth = cWidth;");
		script.append("\n	// 图表高度");
		script.append("\n	var cHeight = '" + this.chartHeight + "';");
		script.append("\n	data.cHeight = cHeight;");
		script.append("\n	// 导出/返回上级图片宽度");
		script.append("\n	var cBtnWidth = '" + this.btnWidth + "';");
		script.append("\n	data.cBtnWidth = cBtnWidth;");
		script.append("\n	var cBtnHeight = '" + this.btnHeight + "';");
		script.append("\n	data.cBtnHeight = cBtnHeight;");
		script.append("\n	// 钻取参数");
		script.append("\n	var cdrillDownParams = \"" + (this.drillDownParams != null ? this.drillDownParams : "") + "\";");
		script.append("\n	data.cdrillDownParams = cdrillDownParams;");
		script.append("\n\n	var url = '" + pageContext.getServletContext().getContextPath() + "/servlet/viewLargerServlet';");
		script.append("\n	");
		script.append("\n	openLargerImageView(url,data);");
		script.append("\n}");
		script.append("\n");
		
		script.append("\nfunction openLargerImageView(url,args){ ");
		script.append("\n	//创建表单对象 ");
		script.append("\n	var _form = $(\"<form></form>\",{ ");
		script.append("\n	'id':'tempForm', ");
		script.append("\n	'method':'post', ");
		script.append("\n	'action':url, ");
		script.append("\n	'target':'_blank', ");
		script.append("\n	'style':'display:none' ");
		script.append("\n	}).appendTo($(\"body\")); ");
		script.append("\n	");
		script.append("\n	//将隐藏域加入表单 ");
		script.append("\n	$.each(args, function(key, val) {");
		script.append("\n		_form.append($(\"<input>\", {'type':'hidden','name':key,'value':val})); ");
		script.append("\n    });");
		script.append("\n	");
		script.append("\n	");
		script.append("\n	//触发提交事件 ");
		script.append("\n	_form.trigger(\"submit\"); ");
		script.append("\n	//表单删除 ");
		script.append("\n	_form.remove(); ");
		script.append("\n}");
		
		script.append("\n");
		script.append("\n");
		return script.toString();
	}
	
	/**
	 * 计算图表上的按钮显示位置	
	 * @Author    :  wyk 
	 * @param btnFlag	1：计算下载按钮位置，2：计算返回上一级按钮位置
	 * @return
	 */
	private String calculatePosition(int btnFlag) {
		// 获得按钮设置的宽度值
		String unit = "px";
		int endIndex = -1;
		while (true) {
			endIndex = this.btnWidth.indexOf(unit);
			if (endIndex == -1) {
				unit = "%";
			} else {
				break;
			}
		}
		
		// 距离右边的值
		double rightPosition = 5;
		// 按钮宽度
		Double width = Double.parseDouble(this.btnWidth.substring(0, endIndex));
		
		switch(btnFlag) {
		case 1:
			/**
			 *  计算【下载】按钮显示位置
			 *  如果显示【放大】按钮时， 则计算【下载】按钮距右边位置时需要加上【放大】按钮宽度
			 */
			if (this.isZoom()) {
				rightPosition += width;
			}
			break;
		case 2:
			/**
			 *  计算【返回上级】按钮显示位置
			 *  如果【放大】按钮显示，则计算【返回上一级】按钮时需要
			 */
			if (this.isZoom()) {
				rightPosition += width;
			}
			if (this.isAllowExport()) {
				rightPosition += width;
			}
			break;
		}
		return String.format("%.0f%s", rightPosition, unit);
	}
	
	enum Chart {
		PIE("pie"), BAR("bar"), COLUMN("column"), STACKEDBAR("stackedBar"), STACKEDCOLUMN("stackedColumn"),LINE("line");
		
		Chart(String name) {
			this.name = name;
		}
		private String name;
		
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		
		public String toString() {
			return this.name;
		}
	}
	
	public String getJsonData() {
		JSONObject json = JSONObject.fromObject(jsonData);
		JSONArray mArray = json.getJSONArray("models"); 
		JSONArray mArray_loop=new JSONArray();
		// 是否显示该项数据
		for (int i = 0; i < mArray.size(); i++) {
			JSONObject obj = mArray.getJSONObject(i);
			
			boolean empty = true;
			Iterator it = obj.keys();
			// 如果存在多个value时，只有当全部value均为0时才隐藏 
			while(it.hasNext()) {
				String key = (String) it.next();
				if (key.matches("^value\\d*$")) {
					double val = obj.getDouble(key);
					val = val/unit;
					if (val > 0) {
						empty = false;
					}
					// 仅保留两位小数
					BigDecimal f=new BigDecimal(val); 
					obj.put(key, f.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
				}
			}
			 
			if (!empty ) {
				//找出所有不为空数据
				mArray_loop.add(obj); 
			}
		}
		//如果影藏数据，替换原models数据
		if(hideEmptyData){
			if(mArray_loop.isEmpty()){
				json=JSONObject.fromObject("{models:[{}],titles:{}}");}
			else{
				json.put("models", mArray_loop); 
			}
		}
		
		// 验证是否设置了最多允许显示个数（适用于首页数据项太多时）
		if (maxItemCount > 0) {
			JSONArray models = json.getJSONArray("models");
			
			// 进行排序(降序)
			JSONObject temp = null;
			int max;
			for (int j = 0; j < models.size(); j++) {
				// 设置最大数位置
				max = j;
				for (int k = j + 1; k < models.size(); k++) {
					if (models.getJSONObject(max).getDouble("value0") < models.getJSONObject(k).getDouble("value0")) {
						// 获取最大数位置
						max = k;
					}
				}
				
				// 当默认位置的最大数并不是实际的最大数时，和实际的最大数交换位置
				if (j != max) {
					temp = models.getJSONObject(j);
					models.set(j, models.getJSONObject(max));
					models.set(max, temp);
				}
			}

			// 如果查询到的数据项超出设置的范围，则移除超出部分
			while (models.size() > maxItemCount) {
				models.remove(models.size()-1);
			}
		}
		
		jsonData = json.toString();
		return jsonData;
	}

	/**
	 * 设定图例显示位置
	 * @Author    :  wyk 
	 * @return
	 */
	private String initLegend() {
		StringBuffer legend = new StringBuffer();
		legend.append("\n	legend: {");
		legend.append("\n		visible: " + showLegend + ",");
		legend.append("\n		location : '" + legendLocation + "'");
		legend.append("\n	 }");
		return legend.toString();
	}
	
	/**
	 * 设置倾斜角度
	 * @Author    :  wyk 
	 * @return
	 */
	private String configAngle() {
		StringBuffer angleScript = new StringBuffer();
		angleScript.append("\n	labels: {");
		// 设置坐标轴上的文字大小
		if (fontSize != null && !"".equals(fontSize)) {
			angleScript.append("\n		font: '" + fontSize + " sans-serif',");
		}
		angleScript.append("\n		angle: " + this.getAngle());
		angleScript.append("\n	}");
		return angleScript.toString();
	}
	
	public int getAngle() {
		return angle;
	}

	public void setAngle(int angle) {
		this.angle = angle;
	}
	public boolean isUsePercent() {
		return usePercent;
	}

	public void setUsePercent(boolean usePercent) {
		this.usePercent = usePercent;
	}
	
	public void setJsonData(String jsonData) {
		this.jsonData = jsonData;
	}

	public String getTitle() {
		if (this.usePercent) {
			// 使用百分比显示时不显示单位
			return title;
		}
		
		String unitStr = String.valueOf(unit);
		if (title.contains("(单位")) {
			return title;
		}
		return title + " (单位：" + units[unitStr.length()-1] + ")";
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImplementationClass() {
		return implementationClass;
	}

	public void setImplementationClass(String implementationClass) {
		this.implementationClass = implementationClass;
	}

	public String getBackground() {
		return background;
	}

	public void setBackground(String background) {
		this.background = background;
	}
	
	public boolean isAllowExport() {
		return allowExport;
	}

	public void setAllowExport(boolean allowExport) {
		this.allowExport = allowExport;
	}

	public String getBtnWidth() {
		return btnWidth;
	}

	public void setBtnWidth(String btnWidth) {
		this.btnWidth = btnWidth;
	}

	public String getExportType() {
		return exportType;
	}

	public void setExportType(String exportType) {
		this.exportType = exportType;
	}

	public String getDrillDownParams() {
		return drillDownParams;
	}

	public void setDrillDownParams(String drillDownParams) {
		this.drillDownParams = drillDownParams;
	}

	public int getUnit() {
		return unit;
	}

	public void setUnit(int unit) {
		this.unit = unit;
	}
	public String getBordercolor() {
		return bordercolor;
	}

	public void setBordercolor(String bordercolor) {
		this.bordercolor = bordercolor;
	}

	public String getTitlefontsize() {
		return titlefontsize;
	}

	public void setTitlefontsize(String titlefontsize) { 
		this.titlefontsize = titlefontsize;
	}

	public String getShowLegend() {
		return showLegend;
	}

	public void setShowLegend(String showLegend) {
		this.showLegend = showLegend;
	}

	public String getLegendLocation() {
		return legendLocation;
	}

	public void setLegendLocation(String legendLocation) {
		this.legendLocation = legendLocation;
	}

	public String getChartWidth() {
		return chartWidth;
	}

	public void setChartWidth(String chartWidth) {
		this.chartWidth = chartWidth;
	}

	public String getChartHeight() {
		return chartHeight;
	}

	public void setChartHeight(String chartHeight) {
		this.chartHeight = chartHeight;
	}

	public String getBtnHeight() {
		return btnHeight;
	}

	public void setBtnHeight(String btnHeight) {
		this.btnHeight = btnHeight;
	}
	
	public boolean isHideEmptyData() {
		return hideEmptyData;
	}

	public void setHideEmptyData(boolean hideEmptyData) {
		this.hideEmptyData = hideEmptyData;
	}

	public boolean isZoom() {
		return zoom;
	}

	public void setZoom(boolean zoom) {
		this.zoom = zoom;
	}

	public String getFontSize() {
		return fontSize;
	}

	public void setFontSize(String fontSize) {
		this.fontSize = fontSize;
	}

	public int getMaxItemCount() {
		return maxItemCount;
	}

	public void setMaxItemCount(int maxItemCount) {
		this.maxItemCount = maxItemCount;
	}

	public static void main(String[] args) {
		String width = "50.1%";	//50%	50.1%	50.1px
//		System.out.println(String.format("%.0fpx", Double.parseDouble(width) + 5));
		
		
		
		
		
//		String[] widths = {"1px", "11px", "1.1px", "11.11px", ".1px"};
//		for (String w : widths) {
//			System.out.println();
//			System.out.print("被匹配的字符串：" + w + "\t\t\t");
//			Pattern p = Pattern.compile("^\\d+[.]?\\d*");
//			Matcher m = p.matcher(w);
//			while (m.find()) {
//				System.out.print(m.group());
//			}
//			
//			String[] array = p.split(w);
//			System.out.println(array[0] + "----" + array[1]);
//		}
		
		
		String unit = "px";
//		int endIndex = this.btnWidth.indexOf(unit);
//		if (endIndex == -1) {
//			unit = "%";
//			endIndex = this.btnWidth.indexOf(unit);
//		}
		
		int endIndex = -1;
		while (true) {
			endIndex = width.indexOf(unit);
			if (endIndex == -1) {
				unit = "%";
			} else {
				break;
			}
		}
		
		width = width.substring(0, endIndex);
		System.out.println(String.format("%.0f%s", Double.parseDouble(width) + 5, unit));
	}
}
