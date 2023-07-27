import 'package:flutter/material.dart';

import 'package:kkn/community/dto/post_dto.dart';
import 'package:kkn/community/community_controller.dart';
import 'package:kkn/home/dto/home_dto.dart';
import 'package:kkn/home/home_view.dart';
import 'package:kkn/community/community_view.dart';
import 'package:kkn/like/like_controller.dart';
import 'package:kkn/like/dto/like_load_response_dto.dart';
import 'package:kkn/like/dto/like_load_send_dto.dart';
import 'package:kkn/login/login_view.dart';
import 'package:kkn/calendar/calendar_view.dart';
import 'package:kkn/mypage/dto/mypage_dto.dart';
import 'package:kkn/mypage/dto/mypage_response_dto.dart';
import 'package:kkn/mypage/mypage_controller.dart';
import 'package:kkn/mypage/mypage_view.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key, required this.homeDto}) : super(key: key);

  final HomeDto homeDto;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  void myPageViewPrepare() async {
    MypageResponseDto mypageResponseDto =
        await MypageController().memberInformationLoad(widget.homeDto.userid);

    if (mypageResponseDto.errorMessage.isEmpty) {
      toMyPageView(mypageResponseDto.mypageDto!);
    }
  }

  void toMyPageView(MypageDto myPageDto) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MypageView(homeDto: widget.homeDto, myPageDto: myPageDto),
      ),
    );
  }

  void communityViewPrepare() async {
    List<PostDto> postList =
        await CommunityController().postListLoad(DateTime.now().toString());

    List<int> postNumList = postNumSelect(postList);
    LikeLoadResponseDto likeLoadResponseDto = await LikeController()
        .likeCheckListLoad(LikeLoadSendDto(widget.homeDto.userid, postNumList));

    toCommunity(postList, likeLoadResponseDto.likeCheckList);
  }

  List<int> postNumSelect(List<PostDto> postList) {
    List<int> postNumList = [];
    for (PostDto post in postList) {
      postNumList.add(int.parse(post.num));
    }

    return postNumList;
  }

  void toCommunity(List<PostDto> postList, List<dynamic> likeCheckList) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CommunityView(
            homeDto: widget.homeDto,
            postList: postList,
            likeCheckList: likeCheckList),
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
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Colors.grey[850],
            ),
            title: const Text('마이 페이지'),
            onTap: myPageViewPrepare,
          ),
          ListTile(
              leading: Icon(
                Icons.people,
                color: Colors.grey[850],
              ),
              title: const Text('커뮤니티'),
              onTap: communityViewPrepare),
          ListTile(
            leading: Icon(
              Icons.calendar_month,
              color: Colors.grey[850],
            ),
            title: const Text('건강 기록'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CalendarView(homeDto: widget.homeDto),
                ),
              );
            },
          ),
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
