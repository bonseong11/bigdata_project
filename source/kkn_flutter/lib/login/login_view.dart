import 'package:flutter/material.dart';
import 'package:kkn/home/dto/home_response_dto.dart';

import 'package:kkn/login/login_input_dto.dart';
import 'package:kkn/login/login_controller.dart';
import 'package:kkn/home/home_controller.dart';
import 'package:kkn/home/dto/home_dto.dart';
import 'package:kkn/home/home_view.dart';
import 'package:kkn/signup/signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginInputDto member = LoginInputDto("", "");

  bool obscurePassword = true;
  String errorMessage = "";

  void loginProcess() async {
    LoginController loginController = LoginController();

    errorMessage = await loginController.memberLogin(member);

    if (errorMessage.isEmpty) {
      homePrepareProcess(member.userid);
    } else {
      setState(() {});
    }
  }

  void homePrepareProcess(String userid) async {
    HomeController homeController = HomeController();

    HomeResponseDto homeResponseDto =
        await homeController.homeInformationLoad(userid);

    if (homeResponseDto.errorMessage.isEmpty) {
      toHome(homeResponseDto.homeDto!);
    } else {
      setState(() {
        errorMessage = homeResponseDto.errorMessage;
      });
    }
  }

  void toHome(HomeDto homeDto) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => HomeView(homeDto: homeDto)));
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
                      image: AssetImage('assets/images/logo.png'),
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
                        labelText: "암호",
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
                        onPressed: loginProcess,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: const Text('로그인'),
                      ),
                      const SizedBox(width: 50.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupView()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: const Text('회원가입'),
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
