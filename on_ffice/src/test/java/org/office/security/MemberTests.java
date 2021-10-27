package org.office.security;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j
public class MemberTests {

	@Autowired
	private PasswordEncoder pwen;
	@Autowired
	private DataSource ds;
	
	@Test
	public void testCryptDefaultDB() {
		String [] idList = {"shinwr7",
				"eastar93",
				"soyowp",
				"seonghynu9724",
				"test1",
				"test2",
				"test3",
				"test4",
				"test5"};
		String sql = "UPDATE USERS set upw=? WHERE uid=?";
		
		//test1 비밀번호는 test1
		try {
			Connection con = ds.getConnection();
			
			for(String id : idList) {
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1, pwen.encode("test"));
				pstmt.setString(2, id);
				pstmt.executeUpdate();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
