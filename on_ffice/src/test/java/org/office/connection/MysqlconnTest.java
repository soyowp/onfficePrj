package org.office.connection;


import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.jupiter.api.Test;

import lombok.extern.log4j.Log4j;
/*
*	작성자 : 배용우
*	진행상황 : mysql 연결 end (ing/end로 구분) 
*	변수정리 : 
*	테스트 성공 유무 :  성공
*	오류사항 : 
*/

@Log4j
public class MysqlconnTest {
	//커넥터 설정 완료.
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@Test
	public void testConnection() {
		try {
			Connection con = 
					DriverManager.getConnection(
							"jdbc:mysql://127.0.0.1:3306/mysql?useSSL=false&serverTimezone=UTC",
							"root", 
							"mysql");
			log.info(con);
			log.info("MySQL연결 완료");
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}
}
