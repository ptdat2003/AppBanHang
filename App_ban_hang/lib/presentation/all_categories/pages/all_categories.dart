import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/categories/categories_display_cubit.dart';
import '../../../common/bloc/categories/categories_display_state.dart';
import '../../../common/helper/images/image_display.dart';
import '../../../common/helper/navigator/app_navigator.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/category/entity/category.dart';
import '../../category_products/pages/category_products.dart';

class AllCategoriesPage extends StatelessWidget {
  const AllCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh mục', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocProvider(
        create: (context) => CategoriesDisplayCubit()..displayCategories(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shopByCategories(),
              const SizedBox(height: 16),
              _categories()
            ],
          ),
        ),
      ),
    );
  }

  Widget _shopByCategories() {
    return const Text(
      'Tất cả danh mục',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22
      ),
    );
  }

  Widget _categories() {
    return BlocBuilder<CategoriesDisplayCubit,CategoriesDisplayState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(
            child: CircularProgressIndicator()
          );
        }
        if (state is CategoriesLoaded) {
          return Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => CategoryProductsPage(categoryEntity: state.categories[index])
                      )
                    );
                  },
                  child: Container(
                    height: 70,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.secondBackground,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: ImageDisplayHelper.generateCategoryImage(
                                state.categories[index].image
                              )
                            )
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          state.categories[index].title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: state.categories.length
            ),
          );
        }
        return Container();
      },
    );
  }
} 