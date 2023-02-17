import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/Auth_controller.dart';
import 'package:food_delivery_app/controller/cart_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/view/widgets/app_icon.dart';
import 'package:food_delivery_app/view/widgets/title_text.dart';
import 'package:get/get.dart';

import '../widgets/account_widget.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(text: 'PROFILE',size: 24,color: Colors.white,),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppIcon(icon: Icons.person,backgroundColor: AppColors.mainColor,iconColor: Colors.white,size: Dimensions.radius15 * 10,iconSize: Dimensions.height15 * 5,),
               _buildInfoAccountBody()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoAccountBody() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(top: Dimensions.height20),
      child: Column(
        children: [
          AccountWidget(appIcon: AppIcon(icon: Icons.person,backgroundColor: AppColors.mainColor),titleText:TitleText(text: 'Chhay')),
          AccountWidget(appIcon: AppIcon(icon: Icons.email,backgroundColor: AppColors.yellowColor),titleText:TitleText(text: 'email')),
          AccountWidget(appIcon: AppIcon(icon: Icons.phone,backgroundColor: AppColors.yellowColor),titleText:TitleText(text: 'Phone')),
          AccountWidget(appIcon: AppIcon(icon: Icons.location_on,backgroundColor: AppColors.mainColor),titleText:TitleText(text: 'Address')),
          GestureDetector(
            onTap: (){
              Get.find<AuthController>().logout();
              Get.find<CartController>().removeItems();
              Get.toNamed(RouteHelper.getSignInScreen());
            },
              child: AccountWidget(appIcon: AppIcon(icon: Icons.logout,backgroundColor: AppColors.mainColor),titleText:TitleText(text: 'Logout'))),

        ],
      )
    );
  }
}
