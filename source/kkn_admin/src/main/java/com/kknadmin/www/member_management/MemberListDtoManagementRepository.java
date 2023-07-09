package com.kknadmin.www.member_management;

import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberListDtoManagementRepository extends JpaRepository<MemberListDto, String> {
}
