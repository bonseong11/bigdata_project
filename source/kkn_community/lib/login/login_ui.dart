import 'package:flutter/material.dart';
import 'package:kkn_/connect/connect.dart';
import 'package:kkn_/home/home_dto.dart';
import 'dart:convert';

import 'package:kkn_/signup/signup_ui.dart';
import 'package:kkn_/home/home_screen.dart';
import 'package:kkn_/login/login_dto.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({Key? key}) : super(key: key);

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  LoginDto member = LoginDto("", "");

  bool obscurePassword = true;
  String errorMessage = '';

  void login() async {
    if (loginFormValidate()) {
      Connect connect = Connect();

      String body = json.encode(member.toJson());

      dynamic response = await connect.sendProcess("/login", body);

      if (bool.parse(response)) {
        response = await connect.sendProcess("/", member.userid);

        navigateToHome(HomeDto.fromJson(json.decode(response)));
      } else {
        setState(() {
          errorMessage = "ID 또는 Password를 잘못 입력하셨습니다. 다시 입력해주세요.";
        });
      }
    }
  }

  bool loginFormValidate() {
    if (member.userid == "") {
      setState(() {
        errorMessage = "ID를 입력해주세요.";
      });

      return false;
    } else if (member.password == "") {
      setState(() {
        errorMessage = "password를 입력해주세요.";
      });

      return false;
    }

    return true;
  }

  void navigateToHome(HomeDto homeDto) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => HomeScreen(homeDto: homeDto)));
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
                  const Align(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                      width: 300,
                      height: 200,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: TextEditingController(text: member.userid),
                      onChanged: (value) {
                        member.userid = value;
                      },
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
                      controller: TextEditingController(text: member.password),
                      onChanged: (value) {
                        member.password = value;
                      },
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
                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.yellow),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: const Text('Login'),
                      ),
                      const SizedBox(width: 50.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupUi()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
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
