/*
*	작성자 : 신우람
*	진행상황 : UserVO, UserMapper, UserService, UserController 생성 및 회원가입 백 로직 작성
*	변수정리 : Mapper에서의 insert = Service에서의 register
*	테스트 성공 유무 :  성공
*	오류사항 : root-context 내에 org.onffice.mapper -> org.office.mapper로 수정
*			그리고 context 추가해서 org.office.service 추가로 서비스를 빈 공장에 넣어줌
*	
*/

package org.office.domain;


import lombok.Data;
@Data
public class UserVO {
	private int empno;
	private String uid;
	private String upw;
	private String name;
	private String profile_img;
	private String gender;
	private String birth;
	private int position_code;
	private String email; 
	private String cp;
	private int dp_code;
	private String job;
	private String depart_name;
	private String p_name;
	private String p_salary;
	private String stat;
	
}
