package org.office.service;


import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.office.domain.EmailDTO;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class EmailServiceIml implements EmailService{
	
	JavaMailSender mailSender;	// root-context에 설정한 bean, 의존성 주입
	
	@Override
	public void sendMail(EmailDTO dto) {
		try {
			// 이메일 객체 생성
			MimeMessage msg = mailSender.createMimeMessage();
			
			// 받는 사람 설정 (수신자, 받는사람의 이메일 주소 객체를 생성해서 수신자 이메일주소를 담음)
			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiveMail()));
			
			/*
			 * createMimeMessage() : MimeMessage 객체를 생성시킴 (이를 이용해 메시지를 구성한 뒤 메일 발송)
			 * addRecipient() : 메시지의 발신자를 설정 
			 * InternetAddress() : 이메일주소 
			 * getReceiveMail() : 수신자 이메일 주소
			 */
			
			// 보내는 사람(이메일주소 + 이름)
			// (발신자, 보내는 사람의 이메일 주소와 이름을 담음)
			// 이메일 발신자
			
			// addFrom함수의 파라미터는 배열 형식만 들어올 수 있음!
			msg.addFrom(new InternetAddress[] { new InternetAddress(dto.getSenderMail(), dto.getSenderName()) });
			
			// 이메일 제목 (인코딩 해야 한글 안깨짐)
			msg.setSubject(dto.getSubject());
			// 이메일 본문 (마찬가지로 인코딩 필요)
			msg.setContent(dto.getMessage(), "text/html");
			
			// 이메일 보내기
			mailSender.send(msg);
		} catch(Exception e) {
			e.printStackTrace();
		}
	} 
	
}
