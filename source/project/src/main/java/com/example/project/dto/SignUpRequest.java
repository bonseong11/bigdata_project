package com.example.project.dto;

import lombok.Data;

@Data
public class SignUpRequest {

    private String userid;
    private String nickname;
    private String password;
    private String email;
    private Integer gender;
    private Double height;
    private Double weight;

}

