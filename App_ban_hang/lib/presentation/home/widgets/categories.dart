import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/categories/categories_display_cubit.dart';
import '../../../common/bloc/categories/categories_display_state.dart';
import '../../../common/helper/images/image_display.dart';
import '../../../domain/category/entity/category.dart';
import '../../all_categories/pages/all_categories.dart';
import '../../category_products/pages/category_products.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesDisplayCubit()..displayCategories(),
      child: BlocBuilder<CategoriesDisplayCubit,CategoriesDisplayState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const CircularProgressIndicator();
          }
          if (state is CategoriesLoaded) {
            return Column(
              children: [
                _seeAll(context),
                const SizedBox(height: 20, ),
                _categories(context, state.categories)
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _seeAll(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
         horizontal: 16
       ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Danh mục',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllCategoriesPage(),
                  ),
                );
              },
              child: const Text(
                'Xem tất cả',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16
                ),
              ),
            )
          ],
        ),
    );
  }

  Widget _categories(BuildContext context, List<CategoryEntity> categories) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
         horizontal: 16
       ),
        itemBuilder: (contetx,index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => CategoryProductsPage(categoryEntity: categories[index])
                )
              );
            },
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: ImageDisplayHelper.generateCategoryImage(categories[index].image),
                    )
                  )
                ),

                const SizedBox(height: 10,),
                Text(
                  categories[index].title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemCount: categories.length
      ),
    );
  }
}