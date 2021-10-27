package org.office.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private int rno;
	private int notice;
	private String reply;
	private String replyer;
	
	private Date regdate;
	private Date updatedate;
}
