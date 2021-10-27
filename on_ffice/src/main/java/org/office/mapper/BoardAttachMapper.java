package org.office.mapper;

import java.util.List;

import org.office.domain.BoardAttachVO;

public interface BoardAttachMapper {
	
	
	public void insert(BoardAttachVO vo);
	
	public void delete(BoardAttachVO vo);
	
	public List<BoardAttachVO> findByNotice_num(int notice_num);
	
	public void deleteAll (int notice_num);
	
}
