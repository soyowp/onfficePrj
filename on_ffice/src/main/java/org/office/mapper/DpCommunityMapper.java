package org.office.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.office.domain.DepartVO;
import org.office.domain.DpCommunityVO;
import org.office.domain.SearchCriteria;

public interface DpCommunityMapper {

// 부서코드, 부서이름, 부서 인원 조회
	public DepartVO selectDpInfo(int dp_code);
	
// 글 조회 로직
	public List<DpCommunityVO> DpCommunityList(int dp_code);
	
// 페이징 처리 로직
	public List<DpCommunityVO> DpCList(@Param("PageStart") int PageStart, @Param("amount") int amount, @Param("searchType") String searchType, @Param("keyword") String keyword, @Param("dp_code") Long dp_code, SearchCriteria cri);
	
// 글 전체 개수 가져오는 로직
	public int getTotalBoard(SearchCriteria cri, @Param("dp_code") Long dp_code, @Param("searchType") String searchType, @Param("keyword") String keyword);
	
// 글 상세보기 로직
	public DpCommunityVO DpCdetail(int dc_num);
	
// 글 조회수 증가 로직
	public void dhit_up(int dc_num);
	
// 글 작성 로직
	public void DpCwriteSelectKey(DpCommunityVO vo);
	
// 글 수정 로직
	public void DpCupdate(DpCommunityVO vo); 
	
// 글 삭제 로직
	public void DpCdelete(int dc_num);
	
}
