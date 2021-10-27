// 2021.09.23 ������

package org.office.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.office.domain.UserVO;
import org.office.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/bday/*")
@AllArgsConstructor
public class BdayController {

	@Autowired
	UserService us;

	@GetMapping("/bdaylist")
	public String list(Model model) {
		UserVO vo = new UserVO();
		Calendar c = Calendar.getInstance();
		List<UserVO> user = us.allUserInfo(); // 6
		List<String> birth_user = new ArrayList<>(); // 생일인 사람 저장하는 list
		List<UserVO> birth_user_view = new ArrayList<>();
		String month = null;
		String temp = null; // user에서 꺼내온 생일 담을 변수
		int monthi = c.get(Calendar.MONTH);
		String months = String.valueOf(monthi); // int -> string으로 바꾸기
		String zero = "0"; // 만약 10월 미만일 경우 두자리 만들어주기 위해
		log.info("months길이 " + months.length());
		log.info("이번달 : " + months);
		log.info("userList갯수 : " + user.size());
		if (months.length() == 1) {
			month = zero + months;	//concat으로 해볼까 생각중
		}

		for (int i = 0; i <= user.size() - 1; i++) {
			temp = user.get(i).getBirth();
			if (temp.substring(5, 7).equals(month) || temp.substring(5, 7).equals(months)) {
				log.info("한번 실행");

				birth_user.add(user.get(i).getUid());
			}

		}

		log.info("birth : " + birth_user);
		log.info("brith_user" + birth_user.size());
		
		//view 에 뿌려질 내용
		for (int i = 0; i <= birth_user.size() - 1; i++) {
			birth_user_view.add(us.userInfo(birth_user.get(i)));
		}
		log.info("생일인 사람 : " + birth_user_view);
		 model.addAttribute("blist", birth_user_view);
		 
		 return "/company/lobby";
	}
}
