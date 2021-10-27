package org.office.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.office.domain.DpCommunityVO;
import org.office.domain.SearchCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class DpCommunityMapperTests {
	
	@Autowired
	private DpCommunityMapper dpcommunityMapper;
	
	//@Test
	public void testDpCList() {
		log.info("부서 게시글 조회중...");
		log.info(dpcommunityMapper.DpCommunityList(1));
	}
	
	//@Test
	public void testDpCdetail() {
		log.info("부서 게시글 상세 조회중...");
		log.info(dpcommunityMapper.DpCdetail(5));
	}
	
	//@Test
	public void testDpCWrite() {
		
		DpCommunityVO vo = new DpCommunityVO();
		
		vo.setDp_code(1);
		vo.setEmpno(1);
		vo.setDtitle("6번째 글");
		vo.setDcontent("6번째 글 내용");
		vo.setDwriter("글쓴이");
		dpcommunityMapper.DpCwriteSelectKey(vo);
	}
	
	//@Test
	public void testDpCUpdate() {
		log.info("부서 게시글 수정중...");
		
		DpCommunityVO vo = new DpCommunityVO();
		vo.setDc_num(6);
		vo.setDtitle("수정글");
		vo.setDcontent("수정된 글 내용");
		vo.setDwriter("수정한 글쓴이");
		dpcommunityMapper.DpCupdate(vo);
	}
	
	//@Test
	public void testDpCDelete() {
		log.info("부서 게시글 삭제중...");
		dpcommunityMapper.DpCdelete(7);
	}	
}
