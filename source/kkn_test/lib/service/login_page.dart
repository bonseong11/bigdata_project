// import 'package:flutter/material.dart';
// import 'package:kkn_test/home/home_screen.dart';
// import '../provider/login_provider.dart';
// import 'signup_page.dart';
// import 'package:provider/provider.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _idController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   void _login(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final id = _idController.text;
//     final password = _passwordController.text;

//     final currentContext = context;

//     authProvider.login(id, password).then((success) {
//       if (success) {
//         Navigator.push(
//           currentContext,
//           MaterialPageRoute(
//             builder: (_) => const HomeScreen(),
//           ),
//         );
//       } else {
//         showDialog(
//           context: currentContext,
//           builder: (_) => AlertDialog(
//             title: const Text('Login Failed'),
//             content: const Text('Invalid ID or password.'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(currentContext),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'ID',
//                       style: TextStyle(fontSize: 16, color: Colors.grey[50]),
//                     ),
//                     const SizedBox(height: 8),
//                     TextFormField(
//                       controller: _idController,
//                       showCursor: false,
//                       textCapitalization: TextCapitalization.sentences,
//                       decoration: InputDecoration(
//                         hintText: 'id',
//                         hintStyle: TextStyle(color: Colors.grey.shade600),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(
//                             style: BorderStyle.solid,
//                             color: Colors.grey.shade800,
//                           ),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.pink.shade300, width: 2.0),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         fillColor: Colors.grey[900],
//                         filled: true,
//                         contentPadding: const EdgeInsets.all(19),
//                       ),
//                       style: TextStyle(color: Colors.grey[50], fontSize: 17),
//                     ),
//                     const SizedBox(height: 22),
//                     Text(
//                       'Password',
//                       style: TextStyle(fontSize: 16, color: Colors.grey[50]),
//                     ),
//                     const SizedBox(height: 8),
//                     TextFormField(
//                       controller: _passwordController,
//                       showCursor: false,
//                       obscureText: true,
//                       textCapitalization: TextCapitalization.sentences,
//                       decoration: InputDecoration(
//                         hintText: 'Enter your password',
//                         hintStyle: TextStyle(color: Colors.grey.shade600),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(
//                             style: BorderStyle.solid,
//                             color: Colors.grey.shade800,
//                           ),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.pink.shade300, width: 2.0),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         fillColor: Colors.grey[900],
//                         filled: true,
//                         contentPadding: const EdgeInsets.all(19),
//                       ),
//                       style: TextStyle(color: Colors.grey[50], fontSize: 17),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       alignment: Alignment.centerRight,
//                       child: InkWell(
//                         onTap: () {},
//                         child: Text(
//                           'Forgot Password',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.pink.shade300,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => _login(context),
//                     child: const Text('Login'),
//                   ),
//                   const SizedBox(width: 16.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const SignUpPage()),
//                       );
//                     },
//                     child: const Text('Signup'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
