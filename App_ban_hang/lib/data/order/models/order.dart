import '../../../domain/order/entities/order.dart';
import 'order_status.dart';
import 'product_ordered.dart';

class OrderModel {
  final String id;
  final List<ProductOrderedModel> products;
  final String createdDate;
  final double totalAmount;
  final String shippingAddress;
  final int itemCount;
  final String code;
  final List<OrderStatusModel> orderStatus;

  OrderModel({
    required this.id,
    required this.products,
    required this.createdDate,
    required this.totalAmount,
    this.shippingAddress = "",
    this.itemCount = 0,
    this.code = "",
    this.orderStatus = const []
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      products: List<ProductOrderedModel>.from(
          map['products'].map((e) => ProductOrderedModel.fromMap(e))
      ),
      createdDate: map['createdDate'] as String,
      totalAmount: map['totalAmount'] as double,
      shippingAddress: map['shippingAddress'] as String? ?? "",
      itemCount: map['itemCount'] as int? ?? 0,
      code: map['code'] as String? ?? "",
      orderStatus: map['orderStatus'] != null ? 
        List<OrderStatusModel>.from(
          map['orderStatus'].map((e) => OrderStatusModel.fromMap(e))
        ) : const [],
    );
  }
}

extension OrderXModel on OrderModel {
  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      products: products.map((e) => e.toEntity()).toList(),
      createdDate: createdDate,
      totalAmount: totalAmount,
      shippingAddress: shippingAddress,
      itemCount: itemCount,
      code: code,
      orderStatus: orderStatus.map((e) => e.toEntity()).toList(),
    );
  }
}
