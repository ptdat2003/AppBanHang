import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/bloc/button/button_state.dart';
import '../../../common/bloc/button/button_state_cubit.dart';
import '../../../common/helper/navigator/app_navigator.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/button/basic_reactive_button.dart';
import '../../../data/auth/models/user_signin_req.dart';
import '../../../domain/auth/usecases/signin.dart';
import '../../home/pages/home.dart';
import 'forgot_password.dart';

class EnterPasswordPage extends StatefulWidget {
  final UserSigninReq signinReq;
  const EnterPasswordPage({
    required this.signinReq,
    super.key
  });

  @override
  State<EnterPasswordPage> createState() => _EnterPasswordPageState();
}

class _EnterPasswordPageState extends State<EnterPasswordPage> {
  final TextEditingController _passwordCon = TextEditingController();
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 40
        ),
        child: BlocProvider(
          create: (context) => ButtonStateCubit(),
          child: BlocListener<ButtonStateCubit,ButtonState>(
            listener: (context, state) {
              if (state is ButtonFailureState){
                setState(() {
                  _passwordError = state.errorMessage;
                });
                // Xóa bất kỳ thông báo nào đang hiển thị ở dưới cùng
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }

              if (state is ButtonSuccessState) {
                AppNavigator.pushAndRemove(context, const HomePage());
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _siginText(context),
                const SizedBox(height: 20,),
                _passwordField(context),
                const SizedBox(height: 20,),
                _continueButton(context),
                const SizedBox(height: 20,),
                _forgotPassword(context),
                // Container rỗng để đẩy lỗi lên trên
                const Spacer(),
              ],
            ),
          ),
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

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordCon,
      obscureText: true,
      onChanged: (_) {
        if (_passwordError != null) {
          setState(() {
            _passwordError = null;
          });
        }
      },
      decoration: InputDecoration(
        hintText: 'Nhập mật khẩu',
        errorText: _passwordError,
        errorStyle: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return BasicReactiveButton(
          onPressed: (){
            widget.signinReq.password = _passwordCon.text;
            context.read<ButtonStateCubit>().execute(
              usecase: SigninUseCase(),
              params: widget.signinReq
            );
          },
          title: 'Tiếp tục'
        );
      }
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return RichText(
      text: TextSpan(
        children:  [
          const TextSpan(
            text: "Quên mật khẩu? "
          ),
           TextSpan(
            text: 'Reset',
            recognizer:TapGestureRecognizer()..onTap = () {
              AppNavigator.push(context, ForgotPasswordPage());
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