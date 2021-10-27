package org.office.mapper;

import java.util.List;

import org.office.domain.DpCReplyVO;

public interface DpCReplyMapper {
	
	public List<DpCReplyVO> getList(int dp_community);
	
	public void create(DpCReplyVO vo);
	
	public void update(DpCReplyVO vo);
	
	public void delete(int dno);

}
