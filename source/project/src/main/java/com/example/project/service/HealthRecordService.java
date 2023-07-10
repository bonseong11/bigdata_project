package com.example.project.service;

import com.example.project.domain.HealthRecord;
import com.example.project.repository.HealthRecordRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HealthRecordService {

    private final HealthRecordRepository healthRecordRepository;

    @Autowired
    public HealthRecordService(HealthRecordRepository healthRecordRepository) {
        this.healthRecordRepository = healthRecordRepository;
    }

    public List<HealthRecord> getHealthRecordsByMemberId(String userid) {
        return healthRecordRepository.findByMemberUserid(userid);
    }
}



