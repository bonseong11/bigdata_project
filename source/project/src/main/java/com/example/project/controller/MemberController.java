package com.example.project.controller;

import com.example.project.dto.SignUpRequest;
import com.example.project.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/member")
public class MemberController {

    private final MemberService memberService;
    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping("/home")
    public String showHome(Model model) {
        model.addAttribute("signupRequest", new SignUpRequest());
        return "home";
    }

    @PostMapping("/signup")
    public String signUp(@RequestBody SignUpRequest signupRequest) {
        memberService.signUp(signupRequest.getUserid(),signupRequest.getNickname(),
                signupRequest.getPassword(), signupRequest.getEmail(), signupRequest.getGender(),
                signupRequest.getHeight(), signupRequest.getWeight());

        return "success";
    }

}

