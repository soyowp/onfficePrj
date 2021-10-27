package org.office.controller;

import java.util.List;

import org.office.domain.DpCReplyVO;
import org.office.service.DpCReplyService;
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
@RequestMapping("/dpcommunity/dpcdetail/dpcreplies")
@Log4j
public class DpCReplyController {
	
	@Autowired
	private DpCReplyService DpCrservice;
	
	@PostMapping(value="", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> register(@RequestBody DpCReplyVO vo) {
		
		ResponseEntity<String> entity = null;
		try {
			log.info("reply vo : " + vo);
			DpCrservice.addDpCreply(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@GetMapping(value="/all/{dp_community}", produces = {MediaType.APPLICATION_ATOM_XML_VALUE,
													MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<DpCReplyVO>> list(@PathVariable("dp_community") int dp_community) {
				ResponseEntity<List<DpCReplyVO>> entity = null;
					
			log.info("조회 글 번호 : " + dp_community);	
			try {
				entity = new ResponseEntity<>(DpCrservice.listDpCReply(dp_community), HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}		
		
			return entity;
	}
	
	@DeleteMapping(value="/{dno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("dno") int dno) {
		ResponseEntity<String> entity = null;
		try {
			DpCrservice.removeDpCReply(dno);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
			value="/{dno}",
			consumes = "application/json",
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(
			@RequestBody DpCReplyVO vo, @PathVariable("dno") int dno) {
		
		ResponseEntity<String> entity = null;
		try  {
			vo.setDno(dno);
			DpCrservice.modifyDpCReply(vo);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
