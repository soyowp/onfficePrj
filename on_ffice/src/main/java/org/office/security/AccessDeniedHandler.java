package org.office.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;

import lombok.extern.log4j.Log4j;

@Log4j
public class AccessDeniedHandler implements org.springframework.security.web.access.AccessDeniedHandler{
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.error("접근 거부 핸들러 실행");
		log.error("/errorPage/accessPage로 리다이렉트");
		
		response.sendRedirect("/errorPage/accessPage");
	}
	

}
