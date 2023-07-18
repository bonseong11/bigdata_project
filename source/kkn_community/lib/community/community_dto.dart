class CommunityDto {
  String userid;
  String title;
  String content;
  String likes;

  CommunityDto(this.userid, this.title, this.content, this.likes);

  CommunityDto.fromJson(Map<String, dynamic> json)
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
