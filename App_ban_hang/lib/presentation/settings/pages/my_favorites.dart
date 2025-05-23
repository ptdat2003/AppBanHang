import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/product/products_display_cubit.dart';
import '../../../common/bloc/product/products_display_state.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/product/product_card.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/product/entities/product.dart';
import '../../../domain/product/usecases/get_favorties_products.dart';
import '../../../service_locator.dart';

class MyFavoritesPage extends StatelessWidget {
  const MyFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text(
          'Sản phẩm yêu thích của tôi'
        ),
      ),
      body: BlocProvider(
        create: (context) => ProductsDisplayCubit(useCase: sl<GetFavortiesProductsUseCase>())..displayProducts(),
        child: BlocBuilder<ProductsDisplayCubit,ProductsDisplayState>(
          builder: (context, state) {
            if (state is ProductsLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProductsLoaded) {
              return _products(state.products);
            }

            if (state is LoadProductsFailure){
              return const Center(
                child: Text(
                  'Vui Lòng Thử lại'
                ),
              );
            }

            return Container();
          },
        )
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite_border,
              color: AppColors.primary,
              size: 80,
            ),
            const SizedBox(height: 16),
            const Text(
              'Bạn chưa thêm sản phẩm yêu thích nào',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Hãy thêm sản phẩm vào danh sách yêu thích để xem sau nhé!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.6
          ),
          itemBuilder: (BuildContext context, int index) {
            return ProductCard(productEntity: products[index]);
          },
      ),
    );
  }
}