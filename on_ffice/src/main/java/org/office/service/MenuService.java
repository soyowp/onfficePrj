package org.office.service;


import java.util.List;

import org.office.domain.MenuVO;


public interface MenuService {

	//메뉴표 조회 서비스
	public List<MenuVO> menuList();
}
