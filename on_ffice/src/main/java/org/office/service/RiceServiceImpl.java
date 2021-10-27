package org.office.service;

import java.util.ArrayList;
import java.util.List;

import org.office.domain.MenuVO;
import org.office.domain.NoticeVO;
import org.office.domain.RiceVO;
import org.office.mapper.RiceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class RiceServiceImpl implements RiceService {

	@Autowired
	MenuService ms;

	@Autowired
	RiceMapper rm;

	@Override
	public void insertRice() {
		List<MenuVO> meal = ms.menuList();
		List<MenuVO> week_meal = new ArrayList<MenuVO>();

		RiceVO vo = new RiceVO();
		for (int i = 0; i <= 4; i++) { // 5일 week_meal에 넣기위해 제어
			int j = (int) (Math.random() * meal.size()); // 메뉴 생길때마다 뽑을 경우수 증가
			if (week_meal.contains(meal.get(j))) {
				i--;
				continue;
			}
			week_meal.add(meal.get(j));
		}

		int day = 0;
		while (day <= week_meal.size() - 1) { // 5일 기준으로 db에 저장

			vo.setMain(week_meal.get(day).getMain());
			vo.setSide1(week_meal.get(day).getSide1());
			vo.setSide2(week_meal.get(day).getSide2());
			vo.setSide3(week_meal.get(day).getSide3());
			vo.setSide4(week_meal.get(day).getSide4());
			rm.riceInsert(vo);

			day++;
		}

	}

	@Override
	public List<RiceVO> selectRice() {
		List<RiceVO> rl = rm.riceSelect();
		log.info("service noticelist" + rl);
		log.info("전체 글 목록 조회");
		return rl;
	}

	@Override
	public void DeleteRice() {
		rm.riceDelete();
	}

}
