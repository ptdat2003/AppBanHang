import 'package:app_ban_hang/domain/order/entities/product_ordered.dart';

import 'order_status.dart';

class OrderEntity {
  final String id;
  final List<ProductOrderedEntity> products;
  final String createdDate;
  final double totalAmount;
  final String shippingAddress;
  final int itemCount;
  final String code;
  final List<OrderStatusEntity> orderStatus;

  OrderEntity({
    required this.id,
    required this.products,
    required this.createdDate, 
    required this.totalAmount,
    required this.shippingAddress, 
    required this.itemCount, 
    required this.code,
    required this.orderStatus
   });
}