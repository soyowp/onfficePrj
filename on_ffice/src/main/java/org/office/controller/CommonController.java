package org.office.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CommonController {
	
	//여기 오기전에 접근 거부 핸들에서 거치고 리다이렉트로 오는 것
	@GetMapping("/errorPage/accessPage")
	public void accessDenied(Authentication auth, Model model) {
		
		log.info("접근 거부 : " + auth);
		
		model.addAttribute("errorMessage", "권한이 없습니다.");
	}
	
}
