package org.office.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class CMReplyVO {
	
	private int cno;
	private int community;
	private String reply;
	private String replyer;
	
	private Date regdate;
	private Date updatedate;


}
