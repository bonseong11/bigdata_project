package com.kknadmin.www;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@SpringBootApplication
public class KknAdminApplication {
	
	public static void main(String[] args) {
		BCryptPasswordEncoder bps = new BCryptPasswordEncoder();
		
		System.out.println(bps.encode("dbsgh123"));
		SpringApplication.run(KknAdminApplication.class, args);
	}

}
