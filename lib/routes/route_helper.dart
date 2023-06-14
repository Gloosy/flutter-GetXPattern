import 'package:food_delivery_app/view/auth_screen/sign_in_screen.dart';
import 'package:food_delivery_app/view/cart_screen/cart_screen.dart';
import 'package:food_delivery_app/view/food_detail_screen/food_detail_screen.dart';
import 'package:food_delivery_app/view/home_screen/home_screen.dart';
import 'package:food_delivery_app/view/location_screen/pick_location.dart';
import 'package:food_delivery_app/view/splash_screen/splash_screen.dart';

import 'package:get/get.dart';

import '../view/auth_screen/sign_up_screen.dart';
import '../view/food_detail_screen/reco_food_detail_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String foodDetail = '/food-detail';
  static const String splashScreen = '/splash-screen';
  static const String recommendedFoodDetail = '/recommended-food-detail';
  static const String cartScreen = '/cart-screen';
  static const String signUpScreen = '/signup-screen';
  static const String signInScreen = '/signIn-screen';
  static const String pickAddressMap = '/pick-address';

  static String getInitial() => '$initial';
  static String getFoodDetail(int? slideId, String? screen) =>
      '$foodDetail?slide=$slideId&page=$screen';
  static String getRecommendedFoodDetail(int? id) =>
      '$recommendedFoodDetail?id=$id';

  static String getCartScreen()   => '$cartScreen';
  static String getSplashScreen() => "$splashScreen";
  static String getSignUpScreen() => "$signUpScreen";
  static String getSignInScreen() => "$signInScreen";

  static String getPickAddressScreen() => '$pickAddressMap';

  // this is the route for link to screen

  static List<GetPage> routes = [
    GetPage(
        name: splashScreen,
        page: () => SplashScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: initial,
        page: () => HomeScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: foodDetail,
        page: () {
          var slideId = Get.parameters['slide'];
          var screen = Get.parameters['page'];
          print('Route :$screen');
          return FoodDetailScreen(
              slideId: int.parse(slideId!), screen: screen!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFoodDetail,
        page: () {
          var id = Get.parameters['id'];
          return RecommendedFoodDetail(
            id: int.parse(id!),
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartScreen,
        page: () {
          return CartScreen();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: signInScreen,
        page: () {
          return SignInScreen();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: signUpScreen,
        page: () {
          return SignUpScreen();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: pickAddressMap,
        page: () {
          PickLocationScreen pickAddress = Get.arguments;
          return pickAddress;
        })
  ];
}
