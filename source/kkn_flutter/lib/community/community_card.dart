import 'package:flutter/material.dart';

import 'package:kkn/home/dto/home_dto.dart';
import 'package:kkn/community/community_controller.dart';
import 'package:kkn/community/dto/post_save_dto.dart';
import 'package:kkn/community/dto/post_dto.dart';
import 'package:kkn/community/community_view.dart';

class PostCard extends StatefulWidget {
  const PostCard({Key? key, required this.homeDto, required this.post})
      : super(key: key);

  final HomeDto homeDto;
  final PostDto post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  PostSaveDto community = PostSaveDto("", "", "", "");
  bool _isLiked = false; // Track whether the post is liked or not

  String errorMessage = "";

  void deleteProcess() async {
    CommunityController communityController = CommunityController();

    errorMessage = await communityController.postDelete(
        widget.homeDto.userid, widget.post.userid, int.parse(widget.post.num));

    if (errorMessage.isEmpty) {
      List<PostDto> postList =
          await communityController.postListLoad(DateTime.now().toString());

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

  void _likePost() {
    setState(() {
      if (_isLiked) {
        widget.post.likes--;
        _isLiked = false; // Unlike the post
      } else {
        widget.post.likes++;
        _isLiked = true; // Like the post
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF181818),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.post.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: deleteProcess,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF181818),
                  ),
                  child: const Text('Delete'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.yellow),
              ),
            const SizedBox(height: 10),
            Text(
              widget.post.content,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _likePost,
                  icon: const Icon(Icons.favorite),
                  color: Colors.red,
                ),
                Text(
                  widget.post.likes.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('댓글'),
                          content: TextFormField(
                            controller: TextEditingController(),
                            decoration: const InputDecoration(
                              hintText: '댓글을 작성하세요',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text(
                                'Add',
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.comment),
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
