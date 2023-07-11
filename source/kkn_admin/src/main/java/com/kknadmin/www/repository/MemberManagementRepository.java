package com.kknadmin.www.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kknadmin.www.entity.Member;

public interface MemberManagementRepository extends JpaRepository<Member, String> {
}
