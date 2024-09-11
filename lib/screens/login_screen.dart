import 'dart:convert';
import 'package:daelim/config.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  bool _isObscure = true;

  @override
  void dispose();

  // NOTE: 로그인 API 호출
  void _onFetchedApi() async {
    final response = await http.post(
      Uri.parse(authUrl),
      body: {
        'email': '202030416@daelim.ac.kr',
        'password': '202030416',
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

    Log.green(
      {
        'status': response.statusCode,
        'body': response.body,
      },
    );
  }

  // NOTE: 패스워드 재설정
  void _onRecoveryPassword() {}

  // NOTE: 로그인 버튼
  void _onSignIn() {}

  // NOTE: 타이틀 텍스트 위젯들
  List<Widget> _buildTitleText() => [
        Text(
          'Hello Again!',
          style: GoogleFonts.raleway(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Wellcome back you\'ve \nbeen missed!',
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            fontSize: 20,
          ),
        ),
      ];

  // NOTE: 텍스트 입력 위젯들
  List<Widget> _buildTextFields() {
    return [
      _buildTextField(
        controller: _emailController,
        hintText: 'Enter email',
      ),
      const SizedBox(
        height: 10,
      ),
      _buildTextField(
        onObscure: (down) {
          setState(() {
            if (down) {
              _isObscure = false;
            } else {
              _isObscure = true;
            }
          });
        },
        controller: _pwController,
        hintText: 'Password',
        obscure: _isObscure,
      ),
    ];
  }

  // NOTE: 입력폼 위젯
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool? obscure = false,
    Function(bool down)? onObscure,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    );
    return TextField(
      controller: controller,
      // contextMenuBuilder: null, // 복사, 붙어넣기 창 안뜨게 하는 코드
      decoration: InputDecoration(
        fillColor: Colors.white,
        enabledBorder: border,
        focusedBorder: border,
        hintText: hintText,
        suffixIcon: obscure != null
            ? GestureDetector(
                onTapDown: (details) => onObscure?.call(true),
                onTapUp: (details) => onObscure?.call(false),
                child: Icon(
                  obscure ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
      obscureText: obscure ?? false,
    );
  }

  // 람다 형식 예제
  // bool noLamda() {
  //   return false;
  // }
  // bool lamda() => true;
  // bool get getLamda => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFDEDEE2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 20.heightBox,                // easy_extension 사용시
              // double.infinity.widthBox,    // easy_extension 사용시

              // 타이틀 상단 박스
              const SizedBox(
                height: 40,
                // width: double.infinity,    // 초반 자리잡기용
              ),

              // 타이틀
              ..._buildTitleText(),

              // 타이틀 <-> 텍스트 입력창 사이 박스
              const SizedBox(
                height: 50,
              ),

              // 텍스트 입력창
              ..._buildTextFields(),

              // 텍스트 입력창 <-> 로그인 버튼 사이 박스
              const SizedBox(
                height: 20,
              ),

              // Recovery Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _onRecoveryPassword,
                  child: Text(
                    'Recovery Password',
                    style: GoogleFonts.raleway(fontSize: 12),
                  ),
                ),
              ),

              // Sign In Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onSignIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE46A61),
                    padding: const EdgeInsets.symmetric(
                      vertical: 25,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
