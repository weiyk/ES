package com.rc.web.extension.component.mingshigongzuoshi;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import com.rc.web.seriveces.HttpWebs;

public class MingShi {

	private static HttpWebs web;
	private String pages;
	private String total;
	private List<TypeModel> typeList;
	private List<MingshiModel> studios;

	public String getMingShiIndex(String type, String page) {
		web = new HttpWebs();
		web.init();    
		String path = "http://www.kcyun.net/index.php";
		Map<String, String> parmMap = new HashMap<String, String>();
		parmMap.put("m", "interface");
		parmMap.put("c", "discuz");
		parmMap.put("page", page);
		String jsonlist = web.callByGet(path, parmMap);
		System.out.println(jsonlist);
		//String jsonlist = "{\"types\": [\"心理健康教育\",\"生命安全教育\"],\"page\": 1,\"total\": 5,\"size\": 15,\"type\": \"心理健康教育\",\"studio\": [{\"name\": \"佐斌教授工作室\",\"image\": \"http://172.0.0.1/image/01.jpg\",\"desc\": \"佐斌教授工作室........\",\"url\": \"http://172.0.0.1/studio/01.jpg\"},{\"name\": \"佐斌教授工作室\",\"image\": \"http://172.0.0.1/image/01.jpg\",\"desc\": \"佐斌教授工作室........\",\"url\": \"http://172.0.0.1/studio/01.jpg\"},{\"name\": \"佐斌教授工作室\",\"image\": \"http://172.0.0.1/image/01.jpg\",\"desc\": \"佐斌教授工作室........\",\"url\": \"http://172.0.0.1/studio/01.jpg\"}]}";

		//String jsonlist = "{\"flag\": 1,\"msg\": \"查询成功！\",\"page\": 1,\"size\": 9,\"total\": 26,\"types\": [{ \"name\": \"心理健康教育\", \"image\": \"\", \"desc\": \"\",\"url\": \"http://www.kcyun.net/dz/group.php?gid=60\"},{\"name\": \"生命安全教育\",\"image\": \"\",\"desc\": \"\",\"url\": \"http://www.kcyun.net/dz/group.php?gid=61\"}],\"studios\": [{\"name\": \"江家村小学\",\"image\": \"93/group_86_icon.jpg\",\"desc\": \"江家村小学\",\"url\": \"http://www.kcyun.net/dz/forum.php?mod=group&fid=86\"},{\"name\": \"心语工作室\",\"image\": \"\",\"desc\": \"学习交流，共同提升，助人自助！\",\"url\": \"http://www.kcyun.net/dz/forum.php?mod=group&fid=94\"},{\"name\": \"周卫华老师工作室\",\"image\": \"fe/group_83_icon.jpg\",\"desc\": \"周卫华，女，1977年11月19日生，湖北钟祥人，汉族，1999年毕业于湖北理工学院机电一体化专业，2004年至2008年自修于复旦大学的行政管理专业，2011年在湖北经济管理学院参加心理学培训。在十几年的工作中，我学会了做事情要有信心、细心、耐心、恒心，持续坚持才能有收获。现就职于湖北钟祥市志强职业中学，我爱这里的每个人，我将尽力去帮助孩子们，让他们能够身心健康的成长。\",\"url\": \"http://www.kcyun.net/dz/forum.php?mod=group&fid=83\"},{\"name\": \"123\",\"image\": \"\",\"desc\": \"12344\",\"url\": \"http://www.kcyun.net/dz/forum.php?mod=group&fid=82\"},{\"name\": \"我的工作室\",\"image\": \"\",\"desc\": \"简介\",\"url\": \"http://www.kcyun.net/dz/forum.php?mod=group&fid=81\"},{\"name\": \"番茄你个西红柿\",\"image\": \"\",\"desc\": \"努力学习，天天向上！\",\"url\": \"http://www.kcyun.net/dz/forum.php?mod=group&fid=84\"},{\"name\": \"佐斌教授工作室\",\"image\": \"44/group_62_icon.jpg\",\"desc\": \"佐斌，男，1966年12月4日生，湖北仙桃人，汉族。华中师大教育学学士，浙江大学管理心理学硕士，华南师大教育心理学博士，英国巴斯大学（ Bath ）心理学系博士后。现为华中师大教育科学学院心理学系教授。兼任华中师范大学社会心理研究中心常务副主任、教育部华中师范大学基础教育课程研究中心研究员、华中师范大学中国农村问题研究中心研究员（教育部人文社会科学重点研究基地）、以及中国心理学会社会心理学专业委员会委员、中国社会心理学会理论与教学专业委员会委员和应用心理学专业委员会委员、湖北省心理学会副理事长等。\",\"url\": \"http://www.kcyun.net/dz/forum.php?mod=group&fid=62\"},{\"name\": \"马霄汉教授工作室\",\"image\": \"03/group_63_icon.jpg\",\"desc\": \"湖北省国土资源厅地质灾害应急中心，主任，教授级高工。1956年4月出生，湖北省武汉市人，1982年毕业于长春地质学院，教授级高级工程师。2001年~2011年，在湖北省三峡库区地质灾害防治工作领导小组办公室工作，专门从事三峡库区地质灾害治理工程管理。主持编写出版了《湖北省三峡库区滑坡防治地质勘查与治理工程技术规定》、《湖北省三峡库区地质灾害防治工程论文集》、《三峡库区地质灾害防治工程管理工作案例》、《地质灾害治理工程设计参考图集》、地质灾害治理工程施工技术手册等；参与编写了多项三峡库区地质灾害防治有关的技术规定和管理办法。多次为国土资源系统干部继续教育培训讲授地质灾害防治课程。现为湖北省国土资源厅地质灾害应急中心主任，从事地质灾害应急工作。\",\"url\": \"http://www.kcyun.net/dz/forum.php?mod=group&fid=63\"},{\"name\": \"尚重生教授工作室\",\"image\": \"ea/group_64_icon.jpg\",\"desc\": \"哲学硕士，法学博士。现为武汉大学城市安全与社会管理研究中心副主任以及该中心的特聘教授，中外政治制度专业方向研究生导师。中组部武汉大学培训基地核心师资。中央电视台社会与法频道和科教频道特约嘉宾，武汉大学“四大名嘴”之一，被国内媒体誉为“社会解剖师”、社会问题专家、“珞珈山的灵魂”，当代大学生的“精神教父”，2009年初被全国高校评师网海评为魅力教授。2011、2012连续两年被武汉大学海评为十佳教师。长期以来，致力于政治社会学和当代中国社会问题的研究，代表著：《当代中国社会问题透视》《90后大学生姿态》、《儒家政治冲突观念考察》等，获得了良好的社会赞誉。\",\"url\": \"http://www.kcyun.net/dz/forum.php?mod=group&fid=64\"}]}";
		
		JSONArray array = JSONArray.fromObject("[" + jsonlist + "]");
		JSONObject jsonObject = array.getJSONObject(0);
		total = jsonObject.get("total").toString();
		pages = jsonObject.get("page").toString();
		String typess = jsonObject.get("types").toString();
		
		typeList = getJavaCollection(new TypeModel(), jsonObject
				.get("types").toString());

		studios = getJavaCollection(new MingshiModel(), jsonObject
				.get("studios").toString());

		

		return "mingshiindex";
	}

