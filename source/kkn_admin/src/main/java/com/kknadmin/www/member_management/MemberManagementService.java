package com.kknadmin.www.member_management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MemberManagementService {
	@Autowired
	private MemberManagementRepository memberRepository;
	
	@Autowired
	private MemberListDtoManagementRepository memberListDtoRepository;
	
	@Autowired
	private MemberPwIRepository memberPwIRepository;
	
	public Page<MemberListDto> membersListSearch(Pageable pageable) {
		return memberListDtoRepository.findAll(pageable);
	}
	
	public void pwInitialization(String userid) {
		MemberPwIDto member = new MemberPwIDto();
		
		member.setUserid(userid);
		member.setPassword(userid);
		
		memberPwIRepository.save(member);
	}
	
	public void memberDelete(String userid) {
		memberRepository.deleteById(userid);
	}
}
