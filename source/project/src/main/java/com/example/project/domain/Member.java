package com.example.project.domain;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "member")
public class Member {

    @Id
    private String userid;
    private String nickname;
    private String password;
    private String email;
    private Integer gender;
    private Double height;
    private Double weight;


    public Member() {

    }


}




