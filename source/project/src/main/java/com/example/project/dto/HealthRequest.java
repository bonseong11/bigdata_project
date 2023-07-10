package com.example.project.dto;

import com.example.project.domain.Member;
import lombok.Data;

import java.time.LocalDate;

@Data
public class HealthRequest {

    private LocalDate healthdate;
    private Double waterintake;
    private Double bmi;
    private Integer steps;

}