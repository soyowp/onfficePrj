package org.office.service;

import java.util.List;

import org.office.domain.ReplyVO;
import org.office.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{

	@Autowired
	ReplyMapper rm;
	
	@Override
	public void addreply(ReplyVO vo) {
		rm.create(vo);
		
	}

	@Override
	public List<ReplyVO> listReply(int notice) {
		return rm.getList(notice);
		
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		rm.update(vo);
	}

	@Override
	public void removeReply(int rno) {

		rm.delete(rno);
	}

}
