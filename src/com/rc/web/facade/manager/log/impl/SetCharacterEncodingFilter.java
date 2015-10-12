package com.rc.web.facade.manager.log.impl;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
/**
 * 
 * <p>application name:      字符编码过滤器</p>
 
 * <p>application describing:字符编码过滤器</p>
 
 * @author zhou
 * @version ver 1.0
 */
public final class SetCharacterEncodingFilter
implements Filter
{

public SetCharacterEncodingFilter()
{
    encoding = null;
    filterConfig = null;
    ignore = true;
}

public void destroy()
{
    encoding = null;
    filterConfig = null;
}

public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
    throws IOException, ServletException
{
    if(ignore || request.getCharacterEncoding() == null)
    {
        String contentType = request.getContentType();
        if(contentType != null && !contentType.startsWith("multipart/form-data"))
        {
            String encoding = selectEncoding(request);
            if(encoding != null)
                request.setCharacterEncoding(encoding);
        }
    }
    chain.doFilter(request, response);
}

public void init(FilterConfig filterConfig)
    throws ServletException
{
    this.filterConfig = filterConfig;
    encoding = filterConfig.getInitParameter("encoding");
    String value = filterConfig.getInitParameter("ignore");
    if(value == null)
        ignore = true;
    else
    if(value.equalsIgnoreCase("true"))
        ignore = true;
    else
    if(value.equalsIgnoreCase("yes"))
        ignore = true;
    else
        ignore = false;
}

protected String selectEncoding(ServletRequest request)
{
    return encoding;
}

protected String encoding;
protected FilterConfig filterConfig;
protected boolean ignore;
}
