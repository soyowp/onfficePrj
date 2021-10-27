package org.office.service;

import java.util.List;

import org.office.domain.CMReplyVO;
import org.office.mapper.CMReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class CMReplyServiceImpl implements CMReplyService {
	
	@Autowired
	CMReplyMapper crm;
	
	public void addCMreply(CMReplyVO vo) {
		crm.create(vo);
		
	}

	@Override
	public List<CMReplyVO> listCMReply(int community) {

		return crm.getList(community);
	}

	@Override
	public void modifyCMReply(CMReplyVO vo) {
		
		crm.update(vo);
		
	}

	@Override
	public void removeCMReply(int cno) {
		
		crm.delete(cno);
		
	}

}
