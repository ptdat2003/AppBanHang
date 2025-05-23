import 'package:dartz/dartz.dart';
import '../../../core/usecase/usecase.dart';
import '../repository/product.dart';

class GetAllProductsUseCase implements UseCase<Either, void> {
  final ProductRepository repository;

  GetAllProductsUseCase(this.repository);

  @override
  Future<Either> call({void params}) async {
    return await repository.getAllProducts();
  }
} 