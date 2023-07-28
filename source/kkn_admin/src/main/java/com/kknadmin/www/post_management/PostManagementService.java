package com.kknadmin.www.post_management;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.kknadmin.www.entity.Community;
import com.kknadmin.www.repository.PostManagementRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class PostManagementService {
	@Autowired
	private PostManagementRepository postManagementRepository;
	
	public Page<PostShowDto> postListSearch(Pageable pageable) {
		return this.toPostShowDtoPageConvert(postManagementRepository.findAll(pageable), pageable);
	}
	
	private PageImpl<PostShowDto> toPostShowDtoPageConvert(Page<Community> allMemberPage, Pageable pageable) {		
		return new PageImpl<PostShowDto>(allMemberPage.getContent().stream().map(PostShowDto::toPostShowDto).collect(Collectors.toList()), pageable, allMemberPage.getTotalElements());
	}
	
	/*public void pwInitialization(String userid) {
		Member member = memberRepository.findById(userid).get();
		
		member.setPassword(userid);
		
		memberRepository.save(member);
	}
	
	public void memberDelete(String userid) {
		memberRepository.deleteById(userid);
	}*/
	
	public Page<PostShowDto> searchService(String category, String searchInput, Pageable pageable) {
        Page<Community> posts = this.selectedMembersLoad(category, searchInput, pageable);
        
        List<PostShowDto> postShowDtos = posts.getContent().stream()
                .map(PostShowDto::toPostShowDto)
                .collect(Collectors.toList());
        
        return new PageImpl<>(postShowDtos, pageable, posts.getTotalElements());
    }
	
	private Page<Community> selectedMembersLoad(String category, String searchInput, Pageable pageable) {
		switch(category) {
			case "userId":
				return postManagementRepository.findByMemberUseridContaining(searchInput, pageable);
	        default:
	            return postManagementRepository.findByTitleContaining(searchInput, pageable);
		}
	}
}
