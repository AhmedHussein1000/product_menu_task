import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_menu_task/cubit/products_state.dart';
import 'package:product_menu_task/data/database_helper.dart';
import 'package:product_menu_task/models/product_model.dart';
import 'package:product_menu_task/core/utils/constants.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  ProductsCubit() : super(const ProductsState()) {
    loadProductsAndCategories();
  }

  Future<void> loadProductsAndCategories() async {
    emit(state.copyWith(status: ProductsStatus.loading));
    try {
      final products = await _databaseHelper.getAllProducts();
      final categories = await _databaseHelper.getAllCategories();
      final totalPrice = _calculateTotalPrice(products);
      
      // Set Best Offers as default selected category
      final defaultCategory = Constants.bestOffers;
      final filteredProducts = products.where((product) => product.category == defaultCategory).toList();
      
      emit(state.copyWith(
        products: products,
        filteredProducts: filteredProducts,
        categories: categories,
        selectedCategory: defaultCategory,
        status: ProductsStatus.loaded,
        totalPrice: totalPrice,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void filterByCategory(String category) {
    final newSelected = state.selectedCategory == category ? null : category;
    List<ProductModel> filtered;
    if (newSelected == null) {
      filtered = state.products.where((product) => product.category != Constants.bestOffers).toList();
    } else {
      filtered = state.products.where((product) => product.category == newSelected).toList();
    }
    emit(state.copyWith(
      filteredProducts: filtered,
      selectedCategory: newSelected,
    ));
  }

  Future<void> incrementQuantity(String id) async {
    final productIndex = state.products.indexWhere((p) => p.id == id);
    if (productIndex != -1) {
      final updatedProduct = state.products[productIndex].copyWith(quantity: state.products[productIndex].quantity + 1);
      final updatedProducts = List<ProductModel>.from(state.products);
      updatedProducts[productIndex] = updatedProduct;

      final updatedFiltered = List<ProductModel>.from(state.filteredProducts);
      final filteredIndex = updatedFiltered.indexWhere((p) => p.id == id);
      if (filteredIndex != -1) {
        updatedFiltered[filteredIndex] = updatedProduct;
      }

      await _databaseHelper.updateQuantity(id, updatedProduct.quantity);

      final totalPrice = _calculateTotalPrice(updatedProducts);

      emit(state.copyWith(
        products: updatedProducts,
        filteredProducts: updatedFiltered,
        totalPrice: totalPrice,
      ));
    }
  }

  Future<void> decrementQuantity(String id) async {
    final productIndex = state.products.indexWhere((p) => p.id == id);
    if (productIndex != -1 && state.products[productIndex].quantity > 0) {
      final updatedProduct = state.products[productIndex].copyWith(quantity: state.products[productIndex].quantity - 1);
      final updatedProducts = List<ProductModel>.from(state.products);
      updatedProducts[productIndex] = updatedProduct;

      final updatedFiltered = List<ProductModel>.from(state.filteredProducts);
      final filteredIndex = updatedFiltered.indexWhere((p) => p.id == id);
      if (filteredIndex != -1) {
        updatedFiltered[filteredIndex] = updatedProduct;
      }

      await _databaseHelper.updateQuantity(id, updatedProduct.quantity);

      final totalPrice = _calculateTotalPrice(updatedProducts);

      emit(state.copyWith(
        products: updatedProducts,
        filteredProducts: updatedFiltered,
        totalPrice: totalPrice,
      ));
    }
  }

  double _calculateTotalPrice(List<ProductModel> products) {
    return products.fold(0.0, (sum, product) => sum + (product.price * product.quantity));
  }
}