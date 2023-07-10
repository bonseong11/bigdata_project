import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

import '../home/home_screen.dart';
import '../models/health_record_model.dart';
import '../signup/signup_page.dart';
import 'login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final logger = Logger();

  TextEditingController useridController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String loginErrorMessage = '';
  bool obscurePassword = true;

  LoginModel member = LoginModel("", "");

  String userid = '';
  List<HealthRecord> healthRecords = [];

  void login() async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var url = 'http://192.168.41.204:8080/member/login';
    member.userid = useridController.text;
    member.password = passwordController.text;
    String body = json.encode(member.toJson());

    try {
      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        if (bool.parse(response.body)) {
          userid = member.userid;
          var healthRecordsUrl =
              'http://192.168.41.204:8080/health/member/$userid';
          var healthRecordsResponse =
              await http.get(Uri.parse(healthRecordsUrl));
          if (healthRecordsResponse.statusCode == 200) {
            List<dynamic> healthRecordsData =
                json.decode(healthRecordsResponse.body);
            healthRecords = healthRecordsData
                .map((record) => HealthRecord.fromJson(record))
                .toList();
          }
          navigateToHome(userid);
        } else {
          logger.e("로그인 실패");
          setState(() {
            loginErrorMessage = "로그인 실패! 다시 시도해주세요.";
          });
        }
      } else {
        logger.e("로그인 요청 실패");
      }
    } catch (exception) {
      logger.e(exception);
    }
  }

  void navigateToHome(String userid) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              HomeScreen(userid: userid, healthRecords: healthRecords)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Align(
                  //   alignment: Alignment.center,
                  //   child: Image(
                  //     image: AssetImage('assets/images/logo.png'),
                  //     width: 300, // 이미지의 너비 조정
                  //     height: 200, // 이미지의 높이 조정
                  //   ),
                  // ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: useridController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'ID',
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(Icons.person_outline,
                            color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(Icons.password_outlined,
                            color: Colors.white),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          icon: obscurePassword
                              ? const Icon(Icons.visibility_outlined,
                                  color: Colors.white)
                              : const Icon(Icons.visibility_off_outlined,
                                  color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (loginErrorMessage.isNotEmpty)
                    Text(
                      loginErrorMessage,
                      style: const TextStyle(color: Colors.yellow),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // 버튼 색상을 검정색으로 설정
                        ),
                        child: const Text('Login'),
                      ),
                      const SizedBox(width: 50.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // 버튼 색상을 검정색으로 설정
                        ),
                        child: const Text('Signup'),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
