package org.office.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.office.domain.DpCommunityVO;
import org.office.domain.PageDTO;
import org.office.domain.SearchCriteria;
import org.office.domain.UserVO;
import org.office.service.DpCommunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller //컴포넌트스캔
@Log4j
@RequestMapping("/dpcommunity/*") //이 클래스를 사용하는 메서드이 들어오는 주소 앞 /dpcommunity로 명명
@AllArgsConstructor // 의존성 주입

public class DpCommunityController {
	
	@Autowired
	private DpCommunityService service;
	
	@GetMapping("/dpclist")
	public String dpCommunityList(SearchCriteria cri, Long dp_code, Model model, HttpSession session) {
				
		UserVO vo = new UserVO();
		vo = (UserVO)session.getAttribute("login_session");
		try {
			Long dp_codeCI = dp_code;
			if(vo.getDp_code() == dp_codeCI) {
			log.info("부서 자유 게시판 로직 접속");
			List<DpCommunityVO> DpCList = service.DpCListPage(cri, dp_code);
			
			int total = service.getTotalBoard(cri, dp_code);
			PageDTO btnMaker = new PageDTO(cri, total, 10);
			model.addAttribute("btnMaker", btnMaker);
			model.addAttribute("dp_code", dp_code);
			model.addAttribute("dpCommunityList", DpCList);
		
			} else {
				return "redirect:/dpcommunity/loginNot";
			}
		} catch (Exception e) {
			return "redirect:/dpcommunity/loginNot";
		}
		return "/dpcommunity/dpclist";
	}
	
	@GetMapping("/loginNot")
	public ResponseEntity<Void> sendListAuth(){
		
		return new ResponseEntity<>(HttpStatus.FORBIDDEN);
	}
	
	
	@PostMapping("/dpcwrite")
	public String DpCwrite(DpCommunityVO vo, RedirectAttributes rttr) {
		
		service.DpCwrite(vo);
		log.info(vo);
		rttr.addAttribute("dp_code", vo.getDp_code());
		rttr.addFlashAttribute("dc_num", vo.getDc_num());
		return "redirect:/dpcommunity/dpclist";
	}
	
	@GetMapping("/dpcwrite")
	public String DpCwrite() {
		return "dpcommunity/dpcwrite";
	}
	
	@GetMapping("/dpcdetail")
	public String DpCdetail(int dc_num, Model model) {
		log.info("form에서 받은 값 : " + dc_num);
		try {
			service.dhit_up(dc_num);
			model.addAttribute("dpcdetail", service.DpCdetail(dc_num));
			
		} catch (Exception e) {
			
			return "redirect:/dpcommunity/dpclist";
		}
		
		return "/dpcommunity/dpcdetail";
		
	}
	
	@PostMapping("/Update")
	public String update(DpCommunityVO vo, SearchCriteria cri, RedirectAttributes rttr) {
		log.info("Update에서 받아온 vo : " + vo);
		service.DpCupdate(vo);
				
		rttr.addAttribute("dc_num", vo.getDc_num());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/dpcommunity/dpcdetail";
	}
	
	@PostMapping("/dpcupdate")
	public String DpCupdate(int dc_num, Model model) {
		
		DpCommunityVO vo = service.DpCdetail(dc_num);
		log.info("dpcUpdate에서 받아온 vo : " + vo);
		
		model.addAttribute("dpcommunity", vo);
		
		return "/dpcommunity/dpcupdate";
	}
	
	@PostMapping("/dpcdelete")
	public String DpCdelete(SearchCriteria cri, int dc_num, DpCommunityVO vo, RedirectAttributes rttr) {
		service.DpCdelete(dc_num);
		rttr.addFlashAttribute("result", "success");
		rttr.addFlashAttribute("dc_num", dc_num);
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("dp_code", vo.getDp_code());
		return "redirect:/dpcommunity/dpclist";
	}
	
		
}
