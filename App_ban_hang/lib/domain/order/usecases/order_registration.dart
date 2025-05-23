import 'package:dartz/dartz.dart';
import '../../../core/usecase/usecase.dart';
import '../../../data/order/models/order_registration_req.dart';
import '../../../service_locator.dart';
import '../repository/order.dart';


class OrderRegistrationUseCase implements UseCase<Either,OrderRegistrationReq> {
  @override
  Future<Either> call({OrderRegistrationReq ? params}) async {
    return sl<OrderRepository>().orderRegistration(params!);
  }

}