package org.office.service;

import java.util.List;

import org.office.domain.UserVO;
import org.springframework.stereotype.Service;

@Service
public interface BirthService {
	public List<UserVO> getBirth();
}
