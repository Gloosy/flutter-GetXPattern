

import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/cart_model.dart';

import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/repository/cart_repo.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  @override
  void onInit() {
    getCartData();
    super.onInit();
  }

  Map<int,CartModel> _items = {};
  Map<int,CartModel> get items => _items;
  List<CartModel> storageItems= []; //to store data from local storage to sharedPreferences

  void addItem(Data product,int quantity){
    //_items = {};
    var totalQuantity = 0;
    //if has in list and update quantity
    if(_items.containsKey(product.id)){
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id       : value.id  ,
            price    : value.price,
            quantity : value.quantity! + quantity,
            img      : value.img,
            isExist  : true,
            name     : value.name,
            time     : DateTime.now().toString(),
            product  : product
        );
      });
      //if product quantity == 0 remove
      if(totalQuantity <= 0){
        _items.remove(product.id);
      }
    }else{
      //if quantity > 0 and empty in list
      if(quantity > 0){
        _items.putIfAbsent(product.id!, () {
          return CartModel(
              id        : product.id!,
              price     : product.attributes!.price,
              quantity  : quantity,
              img       : product.attributes!.thumbnail?.data?.attributes?.url,
              isExist   : true,
              name      : product.attributes!.title,
              time      : DateTime.now().toString(),
              product: product
          );
        });
      }else{
        Get.snackbar('Item count', 'Add quantity',backgroundColor: Colors.white,colorText: Colors.black);
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  //check if have in list or not
  bool existInCart(Data product){
    if(_items.containsKey(product.id)){
      return true;
    }{
      return false;
    }
  }

  int getQuantity( Data product){
    var quantity= 0;
    if(_items.containsKey(product.id))
      {
        _items.forEach((key, value) {
          if(key == product.id)
            {
              quantity = value.quantity!;
            }
        });
      }
    return quantity;
  }

  //total quantity
  int get totalItems{
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }
   double get totalAmount {
    double total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * double.parse(value.price!) ;
    });
    return total;
  }

  //getCartData checking local storage have data or no if have set to map items
  List<CartModel> getCartData(){
  setCart = cartRepo.getCartList();
  return storageItems;
  }

  set setCart(List<CartModel> items){
    storageItems = items;
    print('cart from localstorage :${storageItems.length}');
    for(int i = 0;i< storageItems.length ; i++){
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }
  void clear(){
    _items= {};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistory();
  }

  set setItems(Map<int,CartModel> setItems){
      _items={};
      _items = setItems;
  }

  void addToCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }

  void removeItems(){
    _items = {};
  }
}