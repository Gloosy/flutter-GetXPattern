
import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/view/widgets/app_icon.dart';
import 'package:food_delivery_app/view/widgets/title_text.dart';



class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  TitleText titleText;
  AccountWidget({Key? key,required this.appIcon,required this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: Dimensions.height50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20,),
          titleText
        ],
      ),
    );
  }
}
