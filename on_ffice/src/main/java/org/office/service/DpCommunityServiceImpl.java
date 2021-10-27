package org.office.service;

import java.util.List;

import org.office.domain.DepartVO;
import org.office.domain.DpCommunityVO;
import org.office.domain.SearchCriteria;
import org.office.mapper.DepartMapper;
import org.office.mapper.DpCommunityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class DpCommunityServiceImpl implements DpCommunityService{
	
	@Autowired
	private DpCommunityMapper dpcommunitymapper;
	
	@Autowired
	DepartMapper mapper;
	
	@Override
	public DepartVO getDpInfo(int dp_code) {
		
		log.info("부서 정보 조회 서비스 실행");
		return mapper.selectDpInfo(dp_code);
		
	}
	
	@Override
	public List<DpCommunityVO> list(int dp_code) {
		List<DpCommunityVO> DpCommunityList = dpcommunitymapper.DpCommunityList(dp_code);
		log.info("service dpcommunitylist" + DpCommunityList);
		return DpCommunityList;		
	}

	@Override
	public DpCommunityVO DpCdetail(int dc_num) {
		DpCommunityVO vo = dpcommunitymapper.DpCdetail(dc_num);
		log.info(dc_num + "번째 부서글 상세보기 요청");
		log.info("부서글 상세보기 실행");
		int dhits = vo.getDhits();
		
		return vo;
	}

	@Override
	public void dhit_up(int dc_num) {
		log.info("글 조회수 증가");
		dpcommunitymapper.dhit_up(dc_num);
		
	}

	@Override
	public void DpCwrite(DpCommunityVO vo) {
		
		log.info("부서글 작성 실행");
		
		dpcommunitymapper.DpCwriteSelectKey(vo);
		}
		

	@Override
	public void DpCupdate(DpCommunityVO vo) {
		log.info(vo.getDc_num() + "번째 글 수정");
		dpcommunitymapper.DpCupdate(vo);
	}

	@Override
	public void DpCdelete(int dc_num) {
		log.info(dc_num + "번째 글 삭제");
		dpcommunitymapper.DpCdelete(dc_num);
		
	}

	@Override
	public List<DpCommunityVO> DpCListPage(SearchCriteria cri, Long dp_code) {
		List<DpCommunityVO> DpCList = dpcommunitymapper.DpCList(cri.getPageStart(), cri.getAmount(), cri.getSearchType(), cri.getKeyword(), dp_code, cri);
		return DpCList;
	}

	@Override
	public int getTotalBoard(SearchCriteria cri, Long dp_code) {
		
		return dpcommunitymapper.getTotalBoard(cri, dp_code, cri.getSearchType(), cri.getKeyword());
	}
}
