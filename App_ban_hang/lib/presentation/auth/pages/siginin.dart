import 'package:app_ban_hang/presentation/auth/pages/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../common/helper/navigator/app_navigator.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/button/basic_app_button.dart';
import '../../../data/auth/models/user_signin_req.dart';
import '../../../domain/auth/usecases/check_email_exists.dart';
import '../../../service_locator.dart';
import 'enter_password.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailCon = TextEditingController();
  String? _emailError;
  bool _isLoading = false;

  // Kiểm tra định dạng email
  bool _isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  // Xác thực email và cập nhật lỗi nếu có
  bool _validateEmail() {
    if (_emailCon.text.isEmpty) {
      setState(() {
        _emailError = 'Email không được để trống';
      });
      return false;
    } else if (!_isValidEmail(_emailCon.text)) {
      setState(() {
        _emailError = 'Email không đúng định dạng';
      });
      return false;
    } else {
      setState(() {
        _emailError = null;
      });
      return true;
    }
  }

  // Kiểm tra email có tồn tại trong hệ thống không
  Future<void> _checkEmailAndProceed() async {
    if (!_validateEmail()) {
      return;
    }
    
    setState(() {
      _isLoading = true;
    });

    final result = await sl<CheckEmailExistsUseCase>().call(params: _emailCon.text.trim());

    setState(() {
      _isLoading = false;
    });

    // Xử lý kết quả kiểm tra
    result.fold(
      (error) {
        // Email không tồn tại hoặc có lỗi
        setState(() {
          _emailError = error;
        });
      },
      (success) {
        // Email tồn tại, chuyển đến trang nhập mật khẩu
        AppNavigator.push(
          context,
          EnterPasswordPage(
            signinReq: UserSigninReq(
              email: _emailCon.text.trim(),
            ),
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(hideBack: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 40
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _siginText(context),
            const SizedBox(height: 20,),
            _emailField(context),
            const SizedBox(height: 20,),
            _continueButton(context),
            const SizedBox(height: 20,),
            _createAccount(context)
          ],
        ),
      ),
    );
  }

  Widget _siginText(BuildContext context) {
    return const Text(
      'Đăng nhập',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _emailCon,
      keyboardType: TextInputType.emailAddress,
      onChanged: (_) {
        if (_emailError != null) {
          setState(() {
            _emailError = null;
          });
        }
      },
      decoration: InputDecoration(
        hintText: 'Nhập Email',
        errorText: _emailError,
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return _isLoading
      ? const Center(child: CircularProgressIndicator())
      : BasicAppButton(
          onPressed: _checkEmailAndProceed,
          title: 'Tiếp tục'
        );
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
      text: TextSpan(
        children:  [
          const TextSpan(
            text: "Bạn có đã tài khoản chưa? "
          ),
           TextSpan(
            text: 'Tạo tài khoản',
            recognizer:TapGestureRecognizer()..onTap = () {
              AppNavigator.push(context, const SignupPage());
            } ,
            style: const TextStyle(
              fontWeight: FontWeight.bold
            )
          )
        ]
      ),
    );
  }
}