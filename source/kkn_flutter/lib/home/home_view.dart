/*
  <앞으로 구현했으면 하는 기능>
  1. 걸음 수의 변경 값이 정수인지 섭취한 물의 양이 실수인지 확인하는 기능
*/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:kkn/drawer/drawer.dart';
import 'package:kkn/home/button.dart';
import 'package:kkn/home/currency_card.dart';
import 'package:kkn/home/dto/home_dto.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.homeDto}) : super(key: key);

  final HomeDto homeDto;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String errorMessage = "";

  late String currentDate;

  void pageReload(String message) {
    setState(() {
      errorMessage = message;
    });
  }

  @override
  void initState() {
    super.initState();
    currentDate = DateFormat.yMMMMd().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF181818),
        appBar: AppBar(
            title: const Text('Kcal Know now eat!'),
            backgroundColor: const Color(0xFF181818),
            centerTitle: true),
        drawer: AppDrawer(homeDto: widget.homeDto),
        body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          currentDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.homeDto.nickname,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                '오늘 섭취한 칼로리',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.yellow.withOpacity(0.8),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${(double.parse(widget.homeDto.consumeCalories) * 10).round() * 0.1} Kcal',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                    text: '${widget.homeDto.recommandCalories} Kcal',
                    bgColor: const Color.fromARGB(255, 215, 204, 73),
                    textColor: Colors.black,
                  ),
                  Button(
                    text:
                        '${((double.parse(widget.homeDto.recommandCalories) - double.parse(widget.homeDto.consumeCalories)) * 10).round() * 0.1} Kcal',
                    bgColor: const Color.fromARGB(255, 215, 204, 73),
                    textColor: Colors.black,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Record',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.yellow),
                ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    CurrencyCard(
                      name: '카메라',
                      code: '',
                      icon: Icons.camera_alt_rounded,
                      isInverted: true, // 컬러반전 시키기
                      order: 0,
                      homeDto: widget.homeDto,
                      homeReloadFunction: pageReload,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CurrencyCard(
                      name: '걸음 수',
                      code: '걸음',
                      icon: Icons.directions_walk,
                      isInverted: false,
                      order: 1,
                      homeDto: widget.homeDto,
                      homeReloadFunction: pageReload,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CurrencyCard(
                      name: '총 거리',
                      code: 'Km',
                      icon: Icons.place,
                      isInverted: false, // 컬러반전 시키기
                      order: 2,
                      homeDto: widget.homeDto,
                      homeReloadFunction: pageReload,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CurrencyCard(
                      name: '물',
                      code: 'ml',
                      icon: Icons.water_drop,
                      isInverted: false,
                      order: 3,
                      homeDto: widget.homeDto,
                      homeReloadFunction: pageReload,
                    ),
                  ],
                ),
              ))
            ])));
  }
}
