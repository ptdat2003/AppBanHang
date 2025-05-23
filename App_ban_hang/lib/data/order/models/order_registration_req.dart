import 'package:app_ban_hang/data/order/models/product_ordered.dart';

import '../../../domain/order/entities/product_ordered.dart';

class OrderRegistrationReq {
  final List < ProductOrderedEntity > products;
  final String createdDate;
  final String shippingAddress;
  final int itemCount;
  final double totalAmount;

  OrderRegistrationReq({
    required this.products,
    required this.createdDate,
    required this.itemCount,
    required this.totalAmount,
    required this.shippingAddress
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((e) => e.fromEntity().toMap()).toList(),
      'createdDate': createdDate,
      'itemCount': itemCount,
      'totalAmount': totalAmount,
      'shippingAddress' : shippingAddress
    };
  }

}
