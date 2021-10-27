package org.office.service;
/*
*	작성자 : 배용우
*	진행상황 :  
*	변수정리 : 
*	테스트 성공 유무 :  테스트코딩을 작성했을 경우 성공유무 판단
*	오류사항 : 어떤 문제때문에 해결을 못하고 있다 기술
*	etc...
*	
*/

import java.util.List;

import org.office.domain.BoardAttachVO;
import org.office.domain.Criteria;
import org.office.domain.NoticeVO;

public interface NoticeService {
	
	//글 조회 서비스
	public List<NoticeVO> list(Criteria cri);
	
	//글 전체 갯수 가져오기
	public int getTotalNotice();
	//글 상세보기 서비스
	public NoticeVO detail(int notice_num);
	
	//로비 글 조회 서비스
	public List<NoticeVO> lobbyNList();
	
	//카테고리 서비스
	public List<NoticeVO> category(Criteria cri, String ncategory);
	
	//카테고리에 의해 갯수
	public int getTotalCategory(String ncategory);
	
	// 글 작성 서비스
	public void write(NoticeVO vo);
	
	// 글 삭제 서비스
	public void delete(int notice_num);
	
	// 글 갱신 서비스
	public boolean update(NoticeVO vo);
	
	// 글 조회수 증가 서비스
	public void nhit_up(int notice_num);

	public List<BoardAttachVO> getAttachList(int notice_num);



}
