class MypageDto {
  String userid;
  String height;
  String weight;
  String gender;

  MypageDto(this.userid, this.weight, this.height, this.gender);
  // json받은거 오는거 변환 spring에서 변환
  MypageDto.fromJson(Map<String, dynamic> json)
      : userid = json['userid'],
        height = json['height'].toString(),
        weight = json['weight'].toString(),
        gender = json['gender'].toString();
  // spring으로 던져줄때
  Map<String, dynamic> toJson() => {
        'userid': userid,
        'height': double.parse(height),
        'weight': double.parse(weight),
        'gender': int.parse(gender)
      };
}
