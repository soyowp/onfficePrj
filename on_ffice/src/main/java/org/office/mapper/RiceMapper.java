package org.office.mapper;


import java.util.List;

import org.office.domain.RiceVO;

public interface RiceMapper {

	//식단 조회받아서 입력처리
	public void riceInsert(RiceVO vo);
	
	//입력한 것 조회
	public List<RiceVO> riceSelect();
	
	public void riceDelete();
}
