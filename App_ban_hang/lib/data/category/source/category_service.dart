import 'package:dartz/dartz.dart';
import '../models/category.dart';

abstract class CategoryFirebaseService {

  Future<Either> getCategories();
}

class CategoryFirebaseServiceImpl extends CategoryFirebaseService {

  
  @override
  Future < Either > getCategories() async {
    try {
      var categories = [
        CategoryModel(title: 'T-Shirt', categoryId: '1', image: 'assets/images/categories/tshirt.webp'),
        CategoryModel(title: 'Polo-Shirt', categoryId: '2', image: 'assets/images/categories/poloshirt.jpg'),
        CategoryModel(title: 'Croptop', categoryId: '3', image: 'assets/images/categories/croptop.jpg'),
        CategoryModel(title: 'Hoodie', categoryId: '4', image: 'assets/images/categories/hoodie.png'),
        CategoryModel(title: 'Sweater', categoryId: '5', image: 'assets/images/categories/sweater.jpg'),
        CategoryModel(title: 'Blouse', categoryId: '6', image: 'assets/images/categories/blouse.jpg'),
        CategoryModel(title: 'Turtleneck', categoryId: '7', image: 'assets/images/categories/turtleneck.jpg'),
      ];

// Convert sang Entity như cũ
      return Right(categories.map((e) => e.toEntity()).toList());

    } catch (e) {
      return const Left(
        'Please try again'
      );
    }
  }
  
}