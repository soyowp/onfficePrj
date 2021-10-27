package org.office.service;

import java.util.List;

import org.office.domain.CommunityVO;
import org.office.domain.Criteria;
import org.office.domain.NoticeVO;
import org.office.mapper.CommunityMapper;
import org.office.mapper.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class CommunityServiceImpl implements CommunityService{
	
	@Autowired
	private CommunityMapper CM;
	
	@Override
	public List<CommunityVO> list(Criteria cri) {
		List<CommunityVO> CommunityList = CM.CommunityList(cri);
		log.info("service Communitylist" + CommunityList);
		log.info("전체 글 목록 조회");
		return CommunityList;
	}
	
	@Override
	public int getTotalCommunity() {
		return CM.getTotalCommunity();
	}

	
	@Override
	public void write(CommunityVO vo) {
		
		log.info("글작성 실행");
		CM.writeSelectkey(vo);
		
	}

	@Override
	public void delete(int community_num) {
		log.info(community_num + "번째 글 삭제 요청");
		log.info("글 삭제 실행");
		CM.delete(community_num);
		
	}

	@Override
	public void update(CommunityVO vo) {
		log.info(vo.getCommunity_num() + "번째 글 갱신 요청");
		log.info("글 갱신 실행");
		CM.update(vo);
	}

	@Override
	public CommunityVO detail(int community_num) {
		log.info(community_num + "번째 글 상세보기 요청");
		log.info("글 상세보기 실행");
		CommunityVO vo = CM.Community_detail(community_num);
		return vo;
		
		
	}

	@Override
	public int chit_up(int community_num) {
		log.info("글 조회수 증가");
		return CM.chit_up(community_num);
	}

	@Override
	public String splitIp(CommunityVO vo) {
		String ip = vo.getCwriter().toString();
		String ip2 =  ip.split("[.]")[0].concat("." + ip.split("[.]")[1]);
		return ip2;
	}



}
