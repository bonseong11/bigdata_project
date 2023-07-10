package com.example.project.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "member")
@Data
public class Member {
    @Id
    String userid;
    @Column(nullable = false)
    String nickname;
    @Column(nullable = false)
    String password;
    @Column(nullable = false)
    String email;
    @Column(nullable = false)
    int gender;
    @Column(nullable = false)
    double height;
    @Column(nullable = false)
    double weight;





}




