import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/button/button_state.dart';
import '../../../common/bloc/button/button_state_cubit.dart';
import '../../../common/helper/bottomsheet/app_bottomsheet.dart';
import '../../../common/helper/navigator/app_navigator.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/button/basic_reactive_button.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../data/auth/models/user_creation_req.dart';
import '../../../domain/auth/usecases/siginup.dart';
import '../bloc/age_selection_cubit.dart';
import '../bloc/ages_display_cubit.dart';
import '../bloc/gender_selection_cubit.dart';
import '../widgets/ages.dart';
import 'signup_success.dart';

class GenderAndAgeSelectionPage extends StatefulWidget {
  final UserCreationReq userCreationReq;
  const GenderAndAgeSelectionPage({
    required this.userCreationReq,
    super.key
  });

  @override
  State<GenderAndAgeSelectionPage> createState() => _GenderAndAgeSelectionPageState();
}

class _GenderAndAgeSelectionPageState extends State<GenderAndAgeSelectionPage> {
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => GenderSelectionCubit()),
            BlocProvider(create: (context) => AgeSelectionCubit()),
            BlocProvider(create: (context) => AgesDisplayCubit()),
            BlocProvider(create: (context) => ButtonStateCubit())
          ],
          child: BlocListener<ButtonStateCubit,ButtonState>(
            listener: (context, state) {
              if (state is ButtonFailureState){
                setState(() {
                  _errorMessage = state.errorMessage;
                });
                // Ẩn snackbar nếu có
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }
              
              if (state is ButtonSuccessState) {
                // Chuyển hướng đến trang đăng ký thành công
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const SignupSuccessPage()),
                );
              }
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 40
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _tellUs(),
                        const SizedBox(height: 30, ),
                        _genders(context),
                        const SizedBox(height: 30, ),
                        howOld(),
                        const SizedBox(height: 30, ),
                        _age(),
                        const SizedBox(height: 20, ),
                        // Hiển thị thông báo lỗi nếu có
                        if (_errorMessage != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red.shade300)
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _errorMessage!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close, color: Colors.red, size: 18),
                                  onPressed: () {
                                    setState(() {
                                      _errorMessage = null;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
                ),
                const Spacer(),
                  _finishButton(context)
              ],
            ),
          ),
        ),
    );
  }

  Widget _tellUs() {
    return const Text(
      'Giới tính của bạn là gì?',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500
      ),
    );
  }

  Widget _genders(BuildContext context) {
    return BlocBuilder<GenderSelectionCubit,int>(
      builder: (context,state) {
        return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          genderTile(context,1,'Nam'),
          const SizedBox(width: 20,),
          genderTile(context,2,'Nữ'),
        ],
      );
      }

    );
  }

  Expanded genderTile(BuildContext context,int genderIndex,String gender) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: (){
            context.read<GenderSelectionCubit>().selectGender(genderIndex);
            // Xóa thông báo lỗi khi chọn giới tính
            if (_errorMessage != null) {
              setState(() {
                _errorMessage = null;
              });
            }
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: context.read<GenderSelectionCubit>().selectedIndex == genderIndex ?
               AppColors.primary : AppColors.secondBackground,
              borderRadius: BorderRadius.circular(30)
            ),
            child: Center(
              child: Text(
                gender,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16
                ),
              ),
            ),
          ),
        ),
      );
  }

  Widget howOld() {
    return const Text(
      'Bạn trong khoảng độ tuổi nào?',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500
      ),
    );
  }

  Widget _age() {
    return BlocBuilder<AgeSelectionCubit,String>(
      builder: (context,state) {
      return GestureDetector(
        onTap: (){
          AppBottomsheet.display(
            context,
            MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<AgeSelectionCubit>(),),
              BlocProvider.value(value: context.read<AgesDisplayCubit>()..displayAges())
            ],
            child: const Ages()
            )
          );
          // Xóa thông báo lỗi khi mở hộp chọn độ tuổi
          if (_errorMessage != null) {
            setState(() {
              _errorMessage = null;
            });
          }
        },
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.secondBackground,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state
              ),
              const Icon(
                Icons.keyboard_arrow_down
              )
            ],
          ),
        ),
      );
      }
    );
  }

  Widget _finishButton(BuildContext context) {
    return Container(
      height: 100,
      color: AppColors.secondBackground,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Builder(
          builder: (context) {
            return BasicReactiveButton(
              onPressed: (){
                // Kiểm tra điều kiện trước khi đăng ký
                final gender = context.read<GenderSelectionCubit>().selectedIndex;
                final age = context.read<AgeSelectionCubit>().selectedAge;
                
                // Kiểm tra đã chọn giới tính chưa (mặc định là 0, phải chọn 1 hoặc 2)
                if (gender == 0) {
                  setState(() {
                    _errorMessage = "Vui lòng chọn giới tính";
                  });
                  return;
                }
                
                // Kiểm tra đã chọn độ tuổi chưa (mặc định là "Độ tuổi của bạn")
                if (age == "Độ tuổi của bạn" || age.isEmpty) {
                  setState(() {
                    _errorMessage = "Vui lòng chọn độ tuổi";
                  });
                  return;
                }
                
                // Nếu đã chọn đủ thông tin, tiến hành đăng ký
                setState(() {
                  _errorMessage = null;
                });
                
                widget.userCreationReq.gender = gender;
                widget.userCreationReq.age = age;
                context.read<ButtonStateCubit>().execute(
                  usecase: SignupUseCase(),
                  params: widget.userCreationReq
                );
              },
              title: 'Đăng ký'
            );
          }
        ),
      ),
    );
  }
}