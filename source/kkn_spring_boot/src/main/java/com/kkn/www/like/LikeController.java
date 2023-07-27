package com.kkn.www.like;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kkn.www.like.dto.LikeLoadSendDto;
import com.kkn.www.like.dto.LikeSaveDeleteSendDto;

@RestController
@RequestMapping("/like")
public class LikeController {
	@Autowired
	LikeService likeService;
	
	@PostMapping("")
	public List<Boolean> likeCheckListLoad(@RequestBody LikeLoadSendDto likeLoadSendDto) {
		return likeService.likeCheckListLoadService(likeLoadSendDto);
	}
	
	@PostMapping("/create")
	public void likeCheckListSave(@RequestBody LikeSaveDeleteSendDto likeSaveDeleteSendDto) {
		likeService.likeCheckListSaveService(likeSaveDeleteSendDto);
	}
	
	@PostMapping("/delete")
	public void likeCheckListDelete(@RequestBody LikeSaveDeleteSendDto likeSaveDeleteSendDto) {
		likeService.likeCheckListDeleteService(likeSaveDeleteSendDto);
	}
}
