import 'dart:convert';

import 'package:daelim/config.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // NOTE: 로그인 API 호출
  void _onFetchedApi() async {
    final response = await http.post(
      Uri.parse(authUrl),
      body: {
        'email': '',
        'password': '',
      },
    );
    // response 처리
    if (response.statusCode == 200) {
      // 요청이 성공적으로 완료되었을 때 처리할 내용
      final data = json.decode(response.body);
      print('요청 성공: ${data['message']}');
    } else {
      // 요청이 실패했을 때 처리할 내용
      print('요청 실패: ${response.statusCode}');
      print('응답 내용: ${response.body}');
    }

    // Log.green({
    //   'status': response.statusCode,
    //   'body': response.body,
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              _onFetchedApi();
            },
            child: const Text('API 호출'),
          ),
        ),
      ),
    );
  }
}
