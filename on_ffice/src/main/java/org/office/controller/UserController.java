package org.office.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.office.domain.EmailDTO;
import org.office.domain.PhoneDTO;
import org.office.domain.UserVO;
import org.office.service.DepartService;
import org.office.service.EmailService;
import org.office.service.GetIpService;
import org.office.service.PhoneService;
import org.office.service.TodoService;
import org.office.service.PositionService;
import org.office.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller // 컴포넌트스캔
@Log4j
@RequestMapping("/user/*") // 이 클래스를 사용하는 메서드이 들어오는 주소 앞 /user로 명명
@AllArgsConstructor // 의존성 주입

public class UserController {

	@Autowired
	private UserService service;

	@Autowired
	private DepartService ds;

	@Autowired
	private PositionService ps;

	@Autowired
	private EmailService es;

	@Autowired
	private PhoneService phs;

	@Autowired
	private PasswordEncoder pwen;

	@GetMapping("/agreeCheck")
	private void GoAgreeCheck() { 
		log.info("개인정보 동의 창");
	}
	
	@GetMapping("/guestIn")
	private String GuestIn(GetIpService iservice, HttpSession session, Model model) throws Exception {

		log.info("게스트입장 컨트롤러 실행");

		String ip = iservice.getIp();

		session.setAttribute("ip", ip);

		log.info("받아온 ip : " + ip);

		return "redirect:/company/lobby";
	}

	// 회원가입 폼으로 입장하기 위한 컨트롤러

	@GetMapping("/register")
	private String GoRegister(Model model) {

		log.info("register.jsp로 이동");
		log.info(ds.selectDpList());
		log.info(ps.selectPositionList());
		model.addAttribute("dpList", ds.selectDpList());

		model.addAttribute("positionList", ps.selectPositionList());

		return "/user/register";
	}

	@PostMapping("/register")
	private String register(UserVO vo, Model model) {

		if (vo == null) {
			log.info("회원가입 실패");
			return "/user/register";
		}
		log.info("회원가입 시작");

		vo.setUpw(pwen.encode(vo.getUpw()));
		service.register(vo);
		log.info("회원가입할때 부서번호 : " + vo.getDp_code());
		ds.UpCount(vo.getDp_code());
		model.addAttribute("register_result", "success");
		return "/user/login";

	}

	// id 중복체크 위한 컨트롤러 시작

	@GetMapping("/idCheckForm")
	private String goIdCheck() {
		log.info("idCheckForm.jsp로 이동");

		return "/user/idCheckForm";
	}

	@PostMapping("/idCheckProc")
	private String idCheckFunction(String uid, Model model) {
		log.info("아이디 중복 체크 기능 실행");
		int idCheckResult = service.idCheck(uid);
		log.info("아이디 중복체크 결과값 : " + idCheckResult);
		if (idCheckResult == 0) {
			model.addAttribute("uid", uid);
			return "/user/idCheckProc";

		} else {
			model.addAttribute("uid", "fail");
			return "/user/idCheckProc";
		}
	}
	// email 중복체크 위한 컨트롤러 시작

	@GetMapping("/emailCheckForm")
	private String goEmailCheck() {
		log.info("emailCheckForm.jsp로 이동");

		return "/user/emailCheckForm";
	}

