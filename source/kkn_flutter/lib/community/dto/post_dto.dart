class PostDto {
  String num;
  String userid;
  String nickname;

  String title;
  String content;
  int likes;
  // List<Comment> comments; // 댓글 목록

  PostDto(
      {required this.num,
      required this.userid,
      required this.nickname,
      required this.title,
      required this.content})
      : likes = 0;
  // comments = []; // 초기값으로 댓글 목록을 빈 리스트로 설정

  PostDto.fromJson(Map<String, dynamic> json)
      : num = json['num'].toString(),
        userid = json["userid"],
        nickname = json["nickname"],
        title = json['title'],
        content = json['content'],
        likes = json['likes'];
}
