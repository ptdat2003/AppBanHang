import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/helper/navigator/app_navigator.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/auth/entity/user.dart';
import '../../cart/pages/cart.dart';
import '../../settings/pages/settings.dart';
import '../bloc/user_info_display_cubit.dart';
import '../bloc/user_info_display_state.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserInfoDisplayCubit()..displayUserInfo(),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 50,
            right: 24,
            left: 24,
            bottom: 10
          ),
          child: BlocBuilder < UserInfoDisplayCubit, UserInfoDisplayState > (
            builder: (context, state) {
              if (state is UserInfoLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is UserInfoLoaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _profileImage(state.user,context),
                    _gender(state.user),
                    _card(context)
                  ],
                );
              }
              return Container();
            },
          ),
      ),
    );
  }

  Widget _profileImage(UserEntity user,BuildContext context) {
    return GestureDetector(
      onTap: (){
        AppNavigator.push(context, const SettingsPage());
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: user.image.isEmpty ?
            const AssetImage(
              AppImages.profile
            ) : NetworkImage(
              user.image
            ) as ImageProvider,
            fit: BoxFit.cover
          ),
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primary,
            width: 2
          )
        ),
      ),
    );
  }

  Widget _gender(UserEntity user) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(
        horizontal: 16
      ),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(100)
      ),
      child: Center(
        child: Text(
          user.gender == 1 ? 'NAM' : 'NỮ',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize:18
          ),
        ),
      ),
    );
  }

  Widget _card(BuildContext context) {
    return GestureDetector(
      onTap: (){
        AppNavigator.push(context,const CartPage());
      },
      child: Container(
        height: 58,
        width: 58,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 1
          )
        ),
        child: SvgPicture.asset(
          AppVectors.bag,
          fit: BoxFit.none,
        ),
      ),
    );
  }
}