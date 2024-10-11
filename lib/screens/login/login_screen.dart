import 'dart:convert';
import 'package:daelim/common/enums/sso_enum.dart';
import 'package:daelim/common/extensions/context_extension.dart';
import 'package:daelim/common/helpers/storage_helper.dart';
import 'package:daelim/common/widgets/gradient_divider.dart';
import 'package:daelim/config.dart';
import 'package:daelim/models/auth_data.dart';
import 'package:daelim/routes/app_screen.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  void _onFetchedApi() async {}

  // NOTE: 패스워드 재설정
  void _onRecoveryPassword() {}

  // NOTE: 로그인 버튼
  void _onSignIn() async {
    final email = _emailController.text;
    final password = _pwController.text;

    final loginData = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(getTokenUrl),
      body: jsonEncode(loginData),
    );

    final statusCode = response.statusCode;
    final body = utf8.decode(response.bodyBytes);

    if (statusCode != 200) {
      if (mounted) {
        return context.showSnackBar(
          content: Text(body),
        );
      }
      return;
    }

    // Log.green(
    //   {
    //     'status': response.statusCode,
    //     'body': response.body,
    //   },
    // );

    // TODO: AuthData로 변환
    final authData = AuthData.fromMap(jsonDecode(body));
    // Log.green(authData);
    await StorageHelper.setAuthData(authData);
    final savedAuthData = StorageHelper.authData;
    Log.green(savedAuthData);

    if (mounted) {
      context.goNamed(AppScreen.main.name);
    }
    // response 처리
    // if (response.statusCode == 200) {
    //   // 요청이 성공적으로 완료되었을 때 처리할 내용
    //   final data = json.decode(response.body);
    //   print('요청 성공: ${data['message']}');
    // } else {
    //   // 요청이 실패했을 때 처리할 내용
    //   print('요청 실패: ${response.statusCode}');
    //   print('응답 내용: ${response.body}');
    // }
  }

  // NOTE: SSO로그인 버튼
  void _onSsoSignIn(SsoEnum type) {
    return context.showSnackBarText('준비 중인 기능입니다.');
    // switch (type) {
    //   case SsoEnum.google:
    //     context.showSnackBarText('구글 로그인 시작');
    //     break;
    //   case SsoEnum.apple:
    //     context.showSnackBarText('준비 중인 기능입니다.');
    //     break;
    //   case SsoEnum.github:
    //     context.showSnackBarText('준비 중인 기능입니다.');
    //     break;
    //   default:
    //     break;
    // }
  }

  // NOTE: 타이틀 텍스트 위젯들
  List<Widget> _buildTitleText() => [
        const Text(
          'Hello Again!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Wellcome back you\'ve \nbeen missed!',
          textAlign: TextAlign.center,
          style: TextStyle(
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

  // NOTE: SSO 버튼 위젯
  Widget _buildSsoButton({
    required String iconUrl,

    // 버튼 클릭에 대한 파라미터 구현
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(10),
        child: Image.network(iconUrl),
      ),
    );
  }

  // 람다 형식 예제
  // bool noLamda() {
  //   return false;
  // }
  // bool lamda() => true;
  // bool get getLamda => true;

  // 메인 화면
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
          child: DefaultTextStyle(
            style: GoogleFonts.raleway(
                color: ThemeData().textTheme.bodyMedium?.color),
            // color: Theme.of(context).brightness == Brightness.dark //
            //   ? Colors.black
            //   : Colors.white;
            child: Center(
              child: SizedBox(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 20.heightBox,                // easy_extension 사용시
                    // double.infinity.widthBox,    // easy_extension 사용시

                    // 타이틀 상단 박스
                    const SizedBox(
                      height: 80,
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
                        child: const Text(
                          'Recovery Password',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),

                    // Recovery Password <-> Sign In
                    const SizedBox(
                      height: 20,
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
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 60,
                    ),

                    // Or continue with
                    const Row(
                      children: [
                        Expanded(
                          child: GradientDivider(),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Or continue with',
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: GradientDivider(
                            reverse: true,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 60,
                    ),

                    // SSO Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSsoButton(
                            onTap: () => _onSsoSignIn(SsoEnum.google),
                            iconUrl: icGoogle),
                        _buildSsoButton(
                            onTap: () => _onSsoSignIn(SsoEnum.apple),
                            iconUrl: icApple),
                        _buildSsoButton(
                            onTap: () => _onSsoSignIn(SsoEnum.github),
                            iconUrl: icGithub),
                      ],
                    ),

                    const SizedBox(
                      height: 60,
                    ),

                    // Column(
                    //   children: [
                    //     Align(
                    //       alignment: Alignment.centerRight,
                    //       child: TextButton(
                    //         onPressed: _onRecoveryPassword,
                    //         child: const Text(
                    //           'Recovery Password',
                    //           style: TextStyle(fontSize: 12),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
