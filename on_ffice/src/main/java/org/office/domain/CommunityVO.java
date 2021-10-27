package org.office.domain;

import java.sql.Date;

import lombok.Data;

// 자유게시판 
/*
*	작성자 : 배용우
*	진행상황 :
*	변수정리 : 
*	테스트 성공 유무 :  
*	오류사항 :
*	etc...
*	
*/

@Data
public class CommunityVO {
	private int community_num;
	private String ctitle;
	private String ccontent;
	private String cwriter;
	private Date cdate;
	private Date cupdate;
	private int chits;
	private String cpw;
}
