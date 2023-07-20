package com.kkn.www.repository;

import com.kkn.www.entity.Camera;
import com.kkn.www.entity.HealthRecord;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CameraRepository extends JpaRepository<Camera, Integer> {

    List<Camera> findByMemberUseridAndCameradateBetween(String userid, String cameradate, String cameradateTomorrow);

}
