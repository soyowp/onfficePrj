package org.office.domain;

import java.util.Date;

import lombok.Data;

@Data
public class TodoVO {

	public int todo_num;
	public int worker;
	public int checker;	
	public String todo_title;
	public String todo_content;
	public String complete;
	public Date recive_time;
	public Date complete_time;
}
