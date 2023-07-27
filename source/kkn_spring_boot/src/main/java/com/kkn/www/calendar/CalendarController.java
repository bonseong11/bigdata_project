package com.kkn.www.calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kkn.www.calendar.dto.CalendarDayInformationLoadInputDto;
import com.kkn.www.calendar.dto.CalendarDto;

@RestController
@RequestMapping("/calendar")
public class CalendarController {
	@Autowired
	CalendarService calendarService;
	
    @PostMapping("/dayload")
    public CalendarDto dayInformationLoad(@RequestBody CalendarDayInformationLoadInputDto selectedDayInput) {    	
        return calendarService.dayInformationLoadService(selectedDayInput);
    }
}
