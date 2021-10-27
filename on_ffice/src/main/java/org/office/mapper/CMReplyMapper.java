package org.office.mapper;

import java.util.List;

import org.office.domain.CMReplyVO;

public interface CMReplyMapper {
	
	public List<CMReplyVO> getList(int community);
	
	public void create(CMReplyVO vo);
	
	public void update(CMReplyVO vo);
	
	public void delete(int cno);

}
