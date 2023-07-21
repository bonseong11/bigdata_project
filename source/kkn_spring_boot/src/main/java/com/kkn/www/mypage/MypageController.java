package com.kkn.www.mypage;

import com.kkn.www.entity.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MypageController {
    @Autowired
    MypageService mypageService;

    @PostMapping("/update")
    public boolean mypageController(@RequestBody Member member){
        mypageService.mypageService(member);
        return true;

    }
}
