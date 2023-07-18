import 'package:flutter/material.dart';

import 'package:kkn_/login/login_ui.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginUi()));
}
