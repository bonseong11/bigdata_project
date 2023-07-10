package com.example.project.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Data;
import org.springframework.data.annotation.CreatedDate;

import java.time.LocalDate;

@Entity
@Table(name = "healthrecord")
@Data
public class HealthRecord {

    @Id
    @Column(name = "num", nullable = false)
    private Long num;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userid")
    @JsonIgnoreProperties({"hibernateLazyInitializer"})
    private MemberDTO member;


    @Column(name = "healthdate")
    private LocalDate healthDate;

    @Column(name = "waterintake")
    private Double waterIntake;

    @Column(name = "bmi")
    private Double bmi;

    @Column(name = "steps")
    private Integer steps;
}
