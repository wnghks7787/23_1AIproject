import 'package:flutter/material.dart';

class NextScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final String? message = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Text(message ?? 'No message'), // 전달된 문자열 변수 사용
      ),
    );
  }
}
