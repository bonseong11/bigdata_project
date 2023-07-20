import 'package:flutter/material.dart';

import 'package:kkn/community/community_controller.dart';
import 'package:kkn/home/dto/home_dto.dart';
import 'package:kkn/community/dto/post_save_dto.dart';
import 'package:kkn/community/dto/post_dto.dart';
import 'package:kkn/community/community_view.dart';

class Post extends StatefulWidget {
  const Post({Key? key, required this.homeDto}) : super(key: key);

  final HomeDto homeDto;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  PostSaveDto community = PostSaveDto("", "", "", "0");

  String errorMessage = '';

  void createProcess() async {
    CommunityController communityController = CommunityController();

    errorMessage = await communityController.postCreate(community);

    if (errorMessage.isEmpty) {
      List<PostDto> postList = await communityController.postListLoad(
          DateTime.now().add(const Duration(seconds: 1)).toString());

      toCommunity(widget.homeDto, postList);
    } else {
      setState(() {});
    }
  }

  void toCommunity(HomeDto homeDto, List<PostDto> postList) {
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
    community.userid = widget.homeDto.userid;

    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: AppBar(
        title: const Text('새 포스트 작성'),
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
                labelText: '제목',
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
                  labelText: '내용',
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
                onPressed: createProcess,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF181818) // 원하는 버튼 색상으로 변경
                    ),
                child: const Text('등록', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(
                width: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF181818) // 원하는 버튼 색상으로 변경
                    ),
                child: const Text('취소', style: TextStyle(fontSize: 20)),
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
