package com.kkn.www.community.dto;

import com.kkn.www.entity.Community;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommunityLoadDto {
	int num;
	String userid;
	String nickname;
	
	String title;
	String content;
	int likes;
	
	public static CommunityLoadDto toCommunityHomeDto(Community community) {
		return new CommunityLoadDto(
				community.getNum(),
				community.getMember().getUserid(),
				community.getMember().getNickname(),
				community.getTitle(),
				community.getContent(),
				community.getLikes());
	}
}
