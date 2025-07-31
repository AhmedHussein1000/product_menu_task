import 'package:flutter/material.dart';
import 'package:product_menu_task/core/helpers/dummy_data.dart';
import 'package:product_menu_task/cubit/products_state.dart';
import 'package:product_menu_task/widgets/product_card_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key, required this.state});
  final ProductsState state;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer.sliver(
      enabled: state.status == ProductsStatus.loading,
      child: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (state.status == ProductsStatus.loading) {
              // Skeleton loading
              return Skeletonizer(
                  child: ProductCardItem(product: dummyProduct));
            }

            final product = state.filteredProducts[index];
            return ProductCardItem(product: product);
          },
          childCount: state.status == ProductsStatus.loading
              ? 6
              : state.filteredProducts.length,
        ),
      ),
    );
  }
}
