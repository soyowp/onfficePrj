package org.office.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.office.domain.CommunityVO;
import org.office.domain.NoticeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CMSTest {
	//커뮤니티 테스트파일
	@Autowired
	private CommunityService cs;
	
	//@Test
	public void testExist() {
		log.info(cs);
		assertNotNull(cs);
	}
	
	//@Test
	public void testList() {
		
		//cs.list();
	}
	
	//@Test
	public void testWrite() {
		
		CommunityVO vo = new CommunityVO();
		vo.setCtitle("test");
		vo.setCcontent("테스트용 ");
		vo.setCwriter("test1");
		
		cs.write(vo);
		
	}
	//@Test
	public void testDelete() {
		cs.delete(2);
	}
	
	@Test
	public void testUpdate() {
		CommunityVO vo = new CommunityVO();
		vo.setCommunity_num(1);
		vo.setCtitle("test수정");
		vo.setCcontent("수정테스트진행중");
		vo.setCwriter("test1");
		cs.update(vo);
	}
	
	//@Test
	public void testDetail() {
		
		cs.detail(1);
		cs.chit_up(1);
	}
	
	

}
