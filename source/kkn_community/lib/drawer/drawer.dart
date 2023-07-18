import 'package:flutter/material.dart';
import 'package:kkn_/community/community_ui.dart';
import 'package:kkn_/home/home_dto.dart';
import 'package:kkn_/home/home_screen.dart';
import 'package:kkn_/login/login_ui.dart';
import 'package:kkn_/mypage/mypage_ui.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key, required this.homeDto}) : super(key: key);

  final HomeDto homeDto;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/logo.png',
                width: 180,
                height: 350,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.grey[850],
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(homeDto: homeDto),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Colors.grey[850],
            ),
            title: const Text('My Page'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MypageUi(homeDto: homeDto),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.grey[850],
            ),
            title: const Text('Coummnity'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Community(homeDto: homeDto),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_month,
              color: Colors.grey[850],
            ),
            title: const Text('Calendar'),
            onTap: () {
              /*Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Calendar(homeDto: homeDto),
                ),
              );*/
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.grey[850],
            ),
            title: const Text('logout'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginUi()),
              );
            },
          ),
        ],
      ),
    );
  }
}
