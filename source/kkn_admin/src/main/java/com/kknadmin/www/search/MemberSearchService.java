package com.kknadmin.www.search;

import com.kknadmin.www.entity.Member;
import com.kknadmin.www.member_management.MemberShowDto;
import com.kknadmin.www.repository.MemberManagementRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class MemberSearchService {
    @Autowired
    private MemberManagementRepository memberManagementRepository;

    public Page<MemberShowDto> findMemberByUserIdContaining(String userId, Pageable pageable) {
        Page<Member> members = memberManagementRepository.findByUseridContaining(userId, pageable);
        List<MemberShowDto> memberShowDtos = members.getContent().stream()
                .map(MemberShowDto::toMemberListDtoConvert)
                .collect(Collectors.toList());
        return new PageImpl<>(memberShowDtos, pageable, members.getTotalElements());
    }
}




