package com.rc.web.seriveces;

import java.io.IOException;

import java.io.InputStream;

import java.util.HashMap;
import java.util.Map;

import java.util.concurrent.atomic.AtomicInteger;

import org.apache.commons.httpclient.HttpClient;

import org.apache.commons.httpclient.HttpException;

import org.apache.commons.httpclient.HttpStatus;

import org.apache.commons.httpclient.MultiThreadedHttpConnectionManager;

import org.apache.commons.httpclient.NameValuePair;

import org.apache.commons.httpclient.methods.GetMethod;

import org.apache.commons.httpclient.methods.PostMethod;

import org.apache.commons.httpclient.params.HttpConnectionManagerParams;

import org.apache.commons.io.IOUtils;

import org.slf4j.Logger;

import org.slf4j.LoggerFactory;

import com.rc.eschool.fundmanage.expend.GetUrl;

public class HttpWebs {
	private final static Logger logger = LoggerFactory
			.getLogger(HttpWebs.class);

	private static HttpClient httpClient = null;

	private static MultiThreadedHttpConnectionManager connectionManager = null;// 多线程管理器

	private int maxThreadsTotal = 128;// 最大线程数

	private int maxThreadsPerHost = 32; // 分配给每个客户端的最大线程数

	private int connectionTimeout = 15000;// 连接超时时间,毫秒

	private int soTimeout = 14000;// 读取数据超时时间，毫秒

	public void init() {

		connectionManager = new MultiThreadedHttpConnectionManager();

		HttpConnectionManagerParams params = new HttpConnectionManagerParams();

		params.setConnectionTimeout(connectionTimeout);

		params.setMaxTotalConnections(maxThreadsTotal);

		params.setSoTimeout(soTimeout);

		if (maxThreadsTotal > maxThreadsPerHost) {

			params.setDefaultMaxConnectionsPerHost(maxThreadsPerHost);

		} else {

			params.setDefaultMaxConnectionsPerHost(maxThreadsTotal);

		}

		connectionManager.setParams(params);

		httpClient = new HttpClient(connectionManager);

		httpClient.getHttpConnectionManager().getParams()
				.setConnectionTimeout(connectionTimeout);

		httpClient.getHttpConnectionManager().getParams()
				.setSoTimeout(soTimeout);

	}

	/**
	 * 
	 * get方式访问
	 * 
	 * 
	 * 
	 * @param url
	 * 
	 * 
	 * @param parmMap
	 * 
	 * @return
	 */

	public String callByGet(String url, Map<String, String> parmMap) {

		if (logger.isDebugEnabled()) {

			logger.debug("in get,url:" + url);

		}

		GetMethod getMethod = new GetMethod(url);
		if (parmMap != null) {
			NameValuePair[] params = new NameValuePair[parmMap.size()];

			AtomicInteger atomicInteger = new AtomicInteger(0);

			for (Map.Entry<String, String> parm : parmMap.entrySet()) {

				NameValuePair parmValue = new NameValuePair(parm.getKey(),
						parm.getValue());

				params[atomicInteger.getAndIncrement()] = parmValue;

			}

			getMethod.setQueryString(params);

		}
		int statusCode = 0;

		try {

			statusCode = httpClient.executeMethod(getMethod);

			if (logger.isDebugEnabled()) {

				logger.debug("inget,statusCode:" + statusCode);

			}

			if (statusCode != HttpStatus.SC_OK) {

				// 访问失败

				logger.error("in get,访问知了树平台失败。网络问题。statusCode：" + statusCode);

				return null;

			}

			InputStream inputStream = getMethod.getResponseBodyAsStream();

			if (inputStream == null) {

				// 访问正常：获取到的数据为空

				logger.error("in get,从知了树平台返回的数据为空！");

				return null;

			}

			String rtn = IOUtils.toString(inputStream, "utf-8");

			return rtn;

		} catch (HttpException e) {

			logger.error("get方式访问知了树平台失败！", e);

			return null;

		} catch (IOException e) {

			logger.error("get方式访问知了树平台失败！", e);

			return null;

		} finally {

			getMethod.releaseConnection();

		}

	}

