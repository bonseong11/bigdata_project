import 'package:flutter/material.dart';
import 'package:kkn/community/community_controller.dart';

import 'package:kkn/home/dto/home_dto.dart';
import 'package:kkn/community/dto/post_dto.dart';
import 'package:kkn/community/community_post.dart';
import 'package:kkn/community/community_card.dart';
import 'package:kkn/home/home_view.dart';
import 'package:kkn/drawer/drawer.dart';
import 'package:kkn/like/like_controller.dart';
import 'package:kkn/like/dto/like_load_response_dto.dart';
import 'package:kkn/like/dto/like_load_send_dto.dart';

class CommunityView extends StatefulWidget {
  const CommunityView(
      {Key? key,
      required this.homeDto,
      required this.postList,
      required this.likeCheckList})
      : super(key: key);

  final HomeDto homeDto;
  final List<PostDto> postList;
  final List<dynamic> likeCheckList;

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  List<PostDto> postList = [];
  List<dynamic> likeCheckList = [];

  void postListAddProcess() async {
    List<PostDto> addPostList = await CommunityController()
        .postListAdd(postList[postList.length - 1].writeDateTimeStamp);

    postList.addAll(addPostList);

    List<int> postNumList = postNumSelect(addPostList);
    LikeLoadResponseDto likeLoadResponseDto = await LikeController()
        .likeCheckListLoad(LikeLoadSendDto(widget.homeDto.userid, postNumList));

    likeCheckList.addAll(likeLoadResponseDto.likeCheckList);
  }

  List<int> postNumSelect(List<PostDto> postList) {
    List<int> postNumList = [];
    for (PostDto post in postList) {
      postNumList.add(int.parse(post.num));
    }

    return postNumList;
  }

  @override
  void initState() {
    super.initState();

    postList = widget.postList;
    likeCheckList = widget.likeCheckList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: AppBar(
        title: const Text('커뮤니티'),
        backgroundColor: const Color(0xFF181818),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeView(homeDto: widget.homeDto),
                ),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: AppDrawer(homeDto: widget.homeDto),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollNotification) {
          if (scrollNotification is ScrollEndNotification) {
            final before = scrollNotification.metrics.extentBefore;
            final max = scrollNotification.metrics.maxScrollExtent;
            if (before == max) {
              postListAddProcess();

              setState(() {
                /*内容コード作成*/
              });
              return true;
            }
          }
          return false;
        },
        child: ListView.builder(
          itemCount: postList.length,
          itemBuilder: (context, index) {
            return PostCard(
                homeDto: widget.homeDto,
                post: postList[index],
                isLike: likeCheckList[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Post(homeDto: widget.homeDto),
            ),
          );
        },
        backgroundColor: const Color(0xFF181818),
        child: const Icon(Icons.add_box),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
