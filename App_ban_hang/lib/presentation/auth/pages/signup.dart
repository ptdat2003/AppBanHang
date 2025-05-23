import 'package:app_ban_hang/presentation/auth/pages/siginin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../common/helper/navigator/app_navigator.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/button/basic_app_button.dart';
import '../../../data/auth/models/user_creation_req.dart';
import 'gender_and_age_selection.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _firstNameCon = TextEditingController();
  final TextEditingController _lastNameCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _passwordError;

  // Kiểm tra định dạng email
  bool _isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  // Kiểm tra độ mạnh của mật khẩu
  bool _isValidPassword(String password) {
    // Mật khẩu ít nhất 6 ký tự
    return password.length >= 6;
  }

  // Kiểm tra thông tin đăng ký và cập nhật lỗi
  bool _validateForm() {
    bool isValid = true;

    setState(() {
      // Kiểm tra họ
      if (_firstNameCon.text.trim().isEmpty) {
        _firstNameError = 'Vui lòng nhập họ';
        isValid = false;
      } else {
        _firstNameError = null;
      }

      // Kiểm tra tên
      if (_lastNameCon.text.trim().isEmpty) {
        _lastNameError = 'Vui lòng nhập tên';
        isValid = false;
      } else {
        _lastNameError = null;
      }

      // Kiểm tra email
      if (_emailCon.text.trim().isEmpty) {
        _emailError = 'Email không được để trống';
        isValid = false;
      } else if (!_isValidEmail(_emailCon.text.trim())) {
        _emailError = 'Email không đúng định dạng';
        isValid = false;
      } else {
        _emailError = null;
      }

      // Kiểm tra mật khẩu
      if (_passwordCon.text.isEmpty) {
        _passwordError = 'Mật khẩu không được để trống';
        isValid = false;
      } else if (!_isValidPassword(_passwordCon.text)) {
        _passwordError = 'Mật khẩu phải có ít nhất 6 ký tự';
        isValid = false;
      } else {
        _passwordError = null;
      }
    });

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 40
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _siginText(),
            const SizedBox(height: 20,),
            _firstNameField(),
            const SizedBox(height: 20,),
            _lastNameField(),
            const SizedBox(height: 20,),
            _emailField(),
            const SizedBox(height: 20,),
            _passwordField(context),
            const SizedBox(height: 20,),
            _continueButton(context),
            const SizedBox(height: 20,),
            _createAccount(context)
          ],
        ),
      ),
    );
  }

  Widget _siginText() {
    return const Text(
      'Tạo tài khoản',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _firstNameField() {
    return TextField(
      controller: _firstNameCon,
      onChanged: (_) => setState(() => _firstNameError = null),
      decoration: InputDecoration(
        hintText: 'Họ',
        errorText: _firstNameError,
      ),
    );
  }

  Widget _lastNameField() {
    return TextField(
      controller: _lastNameCon,
      onChanged: (_) => setState(() => _lastNameError = null),
      decoration: InputDecoration(
        hintText: 'Tên',
        errorText: _lastNameError,
      ),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailCon,
      keyboardType: TextInputType.emailAddress,
      onChanged: (_) => setState(() => _emailError = null),
      decoration: InputDecoration(
        hintText: 'Địa chỉ Email',
        errorText: _emailError,
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordCon,
      obscureText: true,
      onChanged: (_) => setState(() => _passwordError = null),
      decoration: InputDecoration(
        hintText: 'Mật khẩu',
        errorText: _passwordError,
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return BasicAppButton(
      onPressed: (){
        if (_validateForm()) {
          AppNavigator.push(
            context,
            GenderAndAgeSelectionPage(
              userCreationReq: UserCreationReq(
                firstName: _firstNameCon.text.trim(),
                email: _emailCon.text.trim(), 
                lastName: _lastNameCon.text.trim(),
                password: _passwordCon.text
              ),
            )
          );
        }
      },
      title: 'Tiếp tục'
    );
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: "Bạn đã có tài khoản chưa? "
          ),
          TextSpan(
            text: 'Đăng nhập',
            recognizer: TapGestureRecognizer()..onTap = () {
              AppNavigator.pushReplacement(context, const SigninPage());
            },
            style: const TextStyle(
              fontWeight: FontWeight.bold
            )
          )
        ]
      ),
    );
  }
}