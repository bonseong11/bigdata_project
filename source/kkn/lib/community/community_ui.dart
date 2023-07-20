import 'package:flutter/material.dart';
import 'package:kkn/community/community_card.dart';
import 'package:kkn/community/community_dto.dart';
import 'package:kkn/community/community_post.dart';

import 'package:kkn/drawer/drawer.dart';
import 'package:kkn/home/dto/home_dto.dart';
import 'package:kkn/home/home_view.dart';

// import 'dart:io';

class Community extends StatefulWidget {
  const Community({Key? key, required this.homeDto}) : super(key: key);

  final HomeDto homeDto;

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  CommunityDto community = CommunityDto("", "", "", "");
  final List<Posts> posts = [];

  @override
  void initState() {
    super.initState();
    // Add some sample posts to the list
  }

  @override
  Widget build(BuildContext context) {
    community.userid = widget.homeDto.userid;
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: AppBar(
        title: const Text('Community'),
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
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: posts[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Post(homeDto: widget.homeDto),
            ),
          );
          if (result != null && result is Map<String, String>) {
            // Create a new post based on the result
            final newPost = Posts(
              title: result['title'] ?? '',
              content: result['content'] ?? '',
            );
            setState(() {
              // Add the new post to the list
              posts.add(newPost);
            });
          }
        },
        backgroundColor: const Color(0xFF181818),
        child: const Icon(Icons.add_box),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
