import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import 'package:kkn/calendar/dto/calendar_dto.dart';
import 'package:kkn/calendar/dto/calendar_response_dto.dart';
import 'package:kkn/calendar/dto/calendar_send_dto.dart';
import 'package:kkn/calendar/calendar_controller.dart';
import 'package:kkn/home/dto/home_dto.dart';
import 'package:kkn/calendar/calendar_chart.dart';
import 'package:kkn/home/home_view.dart';
import 'package:kkn/drawer/drawer.dart';
import 'package:kkn/calendar/record.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key, required this.homeDto}) : super(key: key);

  final HomeDto homeDto;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarDto selectedDayCalendarDto = CalendarDto("", "", "", "");

  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();

  void daySelectProcess(DateTime selectedDay) async {
    CalendarController calendarController = CalendarController();

    CalendarResponseDto selectedDayCalendarResponseDto =
        await calendarController.selectedDayInformationLoad(CalendarSendDto(
            widget.homeDto.userid, selectedDay.toString().split(" ")[0]));

    if (selectedDayCalendarResponseDto.errorMessage.isEmpty) {
      selectedDayCalendarDto = selectedDayCalendarResponseDto.calendarDto!;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    selectedDayCalendarDto = CalendarDto(
        widget.homeDto.consumeCalories,
        widget.homeDto.steps,
        widget.homeDto.waterInTake,
        widget.homeDto.distance);
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy년 MM월 dd일').format(_selectedDay);

    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: AppBar(
        title: const Text('건강 기록'),
        backgroundColor: const Color(0xFF181818),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeView(homeDto: widget.homeDto)),
              );
            },
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: AppDrawer(homeDto: widget.homeDto),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TableCalendar<DateTime>(
            calendarFormat: _calendarFormat,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(DateTime.now().year + 2, 12, 31),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day); // 선택된 날짜인지 확인
            },
            onDaySelected: (selectedDay, focusedDay) {
              _selectedDay = selectedDay;

              daySelectProcess(selectedDay);
            },
            calendarStyle: const CalendarStyle(
              defaultTextStyle: TextStyle(color: Colors.white), // 기본 텍스트 스타일
              selectedTextStyle:
                  TextStyle(color: Colors.white), // 선택된 날짜의 텍스트 스타일
              todayTextStyle: TextStyle(color: Colors.white), // 오늘 날짜의 텍스트 스타일
            ),
            headerStyle: HeaderStyle(
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              formatButtonDecoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              formatButtonTextStyle: const TextStyle(color: Colors.white),
              leftChevronIcon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white, // 왼쪽 화살표 아이콘의 색상
              ),
              rightChevronIcon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white, // 오른쪽 화살표 아이콘의 색상
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 40),
              Text(
                formattedDate,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 120),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Chart(selectedDate: _selectedDay),
                      ),
                    );
                  },
                  child: const ButtonBar(
                    children: [
                      Text(
                        '그래프 보기',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Record(
                      name: '섭취 칼로리',
                      code: 'Kcal',
                      icon: Icons.local_dining,
                      isInverted: false,
                      order: 0,
                      selectedDayCalendarDto: selectedDayCalendarDto,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Record(
                      name: '걸음수',
                      code: '걸음',
                      icon: Icons.directions_walk,
                      isInverted: false,
                      order: 1,
                      selectedDayCalendarDto: selectedDayCalendarDto,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Record(
                      name: '총거리',
                      code: 'Km',
                      icon: Icons.place,
                      isInverted: false, // 컬러반전 시키기
                      order: 2,
                      selectedDayCalendarDto: selectedDayCalendarDto,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Record(
                      name: '물',
                      code: 'ml',
                      icon: Icons.water_drop,
                      isInverted: false,
                      order: 3,
                      selectedDayCalendarDto: selectedDayCalendarDto,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
