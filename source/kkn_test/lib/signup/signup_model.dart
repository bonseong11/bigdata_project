class SignupModel {
  String userid;
  String nickname;
  String password;
  String email;
  int gender;
  double height;
  double weight;

  SignupModel(this.userid, this.nickname, this.password, this.email,
      this.gender, this.height, this.weight);

  SignupModel.fromJson(Map<String, dynamic> json)
      : userid = json['userid'],
        nickname = json['nickname'],
        password = json['password'],
        email = json['email'],
        gender = json['gender'],
        height = json['height'],
        weight = json['weight'];

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'nickname': nickname,
        'password': password,
        'email': email,
        'gender': gender,
        'height': height,
        'weight': weight,
      };
}
