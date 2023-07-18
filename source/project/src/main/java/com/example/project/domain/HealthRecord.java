package com.example.project.domain;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;

@Entity
@Data
@Table(name = "healthrecord")
public class HealthRecord {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long num;

    @ManyToOne
    @JoinColumn(name = "userid")
    private Member member;


    private LocalDate date;
    private Double waterIntake;
    private Double bmi;
    private Integer steps;

    public HealthRecord() {

    }

    public HealthRecord(Member member, LocalDate date, Double waterIntake, Double bmi, Integer steps) {
        this.member = member;
        this.date = date;
        this.waterIntake = waterIntake;
        this.bmi = bmi;
        this.steps = steps;

    }


}
