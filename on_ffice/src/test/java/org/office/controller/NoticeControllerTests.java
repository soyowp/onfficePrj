package org.office.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
			"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})

@Log4j
@WebAppConfiguration
public class NoticeControllerTests {
	
	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.
				webAppContextSetup(ctx).build();
	}
	@Test
	public void testList() throws Exception {
		
		log.info(
				mockMvc.perform(
						MockMvcRequestBuilders.get("/user/noticeList"))
						.andReturn()
						.getModelAndView()
						.getModelMap()
						);
	}
	
	//@Test
	public void testWrite() throws Exception {
		
		String NoticePage = mockMvc.perform(
				MockMvcRequestBuilders.post("/user/write")
				.param("id", "100002")
				.param("btitle", "2번째 글")
				.param("bcontent","2번째 글 내용")
				.param("name","아무개")
				.param("position","사원")
				.param("dpname", "관리부")
				.param("importance","일반")
				).andReturn().getModelAndView().getViewName();
		
		log.info(NoticePage);
	}

}
