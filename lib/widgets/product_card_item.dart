import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_menu_task/core/functions/custom_snackbar.dart';
import 'package:product_menu_task/core/utils/constants.dart';
import 'package:product_menu_task/cubit/products_cubit.dart';
import 'package:product_menu_task/models/product_model.dart';
import 'package:product_menu_task/widgets/product_card.dart';

class ProductCardItem extends StatelessWidget {
  const ProductCardItem({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return ProductCard(
      product: product,
      onIncrement: () {
        context.read<ProductsCubit>().incrementQuantity(product.id);
        showCustomSnackBar(context, 'Quantity increased for ${product.title}');
      },
      onDecrement: () {
        if (product.quantity > 0) {
          context.read<ProductsCubit>().decrementQuantity(product.id);
          showCustomSnackBar(
              context, 'Quantity decreased for ${product.title}');
        }
      },
      onTap: () {
        showCustomSnackBar(
            context, '${Constants.selectedSnackBar}${product.title}');
      },
    );
  }
}
