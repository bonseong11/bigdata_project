package com.kkn.www.mypage;

import com.kkn.www.entity.Member;
import com.kkn.www.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MypageService {
    @Autowired
    MemberRepository memberRepository;

    public void mypageService(Member member) {
        Member oldMember = memberRepository.findById(member.getUserid()).get();
        oldMember.setHeight(member.getHeight());
        oldMember.setWeight(member.getWeight());
        oldMember.setGender(member.getGender());
        memberRepository.save(oldMember);
    }
}
