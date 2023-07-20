package com.kkn.www.entity;

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
    private Double amount;
    private Double calorie;
    private Double protein;
    private Double fat;
    private Double carbohydrates;

    public Food() {

    }

}
