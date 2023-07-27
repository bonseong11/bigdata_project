import 'package:flutter/material.dart';
import 'package:kkn/calendar/dto/calendar_dto.dart';

class Record extends StatefulWidget {
  const Record({
    Key? key,
    required this.selectedDayCalendarDto,
    required this.name,
    required this.code,
    required this.icon,
    required this.isInverted,
    required this.order,
  }) : super(key: key);

  final CalendarDto selectedDayCalendarDto;

  final String name;
  final String code;
  final IconData icon;
  final bool isInverted;
  final int order;

  final _blackColor = const Color(0xFF1F2123);

  String amountSet() {
    switch (order) {
      case 0:
        return selectedDayCalendarDto.consumeCalories;
      case 1:
        return selectedDayCalendarDto.steps;
      case 2:
        return selectedDayCalendarDto.distance;
      case 3:
        return selectedDayCalendarDto.waterInTake;
    }

    return "";
  }

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  String amount = "";

  @override
  Widget build(BuildContext context) {
    amount = widget.amountSet();

    return Transform.translate(
      offset: Offset(0, widget.order * -20.0),
      child: GestureDetector(
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: widget.isInverted ? Colors.white : widget._blackColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            color: widget.isInverted
                                ? widget._blackColor
                                : Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          amount,
                          style: TextStyle(
                            color: widget.isInverted
                                ? widget._blackColor
                                : Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.code,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Transform.scale(
                  scale: 2.2,
                  child: Transform.translate(
                    offset: const Offset(-5, 10),
                    child: Icon(
                      widget.icon,
                      color:
                          widget.isInverted ? widget._blackColor : Colors.white,
                      size: 60,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
