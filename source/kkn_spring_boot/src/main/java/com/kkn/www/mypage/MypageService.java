package com.kkn.www.mypage;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkn.www.entity.HealthRecord;
import com.kkn.www.entity.Member;
import com.kkn.www.repository.HealthRecordRepository;
import com.kkn.www.repository.MemberRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class MypageService {
    @Autowired
    MemberRepository memberRepository;
    
    @Autowired
    HealthRecordRepository healthRecordRepository;
    
    public MyPageDto mypageInformationLoadService(String userid) {
    	return MyPageDto.toMyPageDto(memberRepository.findById(userid).get());
    }
    
    public void mypageUpdateService(Member member) {
    	memberUpdate(member);
    	
    	memberBmiUpdate(member);
    }
    
    private void memberUpdate(Member member) {
    	Member oldMember = memberRepository.findById(member.getUserid()).get();
    	
    	if(member.getPassword() != null) {
    		oldMember.setPassword(member.getPassword());
    	}
        
    	oldMember.setNickname(member.getNickname());
    	oldMember.setEmail(member.getEmail());
    	oldMember.setGender(member.getGender());
    	oldMember.setHeight(member.getHeight());
        oldMember.setWeight(member.getWeight());
        oldMember.setAge(member.getAge());
        
        memberRepository.save(oldMember);
    }
    
    private void memberBmiUpdate(Member member) {
    	HealthRecord oldMemberHealthRecord = healthRecordRepository.findByMemberUseridAndHealthdateBetween(member.getUserid(), LocalDate.now().toString(), LocalDate.now().plusDays(1).toString()).get(0);
    	
    	oldMemberHealthRecord.setBmi(this.bmiCalulate(member.getHeight(), member.getWeight()));
    	
    	oldMemberHealthRecord.setHealthdate(LocalDate.parse(oldMemberHealthRecord.getHealthdate().split(" ")[0]).toString());
    	healthRecordRepository.save(oldMemberHealthRecord);
    }
    
    private double bmiCalulate(double height, double weight) {
		return weight / (height * height * 0.0001);
	}
}
