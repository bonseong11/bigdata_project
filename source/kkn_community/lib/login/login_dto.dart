class LoginDto {
  String userid;
  String password;

  LoginDto(this.userid, this.password);

  LoginDto.fromJson(Map<String, dynamic> json)
      : userid = json['userid'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'password': password,
      };
}
