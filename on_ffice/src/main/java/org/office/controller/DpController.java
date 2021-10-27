package org.office.controller;

import org.office.service.DepartService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller //컴포넌트스캔
@Log4j
@RequestMapping("/depart/*") //이 클래스를 사용하는 메서드이 들어오는 주소 앞 /depart로 명명
@AllArgsConstructor // 의존성 주입
public class DpController {

	@Autowired
	DepartService service;
	
	
	
}
