package org.office.service;

import java.util.List;

import org.office.domain.ReplyVO;

public interface ReplyService {

	public void addreply(ReplyVO vo);
	
	public List<ReplyVO> listReply(int notice);
	
	public void modifyReply(ReplyVO vo);
	
	public void removeReply(int rno);
}
