import 'package:flutter/material.dart';

import 'package:kkn/community/dto/post_dto.dart';
import 'package:kkn/community/community_controller.dart';
import 'package:kkn/home/dto/home_dto.dart';
import 'package:kkn/home/home_view.dart';
import 'package:kkn/community/community_view.dart';
import 'package:kkn/login/login_view.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key, required this.homeDto}) : super(key: key);

  final HomeDto homeDto;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  void toCommunity(List<PostDto> postList) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CommunityView(homeDto: widget.homeDto, postList: postList),
      ),
    );
  }

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
                'assets/images/logo.png',
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
            title: const Text('홈'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeView(homeDto: widget.homeDto),
                ),
              );
            },
          ),
          /*ListTile(
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
          ),*/
          ListTile(
              leading: Icon(
                Icons.people,
                color: Colors.grey[850],
              ),
              title: const Text('커뮤니티'),
              onTap: () async {
                List<PostDto> postList = await CommunityController()
                    .postListLoad(DateTime.now().toString());

                toCommunity(postList);
              }),
          /*ListTile(
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
          ),*/
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.grey[850],
            ),
            title: const Text('로그아웃'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
