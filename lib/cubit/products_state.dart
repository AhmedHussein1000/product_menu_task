import 'package:equatable/equatable.dart';
import 'package:product_menu_task/models/product_model.dart';

enum ProductsStatus { initial, loading, loaded, error }

class ProductsState extends Equatable {
  final List<ProductModel> products;
  final List<ProductModel> filteredProducts;
  final String? selectedCategory;
  final ProductsStatus status;
  final String errorMessage;
  final double totalPrice;
  final List<String> categories;

  const ProductsState({
    this.products = const [],
    this.filteredProducts = const [],
    this.selectedCategory,
    this.status = ProductsStatus.initial,
    this.errorMessage = '',
    this.totalPrice = 0.0,
    this.categories = const [],
  });

  ProductsState copyWith({
    List<ProductModel>? products,
    List<ProductModel>? filteredProducts,
    String? selectedCategory,
    ProductsStatus? status,
    String? errorMessage,
    double? totalPrice,
    List<String>? categories,
  }) {
    return ProductsState(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      totalPrice: totalPrice ?? this.totalPrice,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [products, filteredProducts, selectedCategory, status, errorMessage, totalPrice, categories];
}