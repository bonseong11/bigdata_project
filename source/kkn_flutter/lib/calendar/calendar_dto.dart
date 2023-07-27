class CalendarDto {
  String userid;
  String healthdate;
  String steps;
  String waterInTake;
  String distance;

  CalendarDto(this.userid, this.healthdate, this.steps, this.waterInTake,
      this.distance);

  CalendarDto.fromJson(Map<String, dynamic> json)
      : userid = json['userid'],
        healthdate = json['healthdate'],
        steps = json['steps'].toString(),
        waterInTake = json['waterInTake'].toString(),
        distance = (json['steps'] * 0.00075).toString();

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'healthdate': healthdate,
      };
}
