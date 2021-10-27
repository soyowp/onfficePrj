package org.office.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class DpCReplyVO {

		private int dno;
		private int dp_community;
		private String reply;
		private String replyer;
		
		private Date regdate;
		private Date updatedate;
	
}
