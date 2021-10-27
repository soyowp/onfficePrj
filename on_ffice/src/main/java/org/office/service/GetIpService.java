package org.office.service;


import javax.servlet.http.HttpServletRequest;

import org.apache.http.client.utils.HttpClientUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
@AllArgsConstructor
public class GetIpService {
	
	public String getIp(){
		log.info("getIp 서비스 실행");
		String ip3 = null;
		String ip = null;
		// getRemoteAddr()은 web server에서 프록시나 로드 밸런서를 통해 was에 요청하기 때문에
		// 프록시나 로드밸런서의 IP 주소만을 담고 있다. 그래서 원 IP를 못가져오는 현상이 발생한다.
		
		// 그래서 ! 
		
		// X-Forwarded-For (XFF) 헤더는 HTTP 프록시나 로드 밸런서를 통해 웹 서버에 접속하는
		// 클라이언트의 원 IP 주소를 식별하는 표준 헤더로 쓰이고 있다. 그래서 프록시나 로드밸런스 등을 사용할 경우 
		// Apache/Nginx에서 설정이 되어있다는 가정하에 클라이언트의 실제 접속 IP를 가져올 수 있다.
		
//	    HttpServletRequest request = 
//	    ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
//		
//		ip = request.getHeader("X-Forwarded-For");
//		
//		// 네트워크 상태(?)별로 헤더의 종류가 많음 !
//		// so, 헤더의 종류별로 조건문을 걸어서 걸러주는 로직 필요
//		
//        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
//            ip = request.getHeader("Proxy-Client-IP");  
//        }  
//        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
//            ip = request.getHeader("WL-Proxy-Client-IP");  
//        }  
//        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
//            ip = request.getHeader("HTTP_CLIENT_IP");  
//        }  
//        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
//            ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
//        }  
//        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
//        	ip = request.getHeader("X-Real-IP");  
//        }  
//        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
//        	ip = request.getHeader("X-RealIP");  
//        }  
//        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
//            ip = request.getRemoteAddr();  
//        
//        }
//	    
	try (java.util.Scanner s = new java.util.Scanner(new java.net.URL("https://api.ipify.org").openStream(), "UTF-8").useDelimiter("\\A")) {
			
			ip = s.next();
			
			System.out.println("ip : " + ip.split("[.]")[0].concat("." + ip.split("[.]")[1]));
			
			
		} catch (java.io.IOException e) {
		    e.printStackTrace();
		}
		
		return ip;
		
	}
}
