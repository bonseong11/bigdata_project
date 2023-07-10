class LoginModel {
  String userid;
  String password;

  LoginModel(this.userid, this.password);

  LoginModel.fromJson(Map<String, dynamic> json)
      : userid = json['userid'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'password': password,
      };
}
