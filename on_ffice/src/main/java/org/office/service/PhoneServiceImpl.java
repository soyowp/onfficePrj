package org.office.service;

import java.util.HashMap;

import org.json.simple.JSONObject;
import org.office.domain.PhoneDTO;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Log4j
@Service
@AllArgsConstructor
public class PhoneServiceImpl implements PhoneService{
	
	@Override
	public void sendSMS(PhoneDTO dto) {
			
			log.info("문자 전송 서비스 실행");
			
			String api_key = "NCSCAOQEUA8V1LWS";
		    String api_secret = "ZDFVIKYMXGG3FW2A8QK9LVL2HVGZYQDT";
		    Message coolsms = new Message(api_key, api_secret);
		    
		    HashMap<String, String> params = new HashMap<String, String>();
		    params.put("to", dto.getTo());
		    params.put("from", "01041008149");
		    params.put("type", "SMS");
		    params.put("text", dto.getText());
		    params.put("app_version", "test app 1.2"); // application name and version

		    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		      System.out.println(obj.toString());
		    } catch (CoolsmsException e) {
		      System.out.println(e.getMessage());
		      System.out.println(e.getCode());
		    }
		  }
		
	}

