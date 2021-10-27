package org.office.mapper;

import java.util.List;

import org.office.domain.DepartVO;

public interface DepartMapper {
	
	// 부서코드, 부서이름, 부서 인원 조회
	
	public DepartVO selectDpInfo(int dp_code);
	
	public void UpCount(int dp_code);
	
	public List<DepartVO> selectDpList();
	
}
