package com.kkn.www.community;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kkn.www.community.dto.CommunityLoadDto;
import com.kkn.www.community.dto.CommunitySaveDto;

@RestController
@RequestMapping("/community")
public class CommunityController {
	@Autowired
	CommunityService communityService;
	
	@PostMapping("")
	public List<CommunityLoadDto> communityHomeInformationLoad(@RequestBody String loadTimestamp) {
		return communityService.communityHomeInformationLoadService(loadTimestamp);
	}
	
	@PostMapping("/create")
	public void postSave(@RequestBody CommunitySaveDto communitySaveDto) {
		communityService.postSaveService(communitySaveDto);
	}
	
	@PostMapping("/delete")
	public void postDelete(@RequestBody int postNum) {
		communityService.postDeleteService(postNum);
	}
}
