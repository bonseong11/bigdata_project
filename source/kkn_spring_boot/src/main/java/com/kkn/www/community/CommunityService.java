package com.kkn.www.community;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkn.www.comment.dto.CommentsLoadDto;
import com.kkn.www.community.dto.CommunityLoadDto;
import com.kkn.www.community.dto.CommunitySaveDto;
import com.kkn.www.entity.Community;
import com.kkn.www.repository.CommentsRepository;
import com.kkn.www.repository.CommunityRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class CommunityService {
	@Autowired
	CommunityRepository communityRepository;
	
	@Autowired
	CommentsRepository commentRepository;
	
	public List<CommunityLoadDto> communityHomeInformationLoadService(String loadTimestamp) {
		List<Community> communityList = communityRepository.findTop10ByWritedatetimeLessThanEqualOrderByWritedatetimeDesc(Timestamp.valueOf(loadTimestamp));
		
		return this.commentsLoad(communityList.stream().map(CommunityLoadDto::toCommunityHomeDto).collect(Collectors.toList()));
	}
	
	private List<CommunityLoadDto> commentsLoad(List<CommunityLoadDto> postList) {
		for(CommunityLoadDto post : postList) {			
			post.setCommentslist(commentRepository.findTop2ByPostNumOrderByCommentwritetimestampDesc(post.getNum()).stream().map(CommentsLoadDto::toCommentsDto).collect(Collectors.toList()));
		}
		
		return postList;
	}
	
	public List<CommunityLoadDto> communityListAddService(String lastPostWriteTimeStamp) {
		List<Community> communityList = communityRepository.findTop10ByWritedatetimeLessThanOrderByWritedatetimeDesc(Timestamp.valueOf(lastPostWriteTimeStamp));
		
		return this.commentsLoad(communityList.stream().map(CommunityLoadDto::toCommunityHomeDto).collect(Collectors.toList()));
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
