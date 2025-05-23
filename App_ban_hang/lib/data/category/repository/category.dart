import 'package:dartz/dartz.dart';
import '../../../domain/category/repository/category.dart';
import '../models/category.dart';

class CategoryRepositoryImpl extends CategoryRepository {

  @override
  Future<Either> getCategories() async {
    try {
      // Dữ liệu local
      var categories = [
        CategoryModel(
            title: 'T-Shirt',
            categoryId: '1',
            image: 'assets/images/categories/tshirt.webp'
        ),
        CategoryModel(
            title: 'Polo-Shirt',
            categoryId: '2',
            image: 'assets/images/categories/poloshirt.jpg'
        ),
        CategoryModel(
            title: 'Croptop',
            categoryId: '3',
            image: 'assets/images/categories/croptop.jpg'
        ),
        CategoryModel(
            title: 'Hoodie',
            categoryId: '4',
            image: 'assets/images/categories/hoodie.png'
        ),
        CategoryModel(
            title: 'Sweater',
            categoryId: '5',
            image: 'assets/images/categories/sweater.jpg'
        ),
        CategoryModel(
            title: 'Blouse',
            categoryId: '6',
            image: 'assets/images/categories/blouse.jpg'
        ),
        CategoryModel(
            title: 'Turtleneck',
            categoryId: '7',
            image: 'assets/images/categories/turtleneck.jpg'
        ),
      ];

      return Right(categories.map((e) => e.toEntity()).toList());
    } catch (e) {
      return const Left('Lỗi khi lấy danh mục từ local');
    }
  }
}

