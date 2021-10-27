package org.office.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class DpCommunityVO {
	
	int dc_num;
	int dp_code;
	int empno;
	String dtitle;
	String dcontent;
	String dwriter;
	Date ddate;
	Date dupdate;
	int dhits;

}
