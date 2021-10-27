package org.office.socket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.log4j.Log4j;
@Log4j
@RequestMapping("/chat")
public class EchoHandler extends TextWebSocketHandler{
	
    //세션 리스트
    private List<WebSocketSession> users;
    
    private Map<String, Object> userMap;
    
    public EchoHandler() {
    	users = new ArrayList<WebSocketSession>();
    	userMap = new HashMap<String, Object>();
    }
    
    //클라이언트가 연결 되었을 때 실행
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	log.info("TextWebSocketHandler : 연결 생성!");
    	users.add(session);
    	log.info("발급된 소켓세션 : "+ session);
    	
    	}
    
    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	log.info("TextWebSocketHandler : 메시지 수신");
    	log.info("메시지 : " + message.getPayload());
    	JSONObject object = new JSONObject(message.getPayload());
    	String type = object.getString("type");
    	
    	if(type != null && type.equals("register")) {
    		String user = object.getString("userid");
    		
    		userMap.put(user, session);
    		log.info("매핑된 유저 : " + user);
    		
    	}else {
    		String target = object.getString("target");
    		WebSocketSession ws =(WebSocketSession)userMap.get(target);
    		String msg = object.getString("message");
    		if(ws != null) {
    			ws.sendMessage(new TextMessage(msg));
    		}
    	}
    }
    
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
    	log.info("TextWebSocketHandler : 연결 종료");
    	users.remove(session);
    }
    
//    private String getUserId(WebSocketSession session) {
//    	userMap = session.getAttributes();
//    	UserVO loginUser = (UserVO)userMap.get("login_session");
//    	
//    	if(loginUser == null) {
//    		return session.getId();
//    	} else {
//    		return loginUser.getUid();
//    	}
//    }

    //클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
//    @Override
//    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//    UserVO user = (UserVO)httpSession.get("login_session");
//	String senderName = null;
//	    	
//	    	if(user != null) {
//	    		senderName = user.getName();
//	    		
//	    	}else if(user == null) {
//	    		senderName = session.getId();
//	    	}
//        logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
//        //모든 유저에게 메세지 출력
//        for(WebSocketSession sess : sessionList){
//            sess.sendMessage(new TextMessage(message.getPayload()));
//        }
//    }
//    //클라이언트 연결을 끊었을 때 실행
//    @Override
//    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
//        sessionList.remove(session);
//        logger.info("{} 연결 끊김.", session.getId());
//    }
}

