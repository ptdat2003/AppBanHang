import 'package:flutter/material.dart';

import '../../../common/helper/images/image_display.dart';
import '../../../domain/product/entities/product.dart';

class ProductImages extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductImages({
    required this.productEntity,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          fit: BoxFit.contain,
          image: ImageDisplayHelper.generateProductImage(
            productEntity.images[0]  // Chỉ sử dụng ảnh đầu tiên
          )
        )
      ),
    );
  }
}