package com.example.project.controller;

import com.example.project.domain.Member;
import com.example.project.dto.SignUpRequest;
import com.example.project.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/member")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class MemberController {
    @Autowired
    MemberService memberService;

    public MemberController() {
    }

    @PostMapping({"/login"})
    public boolean login(@RequestBody Member member) {
        return this.memberService.loginService(member.getUserid(), member.getPassword());
    }

    @PostMapping({"/signup"})
    public boolean signup(@RequestBody Member member) {
        return this.memberService.signService(member);
    }
}


