import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/Auth_controller.dart';
import 'package:food_delivery_app/models/SignUp_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/view/widgets/Text_field_widget.dart';
import 'package:food_delivery_app/view/widgets/show_custom_snackbar.dart';
import 'package:food_delivery_app/view/widgets/title_text.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class SignUpScreen extends StatelessWidget {

  var emailController    = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController    = TextEditingController();
  var nameController     = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Dimensions.height20 * 10,
            ),
            TitleText(text: 'Sign Up Account'),
            SizedBox(
              height: Dimensions.height20,
            ),
            TextFieldWidget(
                textController: nameController,
                icon: Icons.person,
                hintText: 'name'),
            SizedBox(
              height: Dimensions.height20,
            ),
            TextFieldWidget(
                textController: emailController,
                icon: Icons.email,
                hintText: 'email'),
            SizedBox(
              height: Dimensions.height20,
            ),
            TextFieldWidget(
                textController: passwordController,
                icon: Icons.password,isPassword: true,
                hintText: 'password'),
            SizedBox(
              height: Dimensions.height20,
            ),
            TextFieldWidget(
                textController: phoneController,
                icon: Icons.phone,
                hintText: 'phone'),
            SizedBox(
              height: Dimensions.height20,
            ),
            GetBuilder<AuthController>(
              builder: (authController) {
                print('${authController.isLoading}');
                return GestureDetector(
                  onTap: () {
                    _registration(authController);
                  },
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.height10),
                    width: Dimensions.width45*4.5 ,
                    height: Dimensions.height50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: authController.isLoading == true
                        ? const CircularProgressIndicator(color: Colors.white,)
                        : TitleText(
                            text: 'Sign Up',
                            color: Colors.white,
                          ),
                  ),
                );
              },
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Text('Already have account?'))
          ],
        ),
      ),
    );
  }

  void _registration(AuthController authController) async {

    String name     = nameController.text.trim();
    String email    = emailController.text.trim();
    String password = passwordController.text.trim();
    String phone    = phoneController.text.trim();

    if (name.isEmpty &&
        phone.isEmpty &&
        !GetUtils.isEmail(email) &&
        password.isEmpty) {
      showCustomSnackBar("Input your information please.", title: 'invalid');
    } else if (name.isEmpty) {
      showCustomSnackBar("Input name please.", title: 'name');
    } else if (phone.isEmpty) {
      showCustomSnackBar("Input phone please.", title: 'phone');
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar("Input email please.", title: 'email');
    } else if (password.isEmpty) {
      showCustomSnackBar("Input password please.", title: 'password');
    } else if (password.length < 6) {
      showCustomSnackBar("password at least 6 character.", title: 'password');
    } else {
      SignUp signUp =
          SignUp(name: name, email: email, password: password, phone: phone);
      // print(
      //     '${signUp.name},${signUp.phone},${signUp.password},${signUp.email}');
      await authController.registration(signUp);
      print('${authController.userResponse.data!.accessToken}');
      if (authController.userResponse.data!.success!) {
        showCustomSnackBar("${authController.userResponse.data?.message}", title: 'good');
        Get.toNamed(RouteHelper.getSignInScreen());
      } else {
        showCustomSnackBar("${authController.userResponse.data?.message}.", title: 'failed');
      }
    }
  }
}
