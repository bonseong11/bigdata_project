package com.kknadmin.www.member_management.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kknadmin.www.entity.Member;

public interface MemberManagementRepository extends JpaRepository<Member, String> {
}
