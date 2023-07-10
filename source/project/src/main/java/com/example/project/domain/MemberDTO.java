package com.example.project.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;


@Entity
@Table(name = "member")
@Data
public class MemberDTO {

    @Id
    String userid;
    String nickname;
    int gender;
    double height;
    double weight;

    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<HealthRecord> healthRecords = new ArrayList<>();

}

