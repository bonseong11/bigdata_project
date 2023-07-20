import 'package:flutter/material.dart';

import 'package:kkn/home/dto/home_dto.dart';
import 'package:kkn/community/dto/post_dto.dart';
import 'package:kkn/community/community_post.dart';
import 'package:kkn/community/community_card.dart';
import 'package:kkn/home/home_view.dart';
import 'package:kkn/drawer/drawer.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({Key? key, required this.homeDto, required this.postList})
      : super(key: key);

  final HomeDto homeDto;
  final List<PostDto> postList;

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
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
      body: ListView.builder(
        itemCount: widget.postList.length,
        itemBuilder: (context, index) {
          return PostCard(
              homeDto: widget.homeDto, post: widget.postList[index]);
        },
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
