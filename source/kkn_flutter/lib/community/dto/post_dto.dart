import 'package:kkn/comment/dto/comment_load_dto.dart';

class PostDto {
  String num;
  String userid;
  String nickname;
  String writeDateTimeStamp;

  String title;
  String content;
  int likes;

  List<CommentLoadDto>? commentList; // 댓글 목록

  PostDto(
      {required this.num,
      required this.userid,
      required this.nickname,
      required this.writeDateTimeStamp,
      required this.title,
      required this.content})
      : likes = 0;
  // comments = []; // 초기값으로 댓글 목록을 빈 리스트로 설정

  PostDto.fromJson(Map<String, dynamic> json)
      : num = json['num'].toString(),
        userid = json["userid"],
        nickname = json["nickname"],
        writeDateTimeStamp = json["writeDateTimeStamp"],
        title = json['title'],
        content = json['content'],
        likes = json['likes'] {
    if (json['commentslist'] != null) {
      commentList = toCommentLoadDtoProcess(json['commentslist']);
    }
  }

  List<CommentLoadDto> toCommentLoadDtoProcess(List<dynamic> rawCommentList) {
    List<CommentLoadDto> commentList = [];

    for (var comment in rawCommentList) {
      commentList.add(CommentLoadDto.fromJson(comment));
    }

    return commentList;
  }
}
