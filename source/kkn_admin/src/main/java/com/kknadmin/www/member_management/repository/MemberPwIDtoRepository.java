package com.kknadmin.www.member_management.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kknadmin.www.member_management.dto.MemberPwIDto;

public interface MemberPwIDtoRepository extends JpaRepository<MemberPwIDto, String>{
}