	/**
	 * 
	 * post方式访问
	 * 
	 * 
	 * 
	 * @param url
	 * 
	 * 
	 * @param parmMap
	 * 
	 * @return
	 */
	@SuppressWarnings("unused")
	public String callByPost(String url, Map<String, String> parmMap) {

		if (logger.isDebugEnabled()) {

			logger.debug("inpost,url:" + url);

		}

		PostMethod p = new PostMethod(url);

		if (parmMap != null) {

			NameValuePair[] params = new NameValuePair[parmMap.size()];

			AtomicInteger atomicInteger = new AtomicInteger(0);

			for (Map.Entry<String, String> parm : parmMap.entrySet()) {

				NameValuePair parmValue = new NameValuePair(parm.getKey(),
						parm.getValue());

				params[atomicInteger.getAndIncrement()] = parmValue;

			}

			p.setRequestBody(params);

		}

		try {

			int statusCode = httpClient.executeMethod(p);

			logger.debug("inget,statusCode:" + statusCode);

			if (statusCode != HttpStatus.SC_OK) {

				// 异常

				logger.error("in post,访问知了树平台失败。网络问题。statusCode：" + statusCode);

				return null;

			}

			InputStream inputStream = p.getResponseBodyAsStream();

			if (inputStream == null) {

				// 访问正常

				logger.error("in post,从知了树平台返回的数据为空！");

				return null;

			}

			String rtn = IOUtils.toString(inputStream, "utf-8");

			return rtn;

		} catch (HttpException e) {

			logger.error("post方式访问知了树平台失败！", e);

			return null;

		} catch (IOException e) {

			logger.error("post方式访问知了树平台失败！", e);

			return null;

		} finally {

			p.releaseConnection();

		}

	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		/***************** 管理员 ****************/
		// 用户名：hbtest 密码： e10adc3949ba59abbe56e057f20f883e
		// 渠道ID:98304
		/***************** 用户： ****************/
		// 用户名：17056567878 密码： f5cb2589a47b0dfa70dcbd73b8b7bfa
		// uid:327680 key: 47E2BA77590BA65EA00FA32A83D456624AB3944C
		// schoolid: 196609 公告ID：622610 622593
		// 墙ID： 55bf3a953641d80000000df4 帖子ID： 55c0342c3641d80000000f30
		// 55c034433641d80000000f31 55c034573641d80000000f32
		// 通讯录ID cid：55bf4b553641d80000000e2d 课程ID（courseId）：393216,819200
		// 班级ID（classId）:294912,294913
		// 人员ID："teachet":"360448,786432","student":"425984,851968"
		HttpWebs wes = new HttpWebs();
		wes.init();
		try {
//			Map<String, String> parmMap = new HashMap<String, String>();
//			parmMap.put("uid", "327680");
//			parmMap.put("sid", "196609");
//			parmMap.put("key", "47E2BA77590BA65EA00FA32A83D456624AB3944C");
//			parmMap.put("pagecount", "1");
//			parmMap.put("counts", "8");
//			parmMap.put("type", "3");
//			String url = "http://118.26.134.24/jymis/szxx/notice/findNoticeList.do";
//			String str = wes.callByGet(url, parmMap);
//			// String str=wes.callByPost(url,parmMap);
//			str = Base64Util.decrypt(str);// 解密
//			System.out.println(str);
			Map<String, String> parmMap = new HashMap<String, String>();
			//http://118.26.134.24/jymis/szxx/notice/findNoticeList.do?
//			parmMap.put("key","");
//			parmMap.put("uid","");
//			parmMap.put("articleId","491520");
			GetUrl ur=new GetUrl();
			String url=ur.getUrl("ReDianTJ_url");
			String str = wes.callByPost(url, parmMap);
			str = Base64Util.decrypt(str);// 解密
			System.out.println(str);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
