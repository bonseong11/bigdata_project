package com.kknadmin.www.member_management;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="member")
@Data
public class MemberPwIDto {
	@Id
	private String userid;
	
	@Column(nullable = false)
	private String password;
}
