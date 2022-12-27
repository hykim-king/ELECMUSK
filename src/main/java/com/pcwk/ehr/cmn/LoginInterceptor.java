package com.pcwk.ehr.cmn;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {

	final Logger LOG = LogManager.getLogger(getClass());
	
	//로그인 세션이 없으면 로그인 페이지로이동
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		
		Object obj = session.getAttribute("userInfo");
		
		LOG.debug("obj: "+obj );
		//session이 없으면 로그인 페이지로 이동
		if(null == obj) {
			LOG.debug("request.getContextPath: "+request.getContextPath());
			String sendurl = request.getContextPath()+"/login/login.do";
			response.sendRedirect(sendurl);
			
			return false;//요청 컨트롤러는 호출되지 않음.
		}
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}

}
