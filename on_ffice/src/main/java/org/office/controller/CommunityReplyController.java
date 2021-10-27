package org.office.controller;

import java.util.List;

import org.office.domain.CMReplyVO;
import org.office.domain.CommunityVO;
import org.office.domain.Criteria;
import org.office.service.CMReplyService;
import org.office.service.CommunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/community/CMDetail/cmreplies")
@Log4j
public class CommunityReplyController {
	
	@Autowired
	private CMReplyService CMRservice;
	
	@Autowired
	private CommunityService cs;
	
	@PostMapping(value="", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> register(@RequestBody CMReplyVO vo, Criteria cri) {
		
		ResponseEntity<String> entity = null;
		try {
			log.info("reply vo : " + vo);
			CMRservice.addCMreply(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@GetMapping(value="/all/{community}", produces = {MediaType.APPLICATION_ATOM_XML_VALUE,
												MediaType.APPLICATION_JSON_UTF8_VALUE})
		public ResponseEntity<List<CMReplyVO>> list(@PathVariable("community") int community) {
		ResponseEntity<List<CMReplyVO>> entity = null;
		
		log.info("조회 글 번호 : " + community);	
		try {
		entity = new ResponseEntity<>(CMRservice.listCMReply(community), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}		
		
		return entity;
	}
	
	@DeleteMapping(value="/{cno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("cno") int cno) {
		ResponseEntity<String> entity = null;
		try {
			CMRservice.removeCMReply(cno);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
			value="/{cno}",
			consumes = "application/json",
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(
			@RequestBody CMReplyVO vo, @PathVariable("cno") int cno) {
		
		ResponseEntity<String> entity = null;
		try  {
			vo.setCno(cno);
			CMRservice.modifyCMReply(vo);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
