import 'package:flutter/material.dart';

import '../../../common/helper/navigator/app_navigator.dart';
import '../../../common/widgets/button/basic_app_button.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../presentation/home/pages/home.dart';

class OrderDeleteSuccessPage extends StatelessWidget {
  const OrderDeleteSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Expanded(
            child: Center(
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.white,
                size: 120,
              ),
            ),
          ),
          Container(
            height: 300,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: AppColors.secondBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Xóa đơn hàng thành công',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Đơn hàng của bạn đã được xóa khỏi hệ thống',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey
                  ),
                ),
                const SizedBox(height: 30),
                BasicAppButton(
                  title: 'Quay về trang chủ',
                  onPressed: () {
                    // Xóa toàn bộ stack và điều hướng đến trang chủ
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false,
                    );
                  } 
                )
              ],
            ),
          )
        ],
      ),
    );
  }
} 