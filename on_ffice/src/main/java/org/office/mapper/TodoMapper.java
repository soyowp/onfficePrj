/*
*	작성자 : 고광훈
*	진행상황 : src/main/java 패키지 생성, office페이지 컨트롤러, Mapper, Service, VO 생성 
*	변수정리 : 
*	테스트 성공 유무 :  
*	오류사항 : 
*	etc...
*	
*/

package org.office.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.office.domain.MenuVO;
import org.office.domain.TodoCri;
import org.office.domain.TodoVO;
import org.office.domain.UserVO;

@Mapper
public interface TodoMapper {

	public UserVO getInfo(String uid);

	public MenuVO getMeal(String dailymeal); 
	
	public List<TodoVO> getTodoList(TodoCri cri);
	
	public List<TodoVO> getCreatedTodo(TodoCri cri);
	
	public List<TodoVO> getTodoComplete(TodoCri cri);

	public void insertTodo(TodoVO vo);
	
	public void passTodo(TodoVO vo);
	
	public TodoVO getTodo(int todo_num);

	public void statTodo(TodoVO vo);
	
	public int todoCnt();
	
}
