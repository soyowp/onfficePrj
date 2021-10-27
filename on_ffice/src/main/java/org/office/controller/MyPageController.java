/*
*	작성자 : 고광훈
*	진행상황 : src/main/java 패키지 생성, office페이지 컨트롤러, Mapper, Service, VO 생성 
*	변수정리 : 
*	테스트 성공 유무 :  9/21 main페이지 테스트 성공
*	오류사항 : 
*	etc...
*	
*/
package org.office.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.office.domain.TodoCri;
import org.office.domain.TodoDTO;
import org.office.domain.TodoVO;
import org.office.domain.UserVO;
import org.office.service.TodoService;
import org.office.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller // 컴포넌트스캔
@Log4j
@RequestMapping("/mypage/*") // 이 클래스를 사용하는 메서드이 들어오는 주소 앞 /mypage로 명명
@AllArgsConstructor // 의존성 주입
public class MyPageController {

	@Autowired
	private TodoService service;
	private UserService user_service;

	@GetMapping("/main")
	public String getInfo(Model model, HttpServletRequest request, TodoCri cri) {
		
		try{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		HttpSession session = request.getSession();
		UserVO login_session = (UserVO) session.getAttribute("login_session");
		String login_time = formatter.format(session.getCreationTime());
		cri.setWorker(login_session.getEmpno());
		cri.setChecker(login_session.getEmpno());
		cri.setStartPage((cri.getPageNum() -1) * cri.getAmount());
		int totalTodo = service.todoCnt();
		TodoDTO btnMaker = new TodoDTO(cri, totalTodo, 10);
		
		log.info("유저 메인페이지 접속");
		log.info("받아온 세션 : " + login_session);
		UserVO uservo = user_service.login(login_session.getUid(), login_session.getUpw());
		log.info("받아온 정보 : " + uservo);
		List<TodoVO> todoList = service.getTodoList(cri);
		log.info("받아온 할일 : " + todoList);
		List<TodoVO> createdList = service.getcreatedTodo(cri);
		log.info("내가 생성한 할일 :" + createdList);
		List<TodoVO> completeList = service.getTodoComplete(cri);
		log.info("완료된 목록 : " + completeList);
		List<UserVO> userList = user_service.allUserInfo();
		log.info("전체유저리스트 :" + userList);
		List<UserVO> StatNull = user_service.selectNullStat();

		model.addAttribute("info", uservo);
		model.addAttribute("login_time", login_time);
		model.addAttribute("todoList", todoList);
		model.addAttribute("createdList", createdList);
		model.addAttribute("completeList", completeList);
		model.addAttribute("users", userList);
		model.addAttribute("btnMaker", btnMaker);
		model.addAttribute("StatNull", StatNull);
		
		return "/mypage/main";
		
		}
		catch(Exception e) {
			e.printStackTrace();
			return "/user/logintry_req";
		}
	}

	@PostMapping("/insertTodo")
	public String insertTodo(TodoVO vo, Model model, RedirectAttributes rttr) {
		vo.setTodo_content(vo.getTodo_content());
		service.insertTodo(vo);
		log.info(vo);
		rttr.addFlashAttribute("result", "insert");
		return "redirect:/mypage/main";
	}

	@PostMapping("/passTodo")
	public String passTodo(TodoVO vo, Model model, RedirectAttributes rttr, HttpServletRequest req) {
		HttpSession session = req.getSession();
		UserVO login_session = (UserVO) session.getAttribute("login_session");
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String formDate = formatter.format(date);
		StringBuilder sb = new StringBuilder();
		sb.append(req.getParameter("already_todo_content"));
		sb.append("\r["+ formDate + login_session.getName() + " 추가]\r "+ req.getParameter("todo_content"));
		vo.setTodo_content(sb.toString());
		service.passTodo(vo);
		log.info(vo);
		rttr.addFlashAttribute("result", "pass");
		return "redirect:/mypage/main";
	}

	@PostMapping("/completeTodo")
	public String completeTodo(TodoVO vo, Model model, RedirectAttributes rttr) {
		service.statTodo(vo);
		log.info(vo);
		rttr.addFlashAttribute("result", "complete");
		return "redirect:/mypage/main";
	}
	
	@GetMapping("/detailTodo")
	public TodoVO getTodo(TodoVO vo, Model model) throws Exception {
		vo = service.getTodo(vo.getTodo_num());
		model.addAttribute("getTodo", vo);
		log.info(vo);
		return vo;

	}

	@PostMapping("/awayFromKeyboard")
	public String afk(UserVO vo, Model model) {
		log.info(vo);
		user_service.updateStat(vo.getUid(), vo.getStat());
		return "redirect:/mypage/main";

	}
	
	@GetMapping("/chat")
	public void goChat() {
		
	}

}