	@PostMapping("/emailCheckProc")
	private String emailCheckFunction(EmailDTO dto, String email, Model model) {

		log.info("이메일 중복 체크 기능 실행");
		int emailCheckResult = service.emailCheck(email);
		log.info("이메일 중복체크 결과값 : " + emailCheckResult);
		if (emailCheckResult == 0) {

			List<Integer> codes = new ArrayList<>(Arrays.asList(0, 1, 2, 3, 4, 5, 6, 7, 8, 9));
			Collections.shuffle(codes);

			List<Integer> ranCodes = new ArrayList<>(4);
			ranCodes.add(0, codes.get(0));
			ranCodes.add(1, codes.get(1));
			ranCodes.add(2, codes.get(2));
			ranCodes.add(3, codes.get(3));

			log.info("생성된 이메일 코드 : " + ranCodes.toString());

			dto.setSubject("onffice verification code");
			dto.setReceiveMail(email);
			dto.setMessage("verification code : " + ranCodes.toString());
			dto.setSenderName("onffice");
			dto.setSenderMail("shinwr7@gmail.com");
			log.info("EmailDTO : " + dto);
			es.sendMail(dto);

			String codeString = codes.get(0).toString() + codes.get(1) + codes.get(2) + codes.get(3);

			log.info("4자리 숫자로 변환한 값 : " + codeString);

			model.addAttribute("code", codeString);
			model.addAttribute("email", email);
			return "/user/emailCheckProc";

		} else {
			model.addAttribute("email", "fail");
			return "/user/emailCheckProc";
		}
	}

	@GetMapping("/emailCheckProc")
	private void emailcheckResult() {

		log.info("emailCheckProc으로 이동");
	}

	@PostMapping("/emailCodeCheck")
	private String emailCodeCheck(String email, String codeString, String code, RedirectAttributes rttr) {

		log.info("입력된 코드값 : " + code);
		log.info("발송된 코드값 : " + codeString);

		// 발송된 코드, 생성된 코드 비교
		if (code.equals(codeString)) {

			rttr.addFlashAttribute("email", email);
			rttr.addFlashAttribute("email_result", "success");
		} else {

			rttr.addFlashAttribute("email_result", "fail");
		}

		return "redirect:/user/emailCheckProc";
	}

	@GetMapping("/goPhoneCheckForm")
	private String GoPhoneCheckForm() {

		log.info("phoneCheckForm.jsp로 이동");
		return "/user/phoneCheckForm";
	}

	@PostMapping("/phoneCheckForm")
	private String phoneCheck(String cp, Model model) {
		List<Integer> codes = new ArrayList<>(Arrays.asList(0, 1, 2, 3, 4, 5, 6, 7, 8, 9));
		Collections.shuffle(codes);

		List<Integer> ranCodes = new ArrayList<>(4);
		ranCodes.add(0, codes.get(0));
		ranCodes.add(1, codes.get(1));
		ranCodes.add(2, codes.get(2));
		ranCodes.add(3, codes.get(3));

		log.info("생성된 인증 코드 : " + ranCodes.toString());
		String codeString = codes.get(0).toString() + codes.get(1) + codes.get(2) + codes.get(3);

		log.info("String변환한 인증코드 : " + codeString);

		PhoneDTO dto = new PhoneDTO();
		dto.setTo(cp);

		dto.setText(ranCodes.toString());

		try {
			//phs.sendSMS(dto); // 문자 아끼려고 주석처리해버림

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("sms_result", "fail");
		}

		model.addAttribute("sms_result", "success");
		model.addAttribute("cp", cp);
		model.addAttribute("codeString", codeString);

		return "/user/phoneCheckForm";
	}

	@PostMapping("/phoneCheckProc")
	private String smsCodeCheck(String codeString, String code, String cp, Model model) {
		log.info("문자 코드 비교 컨트롤러 실행");

		if (codeString.equals(code)) {

			model.addAttribute("codeCheck_result", "success");
			model.addAttribute("cp", cp);
		} else {
			model.addAttribute("codeCheck_result", "fail");
		}

		return "/user/phoneCheckForm";
	}

	@GetMapping("/login")
	private String Gologin(String error, String logout, Model model, HttpSession session) {
		UserVO login_session = (UserVO)session.getAttribute("login_session");
		log.info("error여부 : " + error);
		log.info("logout 여부 : " + logout);

		if(login_session == null){
			if (logout != null) {
				log.info("login.jsp로 이동");
				model.addAttribute("logout", "로그아웃 했습니다.");
			}
			
		} else if(login_session != null) {
			
			return "redirect:/company/lobby";
		}
		
		
		return "/user/login";

	}

