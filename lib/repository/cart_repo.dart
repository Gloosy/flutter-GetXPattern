import 'dart:convert';

import 'package:food_delivery_app/utils/shared_preferences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory =[];



  void addToCartList(List<CartModel> cartList){
    // sharedPreferences.remove(SharedPref.CART_LIST);
    // sharedPreferences.remove(SharedPref.CART_HISTORY_LIST);
    cart = [];
    var time = DateTime.now().toString();
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element)); // convert object to string
    });
    sharedPreferences.setStringList(SharedPref.CART_LIST, cart);
    //print('${sharedPreferences.getStringList(SharedPref.CART_LIST)}');
    //getCartList();
  }

  List<CartModel> getCartList(){
    var keyValue = sharedPreferences.containsKey(SharedPref.CART_LIST);
    List<String>? carts =[];
    List<CartModel> cartList = [];
    if(keyValue){
      carts = sharedPreferences.getStringList(SharedPref.CART_LIST);
      print('carts :$cart');
    }
    for (var element in carts!) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
      print('inside getCartList $cartList');
    }
    return cartList;
  }

  List<CartModel> getCartHistory(){
    var keyValue = sharedPreferences.containsKey(SharedPref.CART_HISTORY_LIST);
    if(keyValue){
      cartHistory =[];
      cartHistory = sharedPreferences.getStringList(SharedPref.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory =[];
    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
      //print('inside CartList $cartListHistory');
    }
    return cartListHistory;
  }
  void addToCartHistoryList() {
    if(sharedPreferences.containsKey(SharedPref.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(SharedPref.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print('history list${cart[i]}');
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(SharedPref.CART_HISTORY_LIST, cartHistory);
    print('the length of history list is :${getCartHistory().length}');
    for(int j = 0;j<getCartHistory().length;j++){
      print('The time for the order : ${getCartHistory()[j].time}');
    }
  }
  void removeCart(){
    cart = [];
    sharedPreferences.remove(SharedPref.CART_LIST);
    print('remove from cart');
  }
}