package org.office.service;

import java.util.List;

import org.office.domain.PositionVO;
import org.office.mapper.PositionMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class PositionServiceImpl implements PositionService{

	PositionMapper mapper;
	
	public List<PositionVO> selectPositionList() {
		log.info("직급 리스트 조회 서비스 시작");
		
		return mapper.selectPositionList();
	}
}
