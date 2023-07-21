import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final DateTime selectedDate;

  const Chart({Key? key, required this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy년 MM월 dd일').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          formattedDate,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFF181818),
      ),
      backgroundColor: const Color(0xFF181818),
      body: const Center(
        child: Text(''),
      ),
    );
  }
}
