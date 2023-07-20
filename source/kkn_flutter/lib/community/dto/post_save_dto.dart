// post form
class PostSaveDto {
  String userid;

  String title;
  String content;

  String likes;

  PostSaveDto(this.userid, this.title, this.content, this.likes);

  PostSaveDto.fromJson(Map<String, dynamic> json)
      : userid = json['userid'],
        title = json['title'],
        content = json['content'],
        likes = json['likes'].toString();

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'title': title,
        'content': content,
        'likes': int.parse(likes)
      };
}
