import 'package:flutter/material.dart';

import 'package:kkn/comment/comment_controller.dart';
import 'package:kkn/comment/dto/comment_input_dto.dart';
import 'package:kkn/comment/dto/comment_list_add_send_dto.dart';
import 'package:kkn/comment/dto/comment_load_dto.dart';
import 'package:kkn/home/dto/home_dto.dart';
import 'package:kkn/community/community_controller.dart';
import 'package:kkn/community/dto/post_save_dto.dart';
import 'package:kkn/community/dto/post_dto.dart';
import 'package:kkn/community/community_view.dart';
import 'package:kkn/like/like_controller.dart';
import 'package:kkn/like/dto/like_load_response_dto.dart';
import 'package:kkn/like/dto/like_load_send_dto.dart';
import 'package:kkn/like/dto/like_save_delete_send_dto.dart';

class PostCard extends StatefulWidget {
  const PostCard(
      {Key? key,
      required this.homeDto,
      required this.post,
      required this.isLike})
      : super(key: key);

  final HomeDto homeDto;
  final PostDto post;
  final bool isLike;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  PostSaveDto community = PostSaveDto("", "", "", "");
  CommentInputDto newComment = CommentInputDto("", "", "");

  String errorMessage = "";

  bool isLike = true;
  List<CommentLoadDto>? commentList;

  void deleteProcess() async {
    CommunityController communityController = CommunityController();

    errorMessage = await communityController.postDelete(
        widget.homeDto.userid, widget.post.userid, int.parse(widget.post.num));

    if (errorMessage.isEmpty) {
      List<PostDto> postList =
          await communityController.postListLoad(DateTime.now().toString());

      List<int> postNumList = postNumSelect(postList);
      LikeLoadResponseDto likeLoadResponseDto = await LikeController()
          .likeCheckListLoad(
              LikeLoadSendDto(widget.homeDto.userid, postNumList));

      toCommunity(widget.homeDto, postList, likeLoadResponseDto.likeCheckList);
    } else {
      setState(() {});
    }
  }

  List<int> postNumSelect(List<PostDto> postList) {
    List<int> postNumList = [];
    for (PostDto post in postList) {
      postNumList.add(int.parse(post.num));
    }

    return postNumList;
  }

  void toCommunity(
      HomeDto homeDto, List<PostDto> postList, List<dynamic> likeCheckList) {
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

  void likeClickProcess() async {
    LikeController likeController = LikeController();

    LikeSaveDeleteSendDto likeSaveSendDto =
        LikeSaveDeleteSendDto(widget.homeDto.userid, widget.post.num);

    if (isLike) {
      errorMessage = await likeController.likeCheckListDelete(likeSaveSendDto);
    } else {
      errorMessage = await likeController.likeCheckListSave(likeSaveSendDto);
    }

    if (errorMessage.isEmpty) {
      setState(() {
        if (isLike) {
          widget.post.likes--;
          isLike = false; // Unlike the post
        } else {
          widget.post.likes++;
          isLike = true; // Like the post
        }
      });
    }
  }

  void commentCreate() async {
    CommentController commentController = CommentController();

    errorMessage = await commentController.commentSave(newComment);

    if (errorMessage.isEmpty) {
      CommunityController communityController = CommunityController();

      List<PostDto> postList =
          await communityController.postListLoad(DateTime.now().toString());

      List<int> postNumList = postNumSelect(postList);
      LikeLoadResponseDto likeLoadResponseDto = await LikeController()
          .likeCheckListLoad(
              LikeLoadSendDto(widget.homeDto.userid, postNumList));

      toCommunity(widget.homeDto, postList, likeLoadResponseDto.likeCheckList);
    }
  }

  void windowClose() {
    newComment.content = "";

    Navigator.of(context).pop();
  }

  void commentListAddProcess() async {
    List<CommentLoadDto> addCommentList = await CommentController()
        .commentListAddProcess(CommentListAddSendDto(widget.post.num,
            commentList![commentList!.length - 1].commentWriteTimeStamp));

    commentList!.addAll(addCommentList);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    isLike = widget.isLike;
    commentList = widget.post.commentList;
  }

  @override
  Widget build(BuildContext context) {
    newComment.postNum = widget.post.num;
    newComment.userid = widget.homeDto.userid;

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
                  onPressed: likeClickProcess,
                  icon: isLike
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                  color: isLike ? Colors.red : Colors.white,
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
                            controller:
                                TextEditingController(text: newComment.content),
                            onChanged: (value) {
                              newComment.content = value;
                            },
                            decoration: const InputDecoration(
                              hintText: '댓글을 작성하세요',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: windowClose,
                              child: const Text(
                                '취소',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: commentCreate,
                              child: const Text(
                                '추가',
                                style: TextStyle(color: Colors.black),
                              ),
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
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (CommentLoadDto commentLoadDto in commentList!)
                      Text(
                        commentLoadDto.comments,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                  ],
                ),
                const SizedBox(width: 15),
                if (commentList!.length >= 2)
                  TextButton(
                    onPressed: commentListAddProcess,
                    child: const Text(
                      '댓글 더 보기',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
