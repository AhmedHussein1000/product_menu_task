import 'package:flutter/material.dart';
import 'package:product_menu_task/cubit/products_state.dart';
import 'package:product_menu_task/widgets/category_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key, required this.state});
  final ProductsState state;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: state.status == ProductsStatus.loading,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: state.categories.length,
          itemBuilder: (context, index) {
            final category = state.categories[index];
            final isSelected = category == state.selectedCategory;

            return CategoryItem(category: category, isSelected: isSelected);
          },
        ),
      ),
    );
  }
}