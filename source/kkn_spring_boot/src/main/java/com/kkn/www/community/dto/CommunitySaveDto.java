package com.kkn.www.community.dto;

import com.kkn.www.entity.Community;
import com.kkn.www.entity.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommunitySaveDto {
	String userid;
	
	String title;
	String content;
	
	int likes;
	
	public static Community toCommunity(CommunitySaveDto communitySaveDto) {
		Community community = new Community();
		
		community.setTitle(communitySaveDto.getTitle());
		community.setContent(communitySaveDto.getContent());
		community.setLikes(communitySaveDto.getLikes());
		
		Member member = new Member();
		member.setUserid(communitySaveDto.getUserid());
		community.setMember(member);
		
		return community;
	}
}
