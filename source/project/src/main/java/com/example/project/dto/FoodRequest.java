package com.example.project.dto;

import lombok.Data;

@Data
public class FoodRequest {
    private Integer foodcode;
    private String foodname;
    private Integer servingsize;
    private Double calorie;
    private Double protein;
    private Double province;
    private Double carbohydrate;

    public FoodRequest() {
    }


}
