import 'package:daelim/extensions/context_extension.dart';
import 'package:daelim/helpers/api_helper.dart';
import 'package:daelim/helpers/storage_helper.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _currentPwController = TextEditingController();
  final _newPwController = TextEditingController();
  final _newConfirmPwController = TextEditingController();

  final _currentPwFormKey = GlobalKey<FormState>();
  final _newPwFormKey = GlobalKey<FormState>();
  final _newConfirmPwFormKey = GlobalKey<FormState>();

  bool _obscureCurrent = true;
  bool _obscureNewCurrent = true;
  bool _obscureNewConfirmCurrent = true;

  final _bgColor = const Color(0xFFF3F4F6);

  String _currentPasswordValidateMsg = '';

  @override
  void dispose() {
    _currentPwController.dispose();
    _newPwController.dispose();
    _newConfirmPwController.dispose();
    super.dispose();
  }

  // NOTE: 입력란 검증
  /// - Empty value 체크
  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return '이 입력란을 작성하세요.';
    }

    return null;
  }

  // NOTE: 비밀번호 변경
  void _onChangedPassword() async {
    setState(() => _currentPasswordValidateMsg = '');

    final currentValidate = _currentPwFormKey.currentState?.validate() ?? false;
    final newValidate = _newPwFormKey.currentState?.validate() ?? false;
    final newConfirmValidate =
        _newConfirmPwFormKey.currentState?.validate() ?? false;

    if (!currentValidate || !newValidate || !newConfirmValidate) {
      return;
    }

    final currentPassword = _currentPwController.text;
    final newPassword = _newPwController.text;

    Log.green('비밀번호 변경 시작');

    // TODO: 현재 비밀번호 검사 -> 검사 실패 시 에러 표시
    final authData = await ApiHelper.signIn(
      email: StorageHelper.authData!.email,
      password: currentPassword,
    );

    if (authData == null) {
      return setState(() {
        _currentPasswordValidateMsg = '현재 비밀번호가 일치하지 않습니다.';
      });
    }

    Log.green('비밀번호 검사 결과: ${authData != null}');

    // TODO: 새로운 비밀번호로 변경 -> 성공 후 로그아웃 및 로그인 화면으로 이동
  }

  // NOTE: 패스워드 입력 위젯
  Widget _buildTextField({
    required Key formKey,
    required TextEditingController textController,
    required String hintText,
    bool obscureText = true,
    String? Function(String? value)? validator,
    VoidCallback? onObscurePressed,
  }) {
    return ListTile(
      dense: true,
      title: Form(
        key: formKey,
        child: TextFormField(
          controller: textController,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            filled: false,
            suffixIcon: InkWell(
              onTap: onObscurePressed,
              child: Icon(
                obscureText //
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: _bgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '비밀번호 변경',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            30.heightBox,
            Card(
              elevation: 0,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: context.theme.dividerColor,
                ),
              ),
              child: Column(
                children: ListTile.divideTiles(
                  tiles: [
                    _buildTextField(
                      formKey: _currentPwFormKey,
                      textController: _currentPwController,
                      hintText: '현재 비밀번호',
                      obscureText: _obscureCurrent,
                      validator: (value) {
                        return _validator(value);
                      },
                      onObscurePressed: () {
                        setState(() {
                          _obscureCurrent = !_obscureCurrent;
                        });
                      },
                    ),
                    Container(
                      height: 20,
                      color: _bgColor,
                      // TODO: 오류 수정
                      // _currentPasswordValidateMsg: ,
                    ),
                    _buildTextField(
                        formKey: _newPwFormKey,
                        textController: _newPwController,
                        hintText: '새 비밀번호',
                        obscureText: _obscureNewCurrent,
                        validator: _validator,
                        onObscurePressed: () {
                          setState(() {
                            _obscureNewCurrent = !_obscureNewCurrent;
                          });
                        }),
                    _buildTextField(
                        formKey: _newConfirmPwFormKey,
                        textController: _newConfirmPwController,
                        hintText: '새 비밀번호 확인',
                        obscureText: _obscureNewConfirmCurrent,
                        validator: (value) {
                          final isEmptyValidate = _validator(value);

                          if (isEmptyValidate != null) {
                            return isEmptyValidate;
                          }

                          final newPassword = _newPwController.text;

                          if (value != newPassword) {
                            return '비밀번호가 일치하지 않습니다.';
                          }
                          return null;
                        },
                        onObscurePressed: () {
                          setState(() {
                            _obscureNewConfirmCurrent =
                                !_obscureNewConfirmCurrent;
                          });
                        }),
                  ],
                  context: context,
                ).toList(),
              ),
            ),
            20.heightBox,
            // NOTE: 비밀번호 변경 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E46DC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _onChangedPassword,
              child: const Text(
                '변경하기',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
