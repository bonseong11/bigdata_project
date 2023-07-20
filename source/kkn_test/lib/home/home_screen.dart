import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kkn_test/models/health_record_model.dart';

import '../../widgets/button.dart';
import '../../widgets/currency_card.dart';
import '../login/login_page.dart';

class HomeScreen extends StatefulWidget {
  final String userid;
  final List<HealthRecord> healthRecords;
  const HomeScreen(
      {Key? key, required this.userid, required this.healthRecords})
      : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String currentDate;

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
        title: const Text('Welcome KKN'),
        backgroundColor: const Color(0xFF181818),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'KKN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Do something
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Do something
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        widget.healthRecords.isNotEmpty
                            ? widget.healthRecords.last.member.nickname
                                .toString()
                            : '0',
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
              const SizedBox(height: 15),
              Text(
                'Today',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.yellow.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                '섭취한 칼로리Kcal',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                    text: '내꺼',
                    bgColor: Color.fromARGB(255, 215, 204, 73),
                    textColor: Colors.black,
                  ),
                  Button(
                    text: '남은 칼로리',
                    bgColor: Color.fromARGB(255, 215, 204, 73),
                    textColor: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 30),
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
              const SizedBox(height: 20),
              CurrencyCard(
                name: '걸음수',
                code: '걸음',
                amount: widget.healthRecords.isNotEmpty
                    ? widget.healthRecords.last.steps.toString()
                    : '0',
                icon: Icons.directions_walk,
                isInverted: false,
                order: 0,
              ),
              const SizedBox(height: 30),
              const CurrencyCard(
                name: '총거리',
                code: 'Km',
                amount: '9 785',
                icon: Icons.place,
                isInverted: false,
                order: 1,
              ),
              const SizedBox(height: 30),
              CurrencyCard(
                name: '물',
                code: 'ml',
                amount: widget.healthRecords.isNotEmpty
                    ? widget.healthRecords.last.waterIntake.toString()
                    : '0',
                icon: Icons.water_drop,
                isInverted: false,
                order: 2,
              ),
              const SizedBox(height: 30),
              CurrencyCard(
                name: 'Bitcoin',
                code: 'BTC',
                amount: widget.healthRecords.isNotEmpty
                    ? widget.healthRecords.last.bmi.toString()
                    : '0',
                icon: Icons.currency_bitcoin,
                isInverted: true,
                order: 3,
              ),
              const SizedBox(height: 30),
              const CurrencyCard(
                name: 'Dollar',
                code: 'USD',
                amount: '428',
                icon: Icons.attach_money_outlined,
                isInverted: false,
                order: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
