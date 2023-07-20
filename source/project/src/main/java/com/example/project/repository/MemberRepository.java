package com.example.project.repository;


import com.example.project.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRepository extends JpaRepository<Member, String> {
    int countByUseridAndPassword(String userid, String password);
}

