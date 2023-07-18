import 'package:flutter/material.dart';
import 'package:kkn_/connect/connect.dart';
import 'dart:convert';

import 'package:kkn_/login/login_ui.dart';
import 'package:kkn_/signup/signup_dto.dart';

class SignupUi extends StatefulWidget {
  const SignupUi({Key? key}) : super(key: key);

  @override
  State<SignupUi> createState() => _SignupUiState();
}

class _SignupUiState extends State<SignupUi> {
  SignupDto newMember = SignupDto("", "", "", "", "0", "", "", "");

  bool obscurePassword = true;

  void signUp() async {
    String body = json.encode(newMember.toJson());

    Connect connect = Connect();
    dynamic response = await connect.sendProcess("/signup", body);

    if (bool.parse(response)) {
      navigateToLogin();
    }
  }

  void navigateToLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginUi()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 500,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '회원가입',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.065,
              child: TextFormField(
                controller: TextEditingController(text: newMember.userid),
                onChanged: (value) {
                  newMember.userid = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'User ID',
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon:
                      const Icon(Icons.person_outline, color: Colors.white),
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
            const SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.065,
              child: TextFormField(
                controller: TextEditingController(text: newMember.password),
                onChanged: (value) {
                  newMember.password = value;
                },
                obscureText: obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon:
                      const Icon(Icons.password_outlined, color: Colors.white),
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
            const SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.065,
              child: TextFormField(
                controller: TextEditingController(text: newMember.nickname),
                onChanged: (value) {
                  newMember.nickname = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'NickName',
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.edit, color: Colors.white),
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
            const SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.065,
              child: TextFormField(
                controller: TextEditingController(text: newMember.email),
                onChanged: (value) {
                  newMember.email = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon:
                      const Icon(Icons.email_outlined, color: Colors.white),
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
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.065,
                  child: DropdownButtonFormField<String>(
                    value: newMember.gender,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon:
                          const Icon(Icons.account_circle, color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem<String>(
                        value: '0',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem<String>(
                        value: '1',
                        child: Text('Female'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        newMember.gender = value!;
                      });
                    },
                    dropdownColor: Colors.black, // 드롭다운 메뉴의 배경색을 검정색으로 설정
                    style: const TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.white,
                    iconDisabledColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.065,
                  child: TextFormField(
                    controller: TextEditingController(text: newMember.age),
                    onChanged: (value) {
                      newMember.age = value;
                    },
                    keyboardType: TextInputType.name,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Age',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon:
                          const Icon(Icons.cake_outlined, color: Colors.white),
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
              ],
            ),
            const SizedBox(height: 5.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.065,
              child: TextFormField(
                controller: TextEditingController(text: newMember.height),
                onChanged: (value) {
                  newMember.height = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Height',
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon:
                      const Icon(Icons.height_outlined, color: Colors.white),
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
            const SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.065,
              child: TextFormField(
                controller: TextEditingController(text: newMember.weight),
                onChanged: (value) {
                  newMember.weight = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Weight',
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.accessibility_outlined,
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
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text('Sign Up'),
                ),
                const SizedBox(width: 50.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginUi()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
