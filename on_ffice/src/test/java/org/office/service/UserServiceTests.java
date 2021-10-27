// 신우람 0918 작업
package org.office.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.office.domain.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

// 유저 관련 서비스(회원가입, 로그인, 회원수정, 탈퇴 등)의 테스트를 위한 페이지

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserServiceTests {

	@Autowired
	private UserService service;

	// 먼저 서비스가 제대로 주입되었는지 여부 확인
	// @Test
	public void testExist() {
		log.info(service);

		// assertNotNull은 해당 객체가 주입이 되지 않아
		// null인경우 에러를 발생
		assertNotNull(service);
	}

	@Test
	public void testLogin() {
		// form에서 입력한 값
		String uid = "test1";
		String upw = "1234";
		try {
			UserVO user = service.login(uid, upw);
			if(user == null) {
				log.info("아이디나 비밀번호가 적합하지 않습니다.");
				
			} else {
				log.info("로그인 성공 ");
				log.info(service.allUserInfo());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
