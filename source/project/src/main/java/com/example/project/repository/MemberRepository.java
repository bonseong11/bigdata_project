package com.example.project.repository;

import com.example.project.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MemberRepository extends JpaRepository<Member, String> {
// 엔티티, pk타입

    Optional<Member> findByUserid(String userid);
    Optional<Member> findByEmail(String email);



    List<Member> findAll();



}
