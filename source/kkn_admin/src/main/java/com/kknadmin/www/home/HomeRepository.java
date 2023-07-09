package com.kknadmin.www.home;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kknadmin.www.entity.Admin;

public interface HomeRepository extends JpaRepository<Admin, String>{
}
