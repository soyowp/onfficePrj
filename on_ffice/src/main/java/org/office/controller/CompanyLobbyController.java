package org.office.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.office.domain.NoticeVO;
import org.office.domain.UserVO;
import org.office.service.BirthService;
import org.office.service.CrawlingService;
import org.office.service.DepartService;
import org.office.service.DpCommunityService;
import org.office.service.MenuService;
import org.office.service.NoticeService;
import org.office.service.RiceService;
import org.office.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller // 컴포넌트스캔
@RequestMapping("/company/*")
@AllArgsConstructor // 의존성 주입
@Log4j
public class CompanyLobbyController {
	
	@Autowired
	UserService us;
	
	@Autowired
	DpCommunityService dcs;
	
	@Autowired
	DepartService ds;
	
	@Autowired
	NoticeService ns;
	
	@Autowired
	RiceService rs;
	
	@Autowired
	MenuService ms;
	
	@Autowired
	BirthService bs;
	
	@Autowired
	CrawlingService cs;

	@GetMapping("/lobby")
	public String showlobby(Model model, HttpSession session) {
		
		log.info("로비컨트롤러실행");
		UserVO vo = new UserVO();
		vo = (UserVO)session.getAttribute("login_session");
		model.addAttribute("login_session", vo);
		List<NoticeVO> nl = ns.lobbyNList();
		log.info("notice 정보 : " + nl);
		model.addAttribute("nslist", nl);
		
		log.info("rice 정보 : " + rs.selectRice());
		model.addAttribute("rice", rs.selectRice());
		
		List<UserVO> birth_user_view = bs.getBirth();
		log.info("birth 서비스에서 받아온 정보 : " + birth_user_view);
		model.addAttribute("blist", birth_user_view);
	
		model.addAttribute("crawl", cs.crawling());
		log.info("크롤링데이터 호출");
		return "/company/lobby";
	}
	
	@GetMapping("/intro")
	public String showCI() {
		
		return "/company/intro";
	}
	
	@GetMapping("/dplobby")
	public String showdp(String dp_code, Model model, HttpSession session) {
		
		UserVO vo = new UserVO();
		vo = (UserVO)session.getAttribute("login_session");
		
		try {
			int dp_codeCI = Integer.parseInt(dp_code);
			if(vo.getDp_code() == dp_codeCI) {	//로그인 세션이 있을 경우
				model.addAttribute("dpu_list", us.allUserInfoByDp(dp_codeCI));
				
				model.addAttribute("dpc_list", dcs.list(dp_codeCI));	//dpc 부서 커뮤니티
				
				model.addAttribute("dpinfo", ds.getDpInfo(dp_codeCI));
				
				log.info("부서 게시판 : " + dcs.list(dp_codeCI));
					
				}else {
					return "redirect:/company/loginNot";
				}
		} catch (Exception e) {
			return "redirect:/company/loginNot";
		}
		return "/company/dplobby";
		
	}
	
	@GetMapping("/loginNot")
	public ResponseEntity<Void> sendListAuth(){
		
		return new ResponseEntity<>(HttpStatus.FORBIDDEN);
	}
	
	
	@GetMapping("/userInfo")
	public String getInfo(Model model, HttpSession session){
		if(session.getAttribute("login_session") == null) {
			log.info("로그인세션이 없음");
			//model.addAttribute("l_s", "fail");
			//return "/company/users";
			return "/user/logintry_req";
		}
		model.addAttribute("usersInfo", us.allUserInfo());
		log.info("유저리스트 : " + us.allUserInfo());
		
		return "/company/users";
	}
	
	@SuppressWarnings("null")
	@Scheduled(cron="45 * * * * *") // 초 분 시 일 월 요일 (년)   1 - 일요일  
	// 나중에 "0 0 0 * * 1로 바꿀것"
	@GetMapping("/menu")
	public String getMenu() {
		
		RedirectAttributes rttr =null;
		rs.DeleteRice();
		rs.insertRice();
		
		rttr.addFlashAttribute("week", rs.selectRice());
		return "redirect:/company/menu";
	}
	
	@GetMapping("/bdaylist")
	public void getBirth(Model model) {
		
		model.addAttribute("blist", bs.getBirth());
	}
	
}
