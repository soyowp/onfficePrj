package org.office.controller;

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
@ContextConfiguration(
		{"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@Log4j
@WebAppConfiguration
public class CMCTests {
	
	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	
	@org.junit.Before
	public void setUp() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
		public void testList() throws Exception{
			
			log.info(
					// .get(접속주소)/.post(접속주소)를 제외한 나머지는 다 고정
					// .get(접속주소)를 입력하면 get방식으로 해당 주소에 접속
					mockMvc.perform(
					MockMvcRequestBuilders.get("/community/CMList"))
					.andReturn()
					.getModelAndView()
					.getModelMap()
					);
			
		}
	
	
	
}
