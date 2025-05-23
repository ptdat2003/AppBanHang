import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/order/repository/order.dart';
import '../../../service_locator.dart';
import '../models/add_to_cart_req.dart';
import '../models/order.dart';
import '../models/order_registration_req.dart';
import '../models/product_ordered.dart';

// Danh sách giỏ hàng local
List<ProductOrderedModel> _cartItems = [];
// Danh sách đơn hàng local
List<OrderModel> _orders = [];

class OrderRepositoryImpl extends OrderRepository {
  @override
  Future<Either> addToCart(AddToCartReq addToCartReq) async {
    try {
      // Lấy user hiện tại từ Firebase
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return const Left('Bạn cần đăng nhập để thêm vào giỏ hàng');
      }
      
      // Thêm vào Firestore
      await FirebaseFirestore.instance.collection('Users')
      .doc(user.uid)
      .collection('Cart').add(
        addToCartReq.toMap()
      );
      
      return const Right('Thêm vào giỏ hàng thành công');
    } catch(e) {
      return const Left('Vui lòng thử lại.');
    }
  }

  @override
  Future<Either> getCartProducts() async {
    try {
      // Lấy user hiện tại từ Firebase
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return const Left('Bạn cần đăng nhập để xem giỏ hàng');
      }
      
      // Lấy dữ liệu từ Firestore
      var returnedData = await FirebaseFirestore.instance.collection(
        'Users'
      ).doc(user.uid).collection('Cart').get();
      
      List<Map> products = [];
      for(var item in returnedData.docs){
        var data = item.data();
        data.addAll({'id' : item.id});
        products.add(data);
      }
      
      return Right(
        List.from(products).map((e) => ProductOrderedModel.fromMap(e).toEntity()).toList()
      );
    } catch (e) {
      return const Left('Vui lòng thử lại');
    }
  }

  @override
  Future<Either> removeCartProduct(String id) async {
    try {
      // Lấy user hiện tại từ Firebase
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return const Left('Bạn cần đăng nhập để xóa sản phẩm');
      }
      
      // Xóa từ Firestore
      await FirebaseFirestore.instance.collection(
        'Users'
      ).doc(user.uid).collection('Cart').doc(
        id
      ).delete();
      
      return const Right('Xóa sản phẩm thành công');
    } catch (e) {
      return const Left('Vui lòng thử lại');
    }
  }

  @override
  Future<Either> orderRegistration(OrderRegistrationReq order) async {
    try {
      // Lấy user hiện tại từ Firebase
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return const Left('Bạn cần đăng nhập để đặt hàng');
      }
      
      // Thêm vào Firestore
      await FirebaseFirestore.instance.collection(
        'Users'
      ).doc(user.uid).collection('Orders').add(
        order.toMap()
      );

      // Xóa các sản phẩm đã đặt hàng khỏi giỏ hàng
      for (var item in order.products) {
        await FirebaseFirestore.instance.collection(
          'Users'
        ).doc(user.uid).collection('Cart').doc(item.id).delete();
      }

      return const Right('Đăng ký đơn hàng thành công');
    } catch (e) {
      return const Left('Vui lòng thử lại');
    }
  }

  @override
  Future<Either> getOrders() async {
    try {
      // Lấy user hiện tại từ Firebase
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return const Left('Bạn cần đăng nhập để xem đơn hàng');
      }
      
      // Lấy dữ liệu từ Firestore
      var returnedData = await FirebaseFirestore.instance.collection(
        "Users"
      ).doc(user.uid).collection('Orders').get();
      
      List<OrderModel> orders = [];
      
      for (var doc in returnedData.docs) {
        try {
          Map<String, dynamic> data = doc.data();
          // Thêm ID của document vào dữ liệu
          data['id'] = doc.id;
          
          // Xử lý trường hợp products là một mảng
          if (data['products'] is List) {
            List<ProductOrderedModel> productsList = [];
            for (var product in data['products']) {
              try {
                productsList.add(ProductOrderedModel.fromMap(product));
              } catch (e) {
                print('Lỗi khi chuyển đổi sản phẩm: $e');
              }
            }
            
            // Tạo OrderModel với dữ liệu đã xử lý
            OrderModel order = OrderModel(
              id: data['id'],
              products: productsList,
              createdDate: data['createdDate'] ?? DateTime.now().toString(),
              totalAmount: (data['totalAmount'] is int) 
                ? (data['totalAmount'] as int).toDouble() 
                : (data['totalAmount'] as double? ?? 0.0),
              shippingAddress: data['shippingAddress'] ?? "",
              itemCount: data['itemCount'] ?? productsList.length,
              code: data['code'] ?? "",
              orderStatus: []
            );
            
            orders.add(order);
          }
        } catch (e) {
          print('Lỗi khi xử lý đơn hàng: $e');
        }
      }
      
      if (orders.isEmpty) {
        return const Left('Không có đơn hàng nào');
      }
      
      return Right(orders.map((e) => e.toEntity()).toList());
    } catch (e) {
      print('Lỗi khi lấy đơn hàng: $e');
      return const Left('Vui lòng thử lại');
    }
  }
  
  @override
  Future<Either> deleteOrder(String id) async {
    try {
      // Lấy user hiện tại từ Firebase
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return const Left('Bạn cần đăng nhập để xóa đơn hàng');
      }
      
      // Xóa đơn hàng từ Firestore
      await FirebaseFirestore.instance.collection(
        "Users"
      ).doc(user.uid).collection('Orders').doc(id).delete();
      
      return const Right('Xóa đơn hàng thành công');
    } catch (e) {
      print('Lỗi khi xóa đơn hàng: $e');
      return const Left('Vui lòng thử lại');
    }
  }
}