package com.example.project.repository;

import com.example.project.domain.HealthRecord;
import com.example.project.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HealthRecordRepository extends JpaRepository<HealthRecord, Integer> {




}
