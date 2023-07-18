package com.example.project.dto;

import com.example.project.domain.Member;
import lombok.Data;

import java.time.LocalDate;

@Data
public class HealthRequest {

    private Member member;
    private LocalDate date;
    private Double waterIntake;
    private Double bmi;
    private Integer steps;

}