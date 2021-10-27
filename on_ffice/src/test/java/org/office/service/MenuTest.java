package org.office.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.office.domain.MenuVO;
import org.office.domain.RiceVO;
import org.office.mapper.RiceMapper;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MenuTest {

	@Autowired
	MenuService ms;

	@Autowired
	RiceMapper rm;

	// @Test
	public void getMealListTest() {
		log.info("구내식당 전체메뉴 : " + ms.menuList());
	}

	@Test
	public void getMealTest() {
		List<MenuVO> meal = ms.menuList();
		List<MenuVO> week_meal = new ArrayList<MenuVO>();	

		for (int i = 0; i <= 4; i++) {	//5일 week_meal에 넣기위해 제어 
			int j = (int) (Math.random() * meal.size()); // 메뉴 생길때마다 뽑을 경우수 증가
			if (week_meal.contains(meal.get(j))) {
					i--;
					continue;
				}
			log.info(i + "번 실행");
			week_meal.add(meal.get(j));
		}

		RiceVO vo = new RiceVO();
		log.info("첫번째 메뉴 : " + week_meal.get(0));
		log.info("첫번째 메뉴의 번호 : " + week_meal.get(0).getMno());
		log.info("첫번째 메뉴의 이름 : " + week_meal.get(0).getMain());
		log.info("첫번째 메뉴의 사이드1 : " + week_meal.get(0).getSide1());
		log.info("첫번째 메뉴의 사이드2 : " + week_meal.get(0).getSide2());
		log.info("첫번째 메뉴의 사이드3 : " + week_meal.get(0).getSide3());
		log.info("첫번째 메뉴의 사이드4 : " + week_meal.get(0).getSide4());

		log.info("메뉴 갯수 : " + week_meal.size());
		
		int day = 0;
		while (day <= week_meal.size() -1) {	//5일 기준으로 db에 저장
				
				vo.setMain(week_meal.get(day).getMain());
				vo.setSide1(week_meal.get(day).getSide1());
				vo.setSide2(week_meal.get(day).getSide2());
				vo.setSide3(week_meal.get(day).getSide3());
				vo.setSide4(week_meal.get(day).getSide4());
				rm.riceInsert(vo);
			
			day++;
		}
		

	}

//	@Test
//	public void copyProperties() throws BeansException{
//		List<MenuVO> menu = ms.menuList(); 
//		List<RiceVO> rice = new ArrayList<RiceVO>();
//		log.info("가지고올 값 : " + ms.menuList().toString());
//		BeanUtils.copyProperties(menu, rice);
//		log.info("copy한값 : " + rice);
//		
//	}
}
