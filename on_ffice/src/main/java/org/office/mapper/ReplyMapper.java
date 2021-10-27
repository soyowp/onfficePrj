package org.office.mapper;

import java.util.List;

import org.office.domain.ReplyVO;

public interface ReplyMapper {
	
	public List<ReplyVO> getList(int notice);
	
	public void create (ReplyVO vo);
	
	public void update (ReplyVO vo);
	
	public void delete (int rno);
}
