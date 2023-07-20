import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kkn/community/community_dto.dart';
import 'package:kkn/connect/connect.dart';
import 'package:logger/logger.dart';

class Posts {
  final String title;
  final String content;

  int likes; // 좋아요 수
  // List<Comment> comments; // 댓글 목록

  Posts({required this.title, required this.content})
      : likes = 0; // 초기값으로 좋아요 수를 0으로 설정
  // comments = []; // 초기값으로 댓글 목록을 빈 리스트로 설정
}

class PostCard extends StatefulWidget {
  final Posts post;

  const PostCard({Key? key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  CommunityDto community = CommunityDto("", "", "", "");
  bool _isLiked = false; // Track whether the post is liked or not
  // final List<Comment> _comments = []; // 댓글 목록

  void delete() async {
    Connect connect = Connect();

    String body = json.encode(community.toJson());
    Logger().i(body);

    dynamic response = await connect.sendProcess("/community/delete", body);

    if (response != null && response is bool && response) {
      response = await connect.sendProcess("/", community.userid);
    }
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

/*
  void _addComment() {
    String commentText = community.comments;
    if (commentText.isNotEmpty) {
      setState(() {
        widget.post.comments.add(Comment(text: commentText, author: ''));
        community.comments = ''; // 댓글 추가 후 입력 필드 초기화
      });
    }
  }
*/

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
                  onPressed: delete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF181818),
                  ),
                  child: const Text('Delete'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.post.content,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            /*
            if (widget.post.image != null) ...[
              const SizedBox(height: 10),
              SizedBox(
                height: 500, // Set the desired height for the image container
                child: Image.file(
                  widget.post.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            const SizedBox(height: 10),*/
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
                            controller: TextEditingController(
                                /*text: community.comments*/),
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
                                /*_addComment();*/
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
                /*Text(
                  widget.post.comments.length.toString()
                  style: const TextStyle(color: Colors.white),
                ),
                */
              ],
            ),
            const SizedBox(height: 10),
            /*if (widget.post.comments.isNotEmpty) ...[
              const Text(
                'Comments',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.post.comments
                    .map((comment) => Text(
                          ': ${comment.text}',
                          style: const TextStyle(color: Colors.white),
                        ))
                    .toList(),
              ),
            ],
            */
          ],
        ),
      ),
    );
  }
}
/*
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Comment>('_comments', _comments));
  }
}

class Comment {
  final String text;
  final String author; // 댓글 작성자

  Comment({required this.text, required this.author});
}
*/
