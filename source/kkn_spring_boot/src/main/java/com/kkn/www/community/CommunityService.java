package com.kkn.www.community;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkn.www.community.dto.CommunityLoadDto;
import com.kkn.www.community.dto.CommunitySaveDto;
import com.kkn.www.entity.Community;
import com.kkn.www.repository.CommunityRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class CommunityService {
	@Autowired
	CommunityRepository communityRepository;
	
	public List<CommunityLoadDto> communityHomeInformationLoadService(String loadTimestamp) {
		System.out.println(Timestamp.valueOf(loadTimestamp));
		List<Community> communityList = communityRepository.findTop10ByWritedatetimeLessThanEqualOrderByWritedatetimeDesc(Timestamp.valueOf(loadTimestamp));
		
		return communityList.stream().map(CommunityLoadDto::toCommunityHomeDto).collect(Collectors.toList());
	}
	
	public void postSaveService(CommunitySaveDto communitySaveDto) {
		Community newPost = CommunitySaveDto.toCommunity(communitySaveDto);
		
		newPost.setWritedatetime(Timestamp.valueOf(LocalDateTime.now()));
		
		communityRepository.save(newPost);
	}
	
	public void postDeleteService(int postNum) {
		communityRepository.deleteById(postNum);
	}
}
