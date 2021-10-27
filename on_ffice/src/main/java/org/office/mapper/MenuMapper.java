package org.office.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.office.domain.MenuVO;

@Mapper
public interface MenuMapper {
	
	// 식단 보기
	public List<MenuVO> menu();
	
}
