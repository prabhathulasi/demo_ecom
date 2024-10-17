import 'dart:convert';
import 'dart:developer';

import 'package:demo_ecommerce/data/model/cart_model.dart';
import 'package:demo_ecommerce/themes/app_colors.dart';
import 'package:demo_ecommerce/utils/api_service.dart';
import 'package:demo_ecommerce/utils/snack_bar_helper.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CartModel cartModel = CartModel();
  List<CartProducts> listProducts = [];

  Future addTOCart() async {
    setLoading(true);
    Map<String, dynamic> bodyData = {
      "userId": 2,
      "date": "2020-02-03",
      "products": listProducts
    };
    try {
      var result = await ApiHelper.post("carts", bodyData);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);
        cartModel = CartModel.fromJson(data);

        // await getAllProducts();
        GlobalSnackbar.showSnackbar("Item Added to cart", AppColors.colorGreen);
        return cartModel;
      }
      // else other status code check handling
    } catch (e) {
      GlobalSnackbar.showSnackbar(e.toString(), AppColors.colorRed);

      rethrow;
    } finally {
      notifyListeners();
      setLoading(false);
    }
  }

  void addToCartList(CartProducts cartProducts) {
    // Check if the product is already in the cart
    CartProducts? existingProduct = listProducts.firstWhere(
      (product) => product.productId == cartProducts.productId,
      orElse: () => CartProducts(productId: -1, quantity: 0),
    );

    // Check if the existing product is a valid one
    if (existingProduct.productId != -1) {
      // If product exists, increase its quantity
      existingProduct.quantity =
          (existingProduct.quantity ?? 0) + (cartProducts.quantity ?? 0);
    } else {
      // If product doesn't exist, add it to the list
      listProducts.add(cartProducts);
    }

    addTOCart();
    notifyListeners();
  }

  Future getCart() async {
    setLoading(true);

    try {
      var result = await ApiHelper.get(
        "carts/11",
      );

      if (result.statusCode == 200) {
        var data = json.decode(result.body);
        // cartModel = CartModel.fromJson(data);
        log(data.toString());
        // await getAllProducts();
        GlobalSnackbar.showSnackbar("Item Added to cart", AppColors.colorGreen);
        return cartModel;
      }
      // else other status code check handling
    } catch (e) {
      GlobalSnackbar.showSnackbar(e.toString(), AppColors.colorRed);

      rethrow;
    } finally {
      notifyListeners();
      setLoading(false);
    }
  }

  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}
