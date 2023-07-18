package com.example.project.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "food")
public class Food {

    @Id
    private Integer foodcode;
    private String foodname;
    private Integer servingsize;
    private Double calorie;
    private Double protein;
    private Double province;
    private Double carbohydrate;

    public Food() {
    }

}
