// import 'package:flutter/foundation.dart';
// import '../service/api_service_login.dart';

// class AuthProvider with ChangeNotifier {
//   ApiService apiService;
//   late String loggedInUserId;

//   AuthProvider(this.apiService);

//   Future<bool> login(String userid, String password) async {
//     final success = await apiService.login(userid, password);
//     if (success) {
//       loggedInUserId = userid;
//       notifyListeners();
//     }
//     return success;
//   }

//   void logout() {
//     loggedInUserId = '';
//     notifyListeners();
//   }
// }
