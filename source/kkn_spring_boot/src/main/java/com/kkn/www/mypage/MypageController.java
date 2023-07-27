package com.kkn.www.mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kkn.www.entity.Member;

@RestController
@RequestMapping("/mypage")
public class MypageController {
    @Autowired
    MypageService mypageService;
    
    @PostMapping("/load")
    public MyPageDto myPageInformationLoad(@RequestBody String userid) {
    	return mypageService.mypageInformationLoadService(userid);
    }

    @PostMapping("/update")
    public void mypageUpdate(@RequestBody Member member) {
        mypageService.mypageUpdateService(member);
    }
}
