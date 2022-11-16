import 'dart:convert';

import 'package:grab_app_clone_2/ultis/api_constrants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/Cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    //sharedPreferences.remove(AppContrants.CART_LIST);
    //sharedPreferences.remove(AppContrants.CART_HISTORY_LIST);
    var time = DateTime.now().toString();
    cart = [];
    // convert obj to String because sharedPreferences only accepts String

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppContrants.CART_LIST, cart);
    print(sharedPreferences.getStringList(AppContrants.CART_LIST));
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppContrants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppContrants.CART_LIST)!;
    }
    List<CartModel> cartList = [];
    cartHistory.forEach(
            (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppContrants.CART_HISTORY_LIST)) {
      //cartHistory = [];
      cartHistory =
      sharedPreferences.getStringList(AppContrants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistory() {
    for (int i = 0; i < cart.length; i++) {
      print("history list " + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(
        AppContrants.CART_HISTORY_LIST, cartHistory);
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppContrants.CART_HISTORY_LIST)) {
      cartHistory =
      sharedPreferences.getStringList(AppContrants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print("history list " + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(
        AppContrants.CART_HISTORY_LIST, cartHistory);
    print("the length of history list is " +
        getCartHistoryList().length.toString());
    print(
        "the time for the order is " + getCartHistoryList()[0].time.toString());
    for(int j=0;j<getCartHistoryList().length;j++){
      print(
          "the time for the order is " + getCartHistoryList()[j].time.toString());
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppContrants.CART_LIST);
  }
  void clearCartHistory(){
    removeCart();
    cartHistory=[];
    sharedPreferences.remove(AppContrants.CART_HISTORY_LIST);
  }
}
