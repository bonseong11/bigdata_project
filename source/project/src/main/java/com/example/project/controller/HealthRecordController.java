package com.example.project.controller;


import com.example.project.domain.HealthRecord;
import com.example.project.domain.Member;
import com.example.project.repository.HealthRecordRepository;
import com.example.project.service.HealthRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/health")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class HealthRecordController {
    private final HealthRecordService healthRecordService;

    @Autowired
    public HealthRecordController(HealthRecordService healthRecordService) {
        this.healthRecordService = healthRecordService;
    }

    @GetMapping("/member/{userid}")
    public List<HealthRecord> getHealthRecordsByMemberId(@PathVariable String userid) {
        List<HealthRecord> healthRecords = healthRecordService.getHealthRecordsByMemberId(userid);
        return healthRecords;
    }
}





