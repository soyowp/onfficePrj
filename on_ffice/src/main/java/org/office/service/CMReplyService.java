package org.office.service;

import java.util.List;

import org.office.domain.CMReplyVO;

public interface CMReplyService {
	
	public void addCMreply(CMReplyVO vo);
	
	public List<CMReplyVO> listCMReply(int community);
	
	public void modifyCMReply(CMReplyVO vo);
	
	public void removeCMReply(int cno);

}
