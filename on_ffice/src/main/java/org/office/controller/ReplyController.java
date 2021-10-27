package org.office.controller;


import java.util.List;

import org.office.domain.ReplyVO;
import org.office.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/notice/noticeDetail/replies")
@Log4j
public class ReplyController {

	@Autowired
	private ReplyService rs;
	
	@PostMapping(value="", consumes="application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> register(@RequestBody ReplyVO vo){
		ResponseEntity<String> entity = null;
		try {
			log.info("reply vo : " + vo );
			rs.addreply(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch (Exception e) {
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@GetMapping(value="/all/{notice}", produces = {MediaType.APPLICATION_XML_VALUE,
												MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ReplyVO>> list(@PathVariable("notice") int notice){
		ResponseEntity<List<ReplyVO>> entity = null;
		
		log.info("조회 글 번호 : " + notice);
		try {
			entity = new ResponseEntity<>(rs.listReply(notice), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
		
	}
	
	@DeleteMapping(value="/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") int rno){
		ResponseEntity<String> entity = null;
		
		try {
			rs.removeReply(rno);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		} catch (Exception e) {
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
					value="/{rno}",
					consumes = "application/json",
					produces = {MediaType.TEXT_PLAIN_VALUE}
			)
	public ResponseEntity<String> modify(
			@RequestBody ReplyVO vo, @PathVariable("rno") int rno){
		
		ResponseEntity<String> entity = null;
		try {
			vo.setRno(rno);
			rs.modifyReply(vo);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	
	
}
