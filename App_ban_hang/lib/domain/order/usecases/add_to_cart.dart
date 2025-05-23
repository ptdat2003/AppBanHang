import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/order/models/add_to_cart_req.dart';
import '../../../service_locator.dart';
import '../repository/order.dart';


class AddToCartUseCase implements UseCase<Either,AddToCartReq> {
  @override
  Future<Either> call({AddToCartReq ? params}) async {
    return sl<OrderRepository>().addToCart(params!);
  }

}