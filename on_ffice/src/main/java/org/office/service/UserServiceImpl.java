// 신우람 0918 작업
package org.office.service;

import java.util.List;

import org.office.domain.UserVO;
import org.office.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserMapper mapper;
	
	@Autowired
	private PasswordEncoder pwen;
	
	@Override
	public void register(UserVO vo) {
		
		log.info("회원가입 service 실행");
		mapper.insert(vo);
	}

	@Override
	public UserVO login(String uid, String upw) {

			UserVO user = mapper.select(uid, upw);
			log.info("user 조회 값 : " + user);
			log.info("로그인 service 실행");
			return user;

	}

	@Override
	// id 중복체크 서비스
	public int idCheck(String uid) {
		log.info("id 중복검사 service 실행");
		return mapper.selectIdCount(uid);
	}
	
	@Override
	// email 중복체크 서비스
	public int emailCheck(String email) {
		log.info("email 중복검사 service 실행");
		return mapper.selectEmailCount(email);
	}
	
	@Override
	public UserVO userInfo(String uid) {
		log.info("유저 정보 조회 service 실행");
		return mapper.selectUser(uid);
	}
	
	@Override
	public void userModify(UserVO vo) {
		log.info("유저 정보 수정 service 실행");
		log.info("유저 vo 값 : " + vo.getUpw());
		mapper.updateUser(vo);
	}
	
	@Override
	public void userDelete(String uid) {
		log.info("회원 탈퇴 service 실행");
		mapper.deleteUser(uid);
	}
	
	@Override
	public List<UserVO> allUserInfo() {
		log.info("모든회원정보 조회 service 실행");
		return mapper.selectUserList();
	}

	@Override
	public List<UserVO> allUserInfoByDp(int dp_code) {
		log.info("부서별 회원 리스트 service 실행");
		
		return mapper.selectUserListByDp(dp_code);
	}
	@Override
	public void updateStat(String uid, String stat) {
		log.info("유저 상태 변경 서비스 실행");
		mapper.updateStat(stat, uid);
	}

	@Override
	public List<UserVO> selectNullStat() {
		log.info("statNull 조회 서비스 실행");
		return mapper.selectNullStat();
	}
}

