class Member {
  final String userid;
  final String nickname;
  final String password;
  final String email;
  final int gender;
  final double height;
  final double weight;

  Member({
    required this.userid,
    required this.nickname,
    required this.password,
    required this.email,
    required this.gender,
    required this.height,
    required this.weight,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      userid: json['userid'],
      nickname: json['nickname'],
      password: json['password'],
      email: json['email'],
      gender: json['gender'],
      height: json['height'],
      weight: json['weight'],
    );
  }
}
