package org.office.service;

import static org.junit.Assert.assertNotNull;

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
public class DpCommunityServiceTests {
	
	@Autowired
	private DpCommunityService service;
	
	//@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	//@Test
	public void testDpCList() {
		
		service.list(1);
	}
	
	//@Test
	public void testDpCDetail() {
		
		service.DpCdetail(2);
		service.dhit_up(2);
	}
	
	//@Test
	public void testDpCWrite() {
		
		DpCommunityVO vo = new DpCommunityVO();
		vo.setDp_code(10001);
		vo.setDtitle("6번째 글");
		vo.setDcontent("6번째 글 내용");
		vo.setDwriter("글쓴이");
		
		service.DpCwrite(vo);
	}
	
	//@Test
	public void testDpCUpdate() {
		
		DpCommunityVO vo = new DpCommunityVO();
		vo.setDc_num(3);
		vo.setDtitle("수정글");
		vo.setDcontent("수정된 글 내용");
		vo.setDwriter("수정한 글쓴이");
		
		service.DpCupdate(vo);
	}
	
	//@Test
	public void testDpCDelete() {
		service.DpCdelete(6);
	}
	
	
}

