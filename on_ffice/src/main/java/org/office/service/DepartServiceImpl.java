package org.office.service;

import java.util.List;

import org.office.domain.DepartVO;
import org.office.mapper.DepartMapper;
import org.office.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class DepartServiceImpl implements DepartService {
	
	@Autowired
	DepartMapper mapper;
	
	@Autowired
	UserMapper um;
	
	@Override
	public DepartVO getDpInfo(int dp_code) {
		
		log.info("부서 정보 조회 서비스 실행");
		return mapper.selectDpInfo(dp_code);
		
	}

	@Override
	public void UpCount(int dp_code) {
		log.info("회원가입시 부서 테이블 사원수 증가");
		mapper.UpCount(dp_code);
	}
	
	@Override
	public List<DepartVO> selectDpList() {
		log.info("부서 리스트 조회 서비스 시작");
		
		return mapper.selectDpList();
	}
}
