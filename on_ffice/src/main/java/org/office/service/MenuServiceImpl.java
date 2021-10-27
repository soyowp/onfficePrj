package org.office.service;

import java.util.List;

import org.office.domain.MenuVO;
import org.office.mapper.MenuMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MenuServiceImpl implements MenuService{

	@Autowired
	MenuMapper mm;

	@Override
	public List<MenuVO> menuList() {
		log.info("메뉴리스트조회");
		return mm.menu();
		
	}
	
}
