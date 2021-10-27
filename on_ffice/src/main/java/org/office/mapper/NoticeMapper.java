package org.office.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.office.domain.Criteria;
import org.office.domain.NoticeVO;

public interface NoticeMapper {

// 글 조회 로직
	public List<NoticeVO> noticeList(Criteria cri);

// 전체 글 가져오는 로직
	public int getTotalNotice();
	

// 글 상세보기 로직
	public NoticeVO notice_detail(int notice_num);
	
// lobby 글 조회 로직
	public List<NoticeVO> lobbyNList();
		
// 카테고리 로직
	//public List<NoticeVO> category(List<NoticeVO> list, @Param("ncategory")String ncategory, Criteria cri);
	public List<NoticeVO> category(@Param("PageStart") int PageStart,@Param("amount")int amount, @Param("ncategory") String ncategory);

// 카테고리에 의해 게시글 갯수
	public int getTotalNoticeCate(String ncategory);
	
// 글 작성 로직
	//public void write(NoticeVO vo);
	
	public void writeSelectkey(NoticeVO vo);
// 글 삭제 로직
	public void delete(int notice_num);
	
// 글 수정 로직
	public boolean update(NoticeVO vo);

// 글 조회수 증가 로직
	public void nhit_up(int notice_num);
	

}
