import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../domain/product/entities/product.dart';
import '../models/product.dart';

abstract class ProductFirebaseService {
  Future<Either> getTopSelling();
  Future<Either> getNewIn();
  Future<Either> getProductsByCategoryId(String categoryId);
  Future<Either> getProductsByTitle(String title);
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity product);
  Future<bool> isFavorite(String productId);
  Future<Either> getFavoritesProducts();
}

class ProductFirebaseServiceImpl extends ProductFirebaseService {

  @override
  Future < Either > getTopSelling() async {
    try {
      var returnedData = await FirebaseFirestore.instance.collection(
          'Products'
      ).where(
          'salesNumber',
          isGreaterThanOrEqualTo: 20
      ).get();
      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left(
          'Please try again'
      );
    }
  }

  @override
  Future<Either> getNewIn() async {
    try {
      var returnedData = await FirebaseFirestore.instance.collection(
          'Products'
      ).where(
          'createdDate',
          isGreaterThanOrEqualTo: DateTime(2024,07,25)
      ).get();
      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left(
          'Please try again'
      );
    }
  }


  @override
  Future<Either> getProductsByCategoryId(String categoryId) async {
    try {
      var returnedData = await FirebaseFirestore.instance.collection(
          'Products'
      ).where(
          'categoryId',
          isEqualTo: categoryId
      ).get();
      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left(
          'Please try again'
      );
    }
  }

  @override
  Future<Either> getProductsByTitle(String title) async {
    try {
      var returnedData = await FirebaseFirestore.instance.collection(
          'Products'
      ).where(
        'title',
        isGreaterThanOrEqualTo: title,
      )
          .get();
      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left(
          'Please try again'
      );
    }
  }

  @override
  Future < Either > addOrRemoveFavoriteProduct(ProductEntity product) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return const Left('Bạn cần đăng nhập để thực hiện thao tác này');
      }
      
      var products = await FirebaseFirestore.instance.collection(
          "Users"
      ).doc(user.uid).collection('Favorites').where(
          'productId', isEqualTo: product.productId
      ).get();

      if (products.docs.isNotEmpty) {
        // Xóa khỏi danh sách yêu thích
        await products.docs.first.reference.delete();
        return const Right(false);
      } else {
        // Thêm vào danh sách yêu thích, đảm bảo lưu đầy đủ thông tin sản phẩm
        Map<String, dynamic> productData = {
          'productId': product.productId,
          'title': product.title,
          'price': product.price,
          'discountedPrice': product.discountedPrice,
          'images': product.images,
          'categoryId': product.categoryId,
          'gender': product.gender,
          'salesNumber': product.salesNumber,
          'createdDate': product.createdDate,
          'sizes': product.sizes,
          'colors': product.colors.map((color) => {
            'title': color.title,
            'rgb': color.rgb,
          }).toList(),
        };
        
        await FirebaseFirestore.instance.collection(
            "Users"
        ).doc(user.uid).collection('Favorites').add(productData);
        return const Right(true);
      }

    } catch (e) {
      return const Left(
          'Vui lòng thử lại'
      );
    }
  }

  @override
  Future < bool > isFavorite(String productId) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var products = await FirebaseFirestore.instance.collection(
          "Users"
      ).doc(user!.uid).collection('Favorites').where(
          'productId', isEqualTo: productId
      ).get();

      if (products.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }

    } catch (e) {
      return false;
    }
  }

  @override
  Future < Either > getFavoritesProducts() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var returnedData = await FirebaseFirestore.instance.collection(
          "Users"
      ).doc(user!.uid).collection('Favorites').get();
      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left(
          'Please try again'
      );
    }
  }


}