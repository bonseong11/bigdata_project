package com.kknadmin.www.search;

import com.kknadmin.www.entity.Member;
import com.kknadmin.www.member_management.MemberShowDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Controller
@RequestMapping("/member")
public class MemberSearchController {
    @Autowired
    private MemberSearchService memberSearchService;

    @GetMapping("/search")
    public String searchMemberByUserId(@RequestParam String userId, Pageable pageable, Model model) {
        Page<MemberShowDto> pages = memberSearchService.findMemberByUserIdContaining(userId, pageable);

        model.addAttribute("pages", pages);
        model.addAttribute("memberslist", pages.getContent());

        return "member_management/member_list";
    }
}
