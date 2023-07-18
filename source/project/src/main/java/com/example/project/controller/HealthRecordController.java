package com.example.project.controller;

import com.example.project.domain.HealthRecord;
import com.example.project.domain.Member;
import com.example.project.dto.HealthRequest;
import com.example.project.service.HealthRecordService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/member")
public class HealthRecordController {

    private final HealthRecordService healthRecordService;

    public HealthRecordController(HealthRecordService healthRecordService) {
        this.healthRecordService = healthRecordService;
    }

//    @GetMapping("/healthform")
//    public String showHealthForm(Model model) {
//        model.addAttribute("healthRequest", new HealthRequest());
//        return "healthform";
//    }

    @PostMapping("/health")
    public String submitHealthRecord(@RequestBody HealthRequest healthRequest) {
        Member member = healthRequest.getMember();

        healthRecordService.saveHealthRecord(member, healthRequest.getDate(),
                healthRequest.getWaterIntake(), healthRequest.getBmi(), healthRequest.getSteps());

        return "success";
    }

}
