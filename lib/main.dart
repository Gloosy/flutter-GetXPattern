import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/Auth_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/view/auth_screen/sign_in_screen.dart';
import 'package:food_delivery_app/view/home_screen/main_food_screen.dart';

import 'package:get/get.dart';
import './helper/dependency.dart' as dependency;
import 'controller/cart_controller.dart';
import 'view/auth_screen/sign_up_screen.dart';
import 'view/home_screen/home_screen.dart';
import 'view/test.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

      return GetBuilder<AuthController>(builder: (authController){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: authController.autoLogin()? RouteHelper.getInitial() : RouteHelper.getSignInScreen(),
          getPages: RouteHelper.routes,
          //home: Testing(),
        );
      });
    }

}

