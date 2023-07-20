class HealthRecord {
  final int num;
  final Member member;
  final List<int> healthDate;
  final double waterIntake;
  final double bmi;
  final int steps;

  HealthRecord({
    required this.num,
    required this.member,
    required this.healthDate,
    required this.waterIntake,
    required this.bmi,
    required this.steps,
  });

  factory HealthRecord.fromJson(Map<String, dynamic> json) {
    return HealthRecord(
      num: json['num'],
      member: Member.fromJson(json['member']),
      healthDate: List<int>.from(json['healthDate']),
      waterIntake: json['waterIntake'].toDouble(),
      bmi: json['bmi'].toDouble(),
      steps: json['steps'],
    );
  }
}

class Member {
  final String userid;
  final String nickname;
  final int gender;
  final double height;
  final double weight;

  Member({
    required this.userid,
    required this.nickname,
    required this.gender,
    required this.height,
    required this.weight,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      userid: json['userid'],
      nickname: json['nickname'],
      gender: json['gender'],
      height: json['height'].toDouble(),
      weight: json['weight'].toDouble(),
    );
  }
}
