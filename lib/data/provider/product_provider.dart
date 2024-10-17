import 'dart:convert';
import 'package:demo_ecommerce/data/model/product_category_model.dart';
import 'package:demo_ecommerce/data/model/product_detail_model.dart';
import 'package:demo_ecommerce/data/model/product_list_model.dart';
import 'package:demo_ecommerce/themes/app_colors.dart';
import 'package:demo_ecommerce/utils/api_service.dart';
import 'package:demo_ecommerce/utils/snack_bar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  CategoryModel categoryModel = CategoryModel();
  ProductListModel productListModel = ProductListModel();
  ProductDetailModel productDetailModel = ProductDetailModel();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<Product> lazyLoadingitems = [];
  int currentPage = 0;
  final int itemsPerPage = 6;

  Future<CategoryModel> getAllCategory() async {
    try {
      var result = await ApiHelper.get("products/categories");
      if (result.statusCode == 200) {
        var data = json.decode(result.body);
        categoryModel = CategoryModel.fromJson(data);
        await getAllProducts();
        return categoryModel;
      } else {
        throw "Error Message";
      }
      // else other status code check handling
    } catch (e) {
      GlobalSnackbar.showSnackbar(e.toString(), AppColors.colorRed);

      rethrow;
    }
  }

  Future<ProductListModel> getAllProducts() async {
    try {
      var result = await ApiHelper.get("products");
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        productListModel = ProductListModel.fromJson(data);
        await loadMoreItems();
        return productListModel;
      } else {
        throw "Error Message";
      }
      // else other status code check handling
    } catch (e) {
      GlobalSnackbar.showSnackbar(e.toString(), AppColors.colorRed);

      rethrow;
    }
  }

  Future<ProductDetailModel> getProductDetail(int productId) async {
    try {
      var result = await ApiHelper.get("products/$productId");
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        productDetailModel = ProductDetailModel.fromJson(data);

        return productDetailModel;
      } else {
        throw "Error Message";
      }
      // else other status code check handling
    } catch (e) {
      GlobalSnackbar.showSnackbar(e.toString(), AppColors.colorRed);

      rethrow;
    }
  }

  Future<void> loadMoreItems() async {
    setLoading(true);

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    // Calculate how many items are left to load
    int totalLoadedItems = currentPage * itemsPerPage;
    int remainingItems = (productListModel.products!.length - totalLoadedItems);

    // If no more items left to load, return
    if (remainingItems <= 0) {
      setLoading(false);

      return;
    }
    // Adjust remainingItems to not exceed _itemsPerPage
    remainingItems =
        remainingItems > itemsPerPage ? itemsPerPage : remainingItems;

    // Load new items
    List<Product> newItems = List.generate(
      remainingItems,
      (index) => Product(
          id: (currentPage * itemsPerPage + index + 1),
          title: '${currentPage * itemsPerPage + index + 1}',
          image: '${currentPage * itemsPerPage + index + 1}',
          price: '${currentPage * itemsPerPage + index + 1}',
          category: '${currentPage * itemsPerPage + index + 1}',
          description: '${currentPage * itemsPerPage + index + 1}'),
    );

    currentPage++;
    lazyLoadingitems.addAll(newItems);
    setLoading(false);
    notifyListeners();
  }

  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}
