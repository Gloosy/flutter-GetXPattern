
import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/widgets/Text_field_widget.dart';
import 'package:food_delivery_app/view/widgets/title_text.dart';
import 'package:get/get.dart';

import '../controller/Auth_controller.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {

  var emailController    = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleText(text: 'Sign In'),
          SizedBox(height: Dimensions.height20,),
          TextFieldWidget(textController:  emailController, icon: Icons.email, hintText: 'email'),
          SizedBox(height: Dimensions.height20,),
          TextFieldWidget(textController: passwordController, icon: Icons.password, hintText: 'password',isPassword: true),
          SizedBox(height: Dimensions.height20,),
          GestureDetector(
            onTap: (){
            },
            child:  Container(
              padding: EdgeInsets.all(Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.mainColor,
              ),
              child: TitleText(
                text: 'Sign In',
                color: Colors.white,
              ),
            ),),
          SizedBox(height: Dimensions.height10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Don\'t have account?'),
              GestureDetector(
                  onTap: (){

                  }, child: TitleText(text: 'Create one',size: Dimensions.iconSize24/1.6,)),
            ],
          )
        ],
      ),
    );
  }
}
