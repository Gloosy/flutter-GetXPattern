
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/cart_controller.dart';
import 'package:food_delivery_app/data/api/api_response.dart';
import 'package:food_delivery_app/repository/product_repo.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  final _productRepository = ProductRepository();

  @override
  void onInit() {
    getAllProductList();
    super.onInit();
  }
  List<dynamic> _listProducts = [];
  List<dynamic> get listProduct => _listProducts;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems+_quantity;

  late CartController _cart;

  ApiResponse<ProductModel> allProductList = ApiResponse.loading();

  onSetProductList(ApiResponse<ProductModel> response){
    allProductList = response;
    print(" controller1:$_listProducts");
    _listProducts = allProductList.data!.data!;
     print(" controller1:${_listProducts}");
    update();
  }

  Future getAllProductList() async{
    await _productRepository.getAllProduct().then((value){
      onSetProductList(ApiResponse.complete(value));
      print(" controller2:$value");
    }).onError((error, stackTrace) {
      onSetProductList(ApiResponse.error(error.toString()));
    });
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity +1);
      print('increment $_quantity');
    }else{
      _quantity = checkQuantity(_quantity -1);
      print('decrement $_quantity');
    }
    update();
  }
  int checkQuantity(int quantity){
    if((_inCartItems + quantity)< 0){
      Get.snackbar('product', 'can\'t less than zero',backgroundColor: Colors.white,colorText: Colors.black);
    if(_inCartItems > 0)
      {
        _quantity =-_inCartItems;
        return _quantity;
      }
      return 0;
    }else if((_inCartItems + quantity) > 1000) {
      Get.snackbar('product', 'product has only 1000',backgroundColor: Colors.white,colorText: Colors.black);
      return 20;
    }else{
      return quantity;
    }
  }
  void initProduct(Data product,CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist =false;
    exist =_cart.existInCart(product);
    print('exist $exist');
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }
    print('quantity in cart is $_inCartItems');
  }
  void addItem(Data product ){
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _inCartItems = _cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        print('product id :${value.id} quantity is ${value.quantity}');
      });
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }
  List<CartModel> get getItems{
    return _cart.getItems;
  }
  }






