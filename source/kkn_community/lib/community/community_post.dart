import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kkn_/community/community_card.dart';
import 'package:kkn_/community/community_dto.dart';
import 'package:kkn_/community/community_ui.dart';
import 'package:kkn_/connect/connect.dart';

import 'package:kkn_/home/home_dto.dart';
import 'package:logger/logger.dart';

class Post extends StatefulWidget {
  const Post({Key? key, required this.homeDto});

  final HomeDto homeDto;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  CommunityDto community = CommunityDto("", "", "", "");
  final List<Posts> post = [];

  String errorMessage = '';

  void create() async {
    Connect connect = Connect();

    String body = json.encode(community.toJson());
    Logger().i(body);

    dynamic response = await connect.sendProcess("/community/create", body);

    if (response != null && response is bool && response) {
      response = await connect.sendProcess("/", community.userid);
      navigateToCommunity(HomeDto.fromJson(json.decode(response)));
    }
  }

  bool createFormValidate() {
    if (community.title.isEmpty || community.content.isEmpty) {
      setState(() {
        errorMessage = "빈칸을 입력해주세요.";
      });

      return false;
    }
    return true;
  }

  void navigateToCommunity(HomeDto homeDto) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Community(homeDto: widget.homeDto),
      ),
    );
  }

  @override
  void dispose() {
    TextEditingController(text: community.title).dispose();
    TextEditingController(text: community.content).dispose();
    super.dispose();
  }

  void savePost(String title, String content) {
    setState(() {
      post.add(Posts(title: title, content: content));
    });
  }

  @override
  Widget build(BuildContext context) {
    community.userid = widget.homeDto.userid;
    // community.comments = '';
    community.likes = '0';
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: AppBar(
        title: const Text('Posting'),
        backgroundColor: const Color(0xFF181818),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: TextEditingController(text: community.title),
              onChanged: (value) {
                community.title = value;
              },
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'title',
                labelStyle: const TextStyle(color: Colors.white),
                prefixIcon:
                    const Icon(Icons.person_outline, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 300,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: TextFormField(
                controller: TextEditingController(text: community.content),
                onChanged: (value) {
                  community.content = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white),
                maxLines: null, // 여러 줄에 걸쳐서 입력 가능하도록 설정
                decoration: InputDecoration(
                  labelText: 'content',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  prefixIcon:
                      const Icon(Icons.person_outline, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          /*SizedBox(
            width: 300,
            child: TextFormField(
              controller: TextEditingController(text: community.content),
              onChanged: (value) {
                community.content = value;
              },
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'images',
                labelStyle: const TextStyle(color: Colors.white),
                prefixIcon:
                    const Icon(Icons.person_outline, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),*/
          const SizedBox(height: 10.0),
          if (errorMessage.isNotEmpty)
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.yellow),
            ),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (createFormValidate()) {
                    create();
                    Navigator.pop(context, {
                      'title': community.title,
                      'content': community.content,
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF181818) // 원하는 버튼 색상으로 변경
                    ),
                child: const Text('create', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(
                width: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Community(homeDto: widget.homeDto)));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF181818) // 원하는 버튼 색상으로 변경
                    ),
                child: const Text('cancel', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
