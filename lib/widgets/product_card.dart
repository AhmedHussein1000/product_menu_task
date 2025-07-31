import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:product_menu_task/core/utils/app_styles.dart';
import 'package:product_menu_task/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final Function() onIncrement;
  final Function() onDecrement;
  final Function() onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onIncrement,
    required this.onDecrement,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(),
              const SizedBox(height: 8),
              // Product title
              FittedBox(
                child: Text(
                  product.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              const Spacer(),
              _buildPriceAndQuantityRow()
            ],
          ),
        ),
      ),
    );
  }

  LayoutBuilder _buildPriceAndQuantityRow() {
    return LayoutBuilder(builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              final priceWidth = availableWidth * 0.4;
              final controlsWidth = availableWidth * 0.55;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Price with constrained width
                  SizedBox(
                    width: priceWidth,
                    child: Text(
                      '${product.price.toStringAsFixed(2)} SAR',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // Quantity controls with responsive sizing
                  Container(
                    width: controlsWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: availableWidth * 0.02,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Minus button
                        InkWell(
                          onTap: onDecrement,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.remove,
                              color: Colors.grey,
                              size: 14,
                            ),
                          ),
                        ),
                        // Quantity text
                        Text(
                          '${product.quantity}',
                          style: Styles.styleBold14(context),
                        ),
                        // Plus button
                        InkWell(
                          onTap: onIncrement,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.add,
                              color: Colors.blue,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            });
  }

  LayoutBuilder _buildProductImage() {
    return LayoutBuilder(
              builder: (context, constraints) {
                double imageSize = constraints.maxWidth * 0.8;
                return Center(
                  child: SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.amber, width: 2),
                          ),
                          child: Center(
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: product.imageUrl,
                                fit: BoxFit.contain,
                                placeholder: (context, url) => Center(
                                    child: const CircularProgressIndicator(color: Colors.amber,)),
                                errorWidget: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[200],
                                    child: const Center(
                                      child: Icon(Icons.fastfood, size: 50),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.amber, width: 1),
                            ),
                            child: Image.asset(
                              'assets/images/burger_king_logo.png',
                              width: imageSize * 0.3, 
                              height: imageSize * 0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
  }
}
