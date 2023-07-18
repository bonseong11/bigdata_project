package com.example.project.controller;

import com.example.project.dto.LoginRequest;
import com.example.project.service.MemberService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/member")
public class LoginController {
    private final MemberService memberService;

    public LoginController(MemberService memberService) {
        this.memberService = memberService;
    }

    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody LoginRequest loginRequest) {
        boolean loginSuccessful = memberService.login(loginRequest.getUserid(), loginRequest.getPassword());

        if (loginSuccessful) {
            return ResponseEntity.ok("로그인에 성공하였습니다.");
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인에 실패하였습니다.");
        }
    }
}