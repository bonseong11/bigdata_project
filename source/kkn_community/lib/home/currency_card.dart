import 'package:flutter/material.dart';
import 'package:kkn_/home/home_dto.dart';

class CurrencyCard extends StatefulWidget {
  const CurrencyCard({
    Key? key,
    required this.homeDto,
    required this.homeReloadFunction,
    required this.name,
    required this.code,
    required this.icon,
    required this.isInverted,
    required this.order,
  }) : super(key: key);

  final HomeDto homeDto;
  final Function homeReloadFunction;

  final String name;
  final String code;
  final IconData icon;
  final bool isInverted;
  final int order;

  final _blackColor = const Color(0xFF1F2123);

  String amountSet() {
    switch (order) {
      case 1:
        return homeDto.steps;
      case 2:
        return homeDto.distance;
      case 3:
        return homeDto.waterInTake;
    }

    return "";
  }

  @override
  State<CurrencyCard> createState() => _CurrencyCardState();
}

class _CurrencyCardState extends State<CurrencyCard> {
  String amount = "";

  @override
  Widget build(BuildContext context) {
    amount = widget.amountSet();

    return Transform.translate(
      offset: Offset(0, widget.order * -20.0),
      child: GestureDetector(
        onTap: widget.order == 1
            ? () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('걸음수 입력'),
                      content: TextField(
                        controller:
                            TextEditingController(text: widget.homeDto.steps),
                        onChanged: (String value) {
                          widget.homeDto.steps = value;
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            widget.homeDto.steps = amount;
                            Navigator.of(context).pop();
                          },
                          child: const Text('닫기'),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.homeDto.distance =
                                (int.parse(widget.homeDto.steps) * 0.00075)
                                    .toString();
                            widget.homeReloadFunction();
                            Navigator.of(context).pop();
                          },
                          child: const Text('저장'),
                        ),
                      ],
                    );
                  },
                );
              }
            : widget.order == 3
                ? () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('마신 물 입력'),
                          content: TextField(
                            controller: TextEditingController(
                                text: widget.homeDto.waterInTake),
                            onChanged: (String value) {
                              widget.homeDto.waterInTake = value;
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                widget.homeDto.waterInTake = amount;
                                Navigator.of(context).pop();
                              },
                              child: const Text('닫기'),
                            ),
                            TextButton(
                              onPressed: () {
                                widget.homeReloadFunction();
                                Navigator.of(context).pop();
                              },
                              child: const Text('저장'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                : null,
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
