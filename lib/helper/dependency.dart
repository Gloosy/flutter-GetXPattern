import 'package:food_delivery_app/controller/Auth_controller.dart';
import 'package:food_delivery_app/controller/cart_controller.dart';
import 'package:food_delivery_app/data/api/api_service.dart';
import 'package:food_delivery_app/repository/Auth_repo.dart';
import 'package:food_delivery_app/repository/cart_repo.dart';
import 'package:food_delivery_app/repository/location_repo.dart';
import 'package:food_delivery_app/repository/product_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/location_controlller.dart';
import '../controller/popular_product_controller.dart';
import '../data/api/google_map_service.dart';

Future<void> init() async{
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(()=> sharedPreferences);
  //api
  Get.lazyPut(() => ApiService()); 
  Get.lazyPut(() => GoogleMapService() );

  //repo
  Get.lazyPut(() => ProductRepository());
  Get.lazyPut(() => CartRepo(sharedPreferences : Get.find()));
  Get.lazyPut(() => AuthRepo(apiService: Get.find(), sharedPreferences:Get.find()));
  Get.lazyPut(() => LocationRepo(locationService: Get.find(), sharedPreferences:Get.find()));

  //controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => ProductController());
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  
}