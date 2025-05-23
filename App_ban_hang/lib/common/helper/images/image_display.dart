import 'package:flutter/material.dart';
import '../../../core/constants/app_urls.dart';

class ImageDisplayHelper {
  static ImageProvider generateCategoryImage(String assetPath) {
    return AssetImage(assetPath);
  }

  static ImageProvider generateProductImage(String assetPath) {
    if (assetPath.startsWith('assets/')) {
      return AssetImage(assetPath);
    } else {
      return NetworkImage(AppUrl.productImage + assetPath + AppUrl.alt);
    }
  }

  static String generateProductImageURL(String title) {
    return AppUrl.productImage + title + AppUrl.alt;
  }
  
  static ImageProvider getProductImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      return AssetImage(imagePath);
    } else if (imagePath.startsWith('http')) {
      return NetworkImage(imagePath);
    } else {
      // Trường hợp là đường dẫn lưu trong Firebase
      return NetworkImage(AppUrl.productImage + imagePath + AppUrl.alt);
    }
  }
}


