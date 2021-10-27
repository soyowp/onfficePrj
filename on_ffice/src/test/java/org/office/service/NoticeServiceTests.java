package org.office.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.office.domain.Criteria;
import org.office.domain.NoticeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class NoticeServiceTests {
	
	@Autowired
	private NoticeService service;
	
	//@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		log.info("testlist");
		log.info("testList : " + service.list(cri));
	}
	
	//@Test
	public void testWrite() {
		
		NoticeVO vo = new NoticeVO();
		vo.setNtitle("test");
		vo.setNcontent("테스트용 ");
		vo.setNwriter("test1");
		
		service.write(vo);
		
	}
	//@Test
	public void testDelete() {
		service.delete(3);
	}
	
	//@Test
	public void testUpdate() {
		NoticeVO vo = new NoticeVO();
		vo.setNotice_num(1);
		vo.setNtitle("test수정");
		vo.setNcontent("수정테스트진행중");
		vo.setNwriter("test1");
		service.update(vo);
	}
	
	//@Test
	public void testDetail() {
		
		service.detail(1);
		service.nhit_up(1);
	}
	
	

}
