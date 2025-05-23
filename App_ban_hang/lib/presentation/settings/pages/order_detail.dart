import 'package:flutter/material.dart';
import '../../../common/helper/navigator/app_navigator.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/order/entities/order.dart';
import '../../../domain/order/repository/order.dart';
import '../../../service_locator.dart';
import 'order_items.dart';
import 'order_delete_success.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderEntity orderEntity;
  const OrderDetailPage({
    required this.orderEntity,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    String orderId = orderEntity.id.length > 8 ? orderEntity.id.substring(0, 8) : orderEntity.id;
    
    return Scaffold(
      appBar: BasicAppbar(
        title: Text(
          'Chi tiết đơn hàng #$orderId'
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _orderInfo(),
            const SizedBox(height: 30),
            _items(context),
            const SizedBox(height: 30),
            _shipping(),
            const SizedBox(height: 30),
            _deleteButton(context),
          ],
        ),
      )
    );
  }

  Widget _orderInfo() {
    String formattedDate = orderEntity.createdDate.split(' ')[0];
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thông tin đơn hàng',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ngày đặt:',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14
                ),
              ),
              Text(
                formattedDate,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tổng tiền:',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14
                ),
              ),
              Text(
                '${_formatCurrency(orderEntity.totalAmount)}đ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.primary
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Số lượng:',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14
                ),
              ),
              Text(
                '${orderEntity.products.length} sản phẩm',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Trạng thái:',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4)
                ),
                child: const Text(
                  'Đã xác nhận',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _items(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
            'Sản phẩm đã đặt',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
          const SizedBox(height: 15),
           GestureDetector(
            onTap: (){
              AppNavigator.push(context, OrderItemsPage(products: orderEntity.products));
            },
              child: Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.secondBackground,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.shopping_bag_outlined,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '${orderEntity.products.length} sản phẩm',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                            ),
                          )
                        ],
                      ),
                      const Text(
                        'Xem tất cả',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.primary
                        ),
                      )
                    ],
                  ),
              ),
            )
      ],
    );
  }

  Widget _shipping() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
            'Địa chỉ giao hàng',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
          const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.secondBackground,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        orderEntity.shippingAddress,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ],
                )
            )
      ],
    );
  }

  Widget _deleteButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () async {
          // Xóa đơn hàng trực tiếp không cần xác nhận
          final result = await sl<OrderRepository>().deleteOrder(orderEntity.id);
          
          if (context.mounted) {
            if (result.isRight()) {
              // Chuyển đến trang thành công
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const OrderDeleteSuccessPage(),
                ),
              );
            } else {
              // Hiển thị lỗi
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Có lỗi xảy ra khi xóa đơn hàng. Vui lòng thử lại.'),
                ),
              );
            }
          }
        },
        child: const Text(
          'Xóa đơn hàng',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  
  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m.group(1)}.'
    );
  }
}