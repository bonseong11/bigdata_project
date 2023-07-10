// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:http/http.dart' as http;

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({Key? key}) : super(key: key);

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   TextEditingController useridController = TextEditingController();
//   TextEditingController nicknameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController heightController = TextEditingController();
//   TextEditingController weightController = TextEditingController();
//   String? selectedGender;
//   final logger = Logger();

//   void signUp() async {
//     String url = 'http://192.168.41.204:8003/member/signup';
//     Map<String, String> headers = {'Content-Type': 'application/json'};
//     String userid = useridController.text;
//     String nickname = nicknameController.text;
//     String password = passwordController.text;
//     String email = emailController.text;
//     int gender = int.tryParse(selectedGender ?? '0') ?? 0;
//     double height = double.tryParse(heightController.text) ?? 0.0;
//     double weight = double.tryParse(weightController.text) ?? 0.0;

//     String body = '''
//     {
//       "userid": "$userid",
//       "nickname": "$nickname",
//       "password": "$password",
//       "email": "$email",
//       "gender": $gender,
//       "height": $height,
//       "weight": $weight
//     }
//     ''';

//     try {
//       http.Response response =
//           await http.post(Uri.parse(url), headers: headers, body: body);
//       if (response.statusCode == 200) {
//         logger.i("회원가입 성공");
//         navigateToLogin();
//       } else {
//         logger.e("회원가입 실패");
//       }
//     } catch (e) {
//       logger.e("서버 연결 실패");
//     }
//   }

//   void navigateToLogin() {
//     Navigator.pushReplacementNamed(context, '/');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign Up'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextField(
//                 controller: useridController,
//                 decoration: const InputDecoration(
//                   labelText: 'User ID',
//                 ),
//               ),
//               TextField(
//                 controller: nicknameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Nickname',
//                 ),
//               ),
//               TextField(
//                 controller: passwordController,
//                 decoration: const InputDecoration(
//                   labelText: 'Password',
//                 ),
//                 obscureText: true,
//               ),
//               TextField(
//                 controller: emailController,
//                 decoration: const InputDecoration(
//                   labelText: 'Email',
//                 ),
//               ),
//               TextField(
//                 controller: heightController,
//                 decoration: const InputDecoration(
//                   labelText: 'Height',
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 controller: weightController,
//                 decoration: const InputDecoration(
//                   labelText: 'Weight',
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//               DropdownButtonFormField<String>(
//                 value: selectedGender,
//                 decoration: const InputDecoration(
//                   labelText: 'Gender',
//                 ),
//                 items: const [
//                   DropdownMenuItem<String>(
//                     value: '0',
//                     child: Text('Male'),
//                   ),
//                   DropdownMenuItem<String>(
//                     value: '1',
//                     child: Text('Female'),
//                   ),
//                 ],
//                 onChanged: (value) {
//                   setState(() {
//                     selectedGender = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: signUp,
//                 child: const Text('Sign Up'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
