package com.kknadmin.www.post_management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("post")
public class PostManagementController {
	@Autowired
	PostManagementService postManagementService;
		
	@GetMapping("")
	public String allMemberPrintProcess(Model model, Pageable pageable) {
		Page<PostShowDto> pages = postManagementService.postListSearch(pageable);
		
		model.addAttribute("pages", pages);
		model.addAttribute("postlist", pages.getContent());
		
		return "post_list";
	}
	
	@GetMapping("/search")
    public String searchMember(@RequestParam("category") String category, @RequestParam("searchinput") String searchInput, Pageable pageable, Model model) {
        Page<PostShowDto> pages = postManagementService.searchService(category, searchInput, pageable);
        
        model.addAttribute("category", category);
        model.addAttribute("searchInput", searchInput);
        model.addAttribute("pages", pages);
        model.addAttribute("postlist", pages.getContent());

        return "post_list";
    }
}
