package com.kknadmin.www.member_management.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kknadmin.www.member_management.MemberManagementService;
import com.kknadmin.www.member_management.MemberShowDto;

@Controller
@RequestMapping("/member")
public class MemberManagementController {
	@Autowired
	private MemberManagementService memberManagementService;
	
	@GetMapping("")
	public String allMemberPrintProcess(Model model, Pageable pageable) {
		Page<MemberShowDto> pages = memberManagementService.membersListSearch(pageable);
		
		model.addAttribute("pages", pages);
		model.addAttribute("memberslist", pages.getContent());
		
		return "member_management/member_list";
	}
}
