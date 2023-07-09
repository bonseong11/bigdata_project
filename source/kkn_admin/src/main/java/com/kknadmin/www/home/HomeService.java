package com.kknadmin.www.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kknadmin.www.entity.Admin;

@Service
public class HomeService {
	@Autowired
	HomeRepository homeRepository;
	
	public String getNameService(String id) {
		Admin admin = homeRepository.findById(id).get();
		
		return admin.getName();
	}
}
