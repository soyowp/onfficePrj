package org.office.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.office.domain.TodoCri;
import org.office.domain.TodoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class TodoServiceTests {

	@Autowired
	private TodoService service;

	// @Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}

	// @Test
	public void testgetTodoList() {
		TodoCri cri = new TodoCri();
		log.info(service.getTodoList(cri));

	}

	// @Test
	public void testInsertTodo() {
		TodoVO vo = new TodoVO();
		vo.setChecker(3);
		vo.setWorker(1);
		vo.setComplete("no");
		vo.setTodo_content("테스트폼");
		service.insertTodo(vo);
		log.info(vo);
	}

	// @Test
	public void testPassTodo() {
		TodoVO vo = new TodoVO();
		vo.setTodo_num(1);
		vo.setWorker(4);
		vo.setTodo_content("패스 한 작업내용");
		service.passTodo(vo);
		log.info(vo);
	}

	@Test
	public void testgetTodo() {
		log.info(service.getTodo(2));

	}

	// @Test
	public void teststatTodo() {
		TodoVO vo = new TodoVO();
		vo.setTodo_num(4);
		vo.setComplete("완료!");
		service.statTodo(vo);
		log.info(vo);

	}
}
