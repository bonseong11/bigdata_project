package com.kknadmin.www.member_management.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kknadmin.www.member_management.dto.MemberListDto;

public interface MemberListDtoManagementRepository extends JpaRepository<MemberListDto, String> {
}
