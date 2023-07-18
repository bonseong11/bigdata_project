package com.example.project.service;

import com.example.project.domain.Member;
import com.example.project.repository.MemberRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class MemberService {
    private final MemberRepository memberRepository;

    public MemberService(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    public void signUp(String userid, String nickname, String password, String email, Integer gender, Double height, Double weight) {
        Member member = new Member();
        member.setUserid(userid);
        member.setNickname(nickname);
        member.setPassword(password);
        member.setEmail(email);
        member.setGender(gender);
        member.setHeight(height);
        member.setWeight(weight);

        memberRepository.save(member);
    }

    public boolean login(String userid, String password) {
        Optional<Member> memberOptional = memberRepository.findByUserid(userid);
        if (memberOptional.isPresent()) {
            Member member = memberOptional.get();
            if (member.getPassword().equals(password)) {
                return true;
            }
        }
        return false;
    }
}
