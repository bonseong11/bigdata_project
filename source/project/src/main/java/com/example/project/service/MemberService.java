package com.example.project.service;

import com.example.project.domain.Member;
import com.example.project.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MemberService {
    @Autowired
    MemberRepository memberRepository;

    public MemberService() {
    }

    public boolean loginService(String userid, String password) {
        return this.memberRepository.countByUseridAndPassword(userid, password) == 1;
    }

    public boolean signService(Member member) {
        try {
            this.memberRepository.save(member);
            return true;
        } catch (Exception var3) {
            return false;
        }
    }
}
