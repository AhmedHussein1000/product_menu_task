import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_menu_task/cubit/products_cubit.dart';
import 'package:product_menu_task/cubit/products_state.dart';
import 'package:product_menu_task/widgets/categories_section.dart';
import 'package:product_menu_task/widgets/cart_button.dart';
import 'package:product_menu_task/widgets/products_grid.dart';
import 'package:product_menu_task/core/utils/constants.dart';
import 'package:product_menu_task/core/functions/custom_snackbar.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            Constants.appBarTitle,
          ),
          leading: const BackButton(),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showCustomSnackBar(context, 'Search functionality coming soon');
              },
            ),
          ],
        ),
        body: ProductsBodyBlocBuilder(),
      ),
    );
  }

}

class ProductsBodyBlocBuilder extends StatelessWidget {
  const ProductsBodyBlocBuilder({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state.status == ProductsStatus.error) {
          return Center(child: Text(state.errorMessage));
        }
        return Stack(
          children: [
            CustomScrollView(
              slivers: [
                // Categories
                SliverToBoxAdapter(
                  child: CategoriesSection(state: state),
                ),
                // Products grid
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: ProductsGrid(state:state),
                ),
                // Extra space at bottom for cart button
                const SliverToBoxAdapter(
                  child: SizedBox(height: 70),
                ),
              ],
            ),
            // Cart button at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CartButton(
                totalPrice: state.totalPrice,
                onPressed: () {
                  showCustomSnackBar(context, 'Viewing cart');
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
