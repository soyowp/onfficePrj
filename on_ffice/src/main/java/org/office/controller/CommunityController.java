package org.office.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.office.domain.CommunityVO;
import org.office.domain.Criteria;
import org.office.domain.PageDTO;
import org.office.service.CommunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller // 컴포넌트스캔
@Log4j
@RequestMapping("/community/*") // 이 클래스를 사용하는 메서드이 들어오는 주소 앞 /user로 명명
@AllArgsConstructor // 의존성 주입

public class CommunityController {

	@Autowired
	private CommunityService cs;

	@GetMapping("/CMList")
	public String csList(HttpSession session, Model model, Criteria cri, RedirectAttributes rttr){

		log.info("게시글 로직 접속");
		
		try {
			String ip = null;
			String ip2 = null;
			List<CommunityVO> communityList = cs.list(cri);
			
	
			log.info("커뮤니티 사이즈 : " +communityList.size());
			
			
				for(int i = 0; i < communityList.size(); i++) {
						
					// 자유게시판은 비회원(글쓴이가 ip형식), 회원(글쓴이가 이름)둘 다 사용하는 게시판이므로
					// 아이피형식을 가지는 비회원의 ip를 잘라내는 로직을 실행하기 위해
					// 조건문으로 비회원인지, 회원인지를 확인하기 위해
					// if문 안에 contains(".")을 이용했다. 즉, .이 들어가면 ip 형식이므로 
					// 변환 로직 실행 !
					
					if(communityList.get(i).getCwriter().toString().contains(".")) {
						ip = communityList.get(i).getCwriter().toString();
						ip2 =  ip.split("[.]")[0].concat("." + ip.split("[.]")[1]);
						communityList.get(i).setCwriter(ip2);
						}
					}
					

			int total = cs.getTotalCommunity();
			PageDTO btnMaker = new PageDTO(cri, total, 10);
			model.addAttribute("cmList", communityList);
			model.addAttribute("btnMaker", btnMaker);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.info("글이 한개도 없어서 바로 글쓰기 창으로");
			return "/community/CMList";
		}
			return "/community/CMList";
		
	}
	@PostMapping("/write")
	public String write(CommunityVO vo, RedirectAttributes rttr) {

		log.info("폼에서 불러온 vo " +vo);
		cs.write(vo);

		rttr.addFlashAttribute("community_num", vo.getCommunity_num());

		return "redirect:/community/CMList";
	}

	@GetMapping("/write")
	public String write() {
		return "/community/CMwrite";
	}

	@GetMapping("/CMDetail")
	public String detail(int community_num, Model model) {
		// 사용자가 주소창에
		log.info("form에서 받은 데이터 : " + community_num);
		try {
			CommunityVO vo = new CommunityVO();
			
			cs.chit_up(community_num);
			vo = cs.detail(community_num);
			
			
			String ip = null;
			String ip2 = null;
			
			if(vo.getCwriter().toString().contains(".")) {
				ip = vo.getCwriter().toString();
				ip2 =  ip.split("[.]")[0].concat("." + ip.split("[.]")[1]);
				vo.setCwriter(ip2);
			}
			
			model.addAttribute("csDetail", vo);
			model.addAttribute("ip", ip2);
			
		} catch (Exception e) {
			// 주소창으로 table에 없는 글 번호로 접근할 경우 오류가 뜨기 때문에 redirect시킴
			// 올바르지 않는 구문을 입력할경우 클라이언트에러는 에러페이지 구현해서 처리하기
			e.printStackTrace();
			return "redirect:/community/CMList";
		}

		return "/community/CMDetail";
	}

	@PostMapping("/CM_dcf")
	public String delete(int community_num, String cpwck, RedirectAttributes rttr) {
		log.info("delete 눌렀을 때 글 번호 : " + community_num);
		log.info("delete 눌렀을 때 글 번호 : " + cpwck);	// 사용자가 입력한 값
		
		CommunityVO vo = new CommunityVO();
		vo = cs.detail(community_num);
		if (vo.getCpw().equals(cpwck)) {
			log.info("비밀번호 일치");
			log.info("글번호 : " + community_num);
			cs.delete(community_num);
			rttr.addFlashAttribute("result", "success");
		} else {
			log.info("비밀번호 불일치");
			rttr.addFlashAttribute("result", "fail");
		}

		return "redirect:/community/CMList";

	}

	// 삭제 폼으로 보내기
	@PostMapping("/deleteCheck")
	public String deleteCheck(int community_num, Model model) {
		CommunityVO vo = cs.detail(community_num);
		log.info("delete에서 받아온 vo" + vo);
		model.addAttribute("community", vo);
		return "/community/CM_dcf";
	}

	@PostMapping("/Update")
	public String update(CommunityVO vo, String cpwck, RedirectAttributes rttr) {
		CommunityVO data = cs.detail(vo.getCommunity_num());
		if(data.getCpw().equals(cpwck)) {
			log.info("업데이트 성공");
			cs.update(vo);
			rttr.addFlashAttribute("update", "success");
		}else {
			log.info("업데이트 실패");
			rttr.addFlashAttribute("update", "fail");
			
		}
		return "redirect:/community/CMDetail?community_num=" + vo.getCommunity_num();
	}

	@PostMapping("/CMUpdate")
	public String update(int community_num, Model model) {
		CommunityVO vo = cs.detail(community_num);
		log.info("update에서 받아온 vo : " + vo);
		model.addAttribute("cm", vo);

		return "/community/CMUpdate";
	}

}
