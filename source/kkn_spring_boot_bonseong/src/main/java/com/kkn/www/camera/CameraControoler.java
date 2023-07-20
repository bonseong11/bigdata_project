package com.kkn.www.camera;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/camera")
public class CameraControoler {
    @Autowired
    CameraService cameraService;

    @PostMapping("/create")
    public void cameraCreate(@RequestBody CameraDto cameraDto) {
        cameraService.cameraService(cameraDto);
    }
}
