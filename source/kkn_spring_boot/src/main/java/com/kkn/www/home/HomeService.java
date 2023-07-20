package com.kkn.www.home;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kkn.www.entity.HealthRecord;
import com.kkn.www.entity.Member;
import com.kkn.www.repository.HealthRecordRepository;
import com.kkn.www.repository.MemberRepository;

@Service
@Transactional
public class HomeService {
	@Autowired
	HealthRecordRepository healthRecordRepository;
	
	@Autowired
	MemberRepository memberRepository;
	
	public HomeDto homeInformationLoadService(String userid) {
		List<HealthRecord> userHealthRecord = healthRecordRepository.findByMemberUseridAndHealthdateBetween(userid, LocalDate.now().toString(), LocalDate.now().plusDays(1).toString());
		
		if(userHealthRecord.size() == 1) {
			return userHealthRecord.stream().map(HomeDto::toHomeDtoConvert).collect(Collectors.toList()).get(0);
		} else {
			HealthRecord newHealthRecord = this.userTodayNewHealthRecordCreate(userid);
			
			return HomeDto.toHomeDtoConvert(newHealthRecord);
		}
	}
	
	private HealthRecord userTodayNewHealthRecordCreate(String userid) {
		HealthRecord newHealthRecord = new HealthRecord();
		
		newHealthRecord.setHealthdate(LocalDate.now().toString());
		newHealthRecord.setWaterintake(0);
		newHealthRecord.setSteps(0);
		
		Member user = memberRepository.findById(userid).get();
		newHealthRecord.setMember(user);
		newHealthRecord.setBmi(this.bmiCalulate(user.getHeight(), user.getWeight()));
		
		healthRecordRepository.save(newHealthRecord);
		
		return newHealthRecord;
	}
	
	private double bmiCalulate(double height, double weight) {
		return weight / (height * height * 0.0001);
	}
	
	public void homeInformationModifiyService(HomeDto homeDto) {
		HealthRecord userHealthRecord = healthRecordRepository.findByMemberUseridAndHealthdateBetween(homeDto.getUserid(), LocalDate.now().toString(), LocalDate.now().plusDays(1).toString()).get(0);
		
		userHealthRecord.setSteps(homeDto.getSteps());
		userHealthRecord.setWaterintake(homeDto.getWaterInTake());
		
		userHealthRecord.setHealthdate(LocalDate.parse(userHealthRecord.getHealthdate().split(" ")[0]).toString());
		
		healthRecordRepository.save(userHealthRecord);
	}
}