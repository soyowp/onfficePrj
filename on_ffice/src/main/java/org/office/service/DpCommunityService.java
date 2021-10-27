package org.office.service;
/*
*	작성자 : 신동규
*	진행상황 : 글 전체조회, 상세보기, 조회수  
*	변수정리 : 
*	테스트 성공 유무 :  테스트코딩을 작성했을 경우 성공유무 판단
*	오류사항 : 어떤 문제때문에 해결을 못하고 있다 기술
*	etc...
*	
*/
import java.util.List;

import org.office.domain.DepartVO;
import org.office.domain.DpCommunityVO;
import org.office.domain.SearchCriteria;

public interface DpCommunityService {
	
	// 글 조회 서비스
	public List<DpCommunityVO> list(int dp_code);
	
	// 페이징 글 목록
	public List<DpCommunityVO> DpCListPage(SearchCriteria cri, Long dp_code);
	
	// 사원 정보 가져오는 로직
	public DepartVO getDpInfo(int dp_code); 
	
	// 전체 글 개수 가져오기
	public int getTotalBoard(SearchCriteria cri, Long dp_code);
	
	// 글 상세보기 서비스
	public DpCommunityVO DpCdetail(int dc_num);
	
	// 글 조회수 증가 서비스
	public void dhit_up(int dc_num);
	
	// 글 작성 서비스
	public void DpCwrite(DpCommunityVO vo);
	
	// 글 수정 로직
	public void DpCupdate(DpCommunityVO vo);
	
	// 글 삭제 로직
	public void DpCdelete(int dc_num);

}