	@PostMapping("/login")
	private String login(String uid, String upw, Model model, HttpSession session, RedirectAttributes rttr) {
		log.info("login로직 접속");
		log.info("받아온 uid : " + uid);
		log.info("받아온 upw : " + upw);

		UserVO vo = service.login(uid, upw);

		if (vo == null || !pwen.matches(upw, vo.getUpw())) {

			model.addAttribute("login_result", "fail");
			return "/user/login";
		} else {
			
			if(vo.getStat() == null) {
				//처음 회원가입하고 로그인 할 경우
				rttr.addFlashAttribute("check", "no");
				return "redirect:/user/login";
				
			}
			
			if(vo.getStat().equals("가입거절")) {
				//가입 거절 회원
				rttr.addFlashAttribute("permit", "fail");
				return "redirect:/user/login";
			}
			service.updateStat(uid, "온라인");

			rttr.addFlashAttribute("login_result", "success");
			rttr.addFlashAttribute("uid", vo.getName());
			session.setAttribute("login_session", vo);
			session.setMaxInactiveInterval(60 * 100000);
			log.info("로그인 세션 정보" + session.getAttribute("login_session"));

			return "redirect:/company/lobby";

		}
	}

	@PostMapping("/logout")
	public void logoutPost() {
		log.info("포스트 방식으로 로그아웃요청 처리");
	}

	@GetMapping("/logout")
	public void logout(HttpSession session) {

		log.info("로그아웃 폼으로 이동");
		UserVO vo = (UserVO) session.getAttribute("login_session");
		service.updateStat(vo.getUid(), "오프라인");

	}

	@PostMapping("/userInfo")
	private String userInfo(String uid, Model model) {
		log.info("유저 정보 조회 시작");
		UserVO vo = service.userInfo(uid);
		model.addAttribute("userInfo", vo);
		return "/user/userInfo";
	}

	@GetMapping("/userInfo")
	private String goUserInfo(String uid) {
		log.info("유저 정보 페이지로 이동");
		return "/user/userInfo";
	}

	@PostMapping("/userModify")
	private String userModify(UserVO vo, Model model) {
		log.info("유저 정보 수정 시작");
		service.userModify(vo);
		model.addAttribute("userInfo", vo);
		model.addAttribute("modify_result", "success");
		return "/user/userInfo";
	}

	@PostMapping("/goUserModify")
	private String goUserModify(@Param("uid") String uid, Model model) {
		model.addAttribute("userInfo", service.userInfo(uid));
		log.info("유저 정보 수정창 이동");
		return "/user/userModify";
	}

	@PostMapping("/deleteCheck")
		private String deleteCheck(String uid, String upw, Model model, HttpSession session) {
			log.info("탈퇴를 위한 비밀번호 확인 시작");
			// 로그인 로직과 동일하므로, 로그인 서비스 재사용
			UserVO vo = service.login(uid, upw);
			
			if(vo == null || !pwen.matches(upw, vo.getUpw())) {
				log.info("비밀번호가 틀려서 회원탈퇴 실패");
				model.addAttribute("delete_result", "fail");
				model.addAttribute("login_result", "fail");
				return "/user/userInfo";
			} else {
				
				log.info("비밀번호 일치하여 회원탈퇴 진행");
				service.userDelete(uid);
				model.addAttribute("delete_result", "success");
				session.invalidate();
				return "/user/userInfo";
				
			}
		}

	@GetMapping("/deleteCheckForm")
	private String deleteCheckForm() {
		log.info("비밀번호 재확인 페이지 진입");
		return "/user/deleteCheckForm";
	}
	

	@PostMapping("/permit")
	private String permit(String uid, String permit, RedirectAttributes rttr) {
		log.info("폼에서 날려온 데이터 : " + uid);
		UserVO user = new UserVO();
		user.setUid(uid);
		if(permit.equals("ok")) {
		
			service.updateStat(user.getUid(), "가입승인");
		
			rttr.addFlashAttribute("permit", "ok");
			
		}else if(permit.equals("no")) {
			service.updateStat(user.getUid(), "가입거절");
			rttr.addFlashAttribute("permit", "no");
		}
		return "redirect:/mypage/main";
	}
}
