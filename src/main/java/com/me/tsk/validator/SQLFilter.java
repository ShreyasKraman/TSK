package com.me.tsk.validator;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.me.tsk.validator.RequestWrapper;

public class SQLFilter implements Filter{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		if(httpServletRequest.getMethod().equalsIgnoreCase("post")) {
		try {
			  chain.doFilter(new RequestWrapper((HttpServletRequest)request), response);
		} catch (Exception ex) {
			Map<String, Object> map = new HashMap<String,Object>();
			request.setAttribute("error","Some fatal error occured. Make sure you entered correct values");
			request.getRequestDispatcher("/WEB-INF/views/error-page.jsp")
                               .forward(request, response);
			}
		}
		else {
			chain.doFilter(request, response);
		}

	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
