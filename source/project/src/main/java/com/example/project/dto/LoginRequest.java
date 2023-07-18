package com.example.project.dto;


import lombok.Data;

@Data
public class LoginRequest {
    private String userid;
    private String password;

    public LoginRequest() {
    }
}
