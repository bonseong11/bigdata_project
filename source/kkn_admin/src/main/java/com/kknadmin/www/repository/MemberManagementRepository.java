package com.kknadmin.www.repository;

import com.kknadmin.www.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import java.util.List;

public interface MemberManagementRepository extends JpaRepository<Member, String> {
    Page<Member> findByUseridContaining(String userid, Pageable pageable);
}

