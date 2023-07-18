package com.example.project.service;

import com.example.project.domain.HealthRecord;
import com.example.project.domain.Member;
import com.example.project.repository.HealthRecordRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service
public class HealthRecordService {

    private final HealthRecordRepository healthRecordRepository;

    public HealthRecordService(HealthRecordRepository healthRecordRepository) {
        this.healthRecordRepository = healthRecordRepository;
    }

    public void saveHealthRecord(Member member, LocalDate date, Double waterIntake, Double bmi, Integer steps) {
        HealthRecord healthRecord = new HealthRecord();
        healthRecord.setMember(member);
        healthRecord.setDate(date);
        healthRecord.setWaterIntake(waterIntake);
        healthRecord.setBmi(bmi);
        healthRecord.setSteps(steps);

        healthRecordRepository.save(healthRecord);
    }


}
