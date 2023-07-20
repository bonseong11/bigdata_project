// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:logger/logger.dart';

// import '../models/health_record_model.dart';

// // 이거 로그인 할때 쓰는 apiservice입니다.
// class ApiService {
//   static const baseUrl = 'http://192.168.41.204:8003';
//   final logger = Logger();

//   Future<bool> login(String userid, String password) async {
//     const url = '$baseUrl/member/login';
//     final headers = {'Content-Type': 'application/json'};
//     final body = json.encode({'userid': userid, 'password': password});

//     final response =
//         await http.post(Uri.parse(url), headers: headers, body: body);

//     if (bool.parse(response.body)) {
//       return true;
//     } else {
//       throw Exception('Login failed');
//     }
//   }

//   Future<List<HealthRecord>> fetchHealthRecords(String userid) async {
//     final url = '$baseUrl/member/$userid/healthrecords';
//     final headers = {'Content-Type': 'application/json'};

//     final response = await http.get(Uri.parse(url), headers: headers);
// // 
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonList = json.decode(response.body);
//       final List<HealthRecord> healthRecords =
//           jsonList.map((json) => HealthRecord.fromJson(json)).toList();
//       return healthRecords;
//     } else {
//       final statusCode = response.statusCode;
//       logger.d('Fetching health records failed with status code: $statusCode');
//       throw Exception('Fetching health records failed: $statusCode');
//     }
//   }
// }