	/**
	 * 封装将json对象转换为java集合对象
	 * 
	 * @param <T>
	 * @param clazz
	 * @param jsons
	 * @return
	 */
	private <T> List<T> getJavaCollection(T clazz, String jsons) {
		List<T> objs = null;
		JSONArray jsonArray = (JSONArray) JSONSerializer.toJSON(jsons);
		if (jsonArray != null) {
			objs = new ArrayList<T>();
			List list = (List) JSONSerializer.toJava(jsonArray);
			for (Object o : list) {
				JSONObject jsonObject = JSONObject.fromObject(o);
				T obj = (T) JSONObject.toBean(jsonObject, clazz.getClass());
				objs.add(obj);
			}
		}
		return objs;
	}

	public static void main(String args[]) {
		MingShi ms = new MingShi();
		ms.getMingShiIndex(null, "0");
	}

	public static HttpWebs getWeb() {
		return web;
	}

	public static void setWeb(HttpWebs web) {
		MingShi.web = web;
	}

	public String getPages() {
		return pages;
	}

	public void setPages(String pages) {
		this.pages = pages;
	}

	

	public List<TypeModel> getTypeList() {
		return typeList;
	}

	public void setTypeList(List<TypeModel> typeList) {
		this.typeList = typeList;
	}

	public List<MingshiModel> getStudios() {
		return studios;
	}

	public void setStudios(List<MingshiModel> studios) {
		this.studios = studios;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}
	
}
