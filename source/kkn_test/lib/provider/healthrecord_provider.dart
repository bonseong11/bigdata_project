// import 'package:flutter/foundation.dart';
// import 'package:logger/logger.dart';
// import '../models/member_model.dart';
// import '../service/api_service_login.dart';
// import '../models/health_record_model.dart';

// class HealthRecordProvider with ChangeNotifier {
//   final ApiService apiService;
//   final logger = Logger();
//   List<HealthRecord> healthRecords = [];

//   HealthRecordProvider(this.apiService);

//   Future<void> fetchHealthRecords(String userid) async {
//     try {
//       final response = await apiService.fetchHealthRecords(userid);
//       print('API response: $response');

//       // Assuming the response is a List<dynamic> or List<Map<String, dynamic>>
//       final List<dynamic> jsonData = response;

//       // Map the JSON data to HealthRecord objects
//       healthRecords = jsonData.map((data) {
//         print('Processing data: $data');
//         // Convert waterintake and bmi to double explicitly
//         final waterIntake = data['waterintake'].toDouble();
//         final bmi = data['bmi'].toDouble();

//         return HealthRecord(
//           num: data['num'],
//           userid: data['userid'],
//           member: Member.fromJson(data['member']),
//           healthdate: data['healthdate'],
//           waterIntake: waterIntake,
//           bmi: bmi,
//           steps: data['steps'],
//         );
//       }).toList();

//       logger.d('API response: $healthRecords');
//       notifyListeners();
//     } catch (e) {
//       logger.e('Error fetching health records: $e');
//     }
//   }
// }
