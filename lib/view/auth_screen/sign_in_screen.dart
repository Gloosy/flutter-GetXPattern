
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/Auth_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';

import 'package:food_delivery_app/view/auth_screen/sign_up_screen.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../widgets/Text_field_widget.dart';
import '../widgets/show_custom_snackbar.dart';
import '../widgets/title_text.dart';

// ignore: must_be_immutable
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (authController){
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Dimensions.height20 * 10,
                ),
                TitleText(text: 'Sign In'),
                SizedBox(height: Dimensions.height20,),
                TextFieldWidget(textController:  emailController, icon: Icons.email, hintText: 'email'),
                SizedBox(height: Dimensions.height20,),
                TextFieldWidget(textController: passwordController, icon: Icons.password, hintText: 'password',isPassword: true),
                SizedBox(height: Dimensions.height20,),
                GestureDetector(
                  onTap: (){
                    _login(authController);
                  },
                  child: Container(
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
                          Get.to(() => SignUpScreen());
                        }, child: TitleText(text: 'Create one',size: Dimensions.iconSize24/1.6,)),
                  ],
                )
              ],
            ),
          );
        },

      ),
    );
  }

  void _login(AuthController authController) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (!GetUtils.isEmail(email) && password.isEmpty) {
      showCustomSnackBar("Input your information please.", title: 'invalid');
    }  else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar("Input email please.", title: 'email');
    } else if (password.isEmpty) {
      showCustomSnackBar("Input password please.", title: 'password');
    } else if (password.length < 6) {
      showCustomSnackBar("password at least 6 character.", title: 'password');
    } else {
      await authController.login(email, password);
      //print('${authController.userResponse.data!.accessToken}');
      if (authController.userResponse.data!.success!) {
          Get.toNamed(RouteHelper.getInitial());
      } else {
        showCustomSnackBar("${authController.userResponse.data?.message}.",
            title: 'failed');
      }
    }
  }
}
