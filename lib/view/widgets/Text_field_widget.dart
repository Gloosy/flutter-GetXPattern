import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isPassword;
  TextFieldWidget({Key? key,required this.textController,required this.icon,required this.hintText,this.isPassword = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          color: Colors.white,
          boxShadow: [BoxShadow(
              blurRadius: 10,
              spreadRadius: 7,
              offset: Offset(1,10),
              color: Colors.grey.withOpacity(0.2)
          )]
      ),
      margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
      child: TextField(
        controller: textController,
        obscureText: isPassword ? true : false,
        decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon,color: AppColors.mainColor,),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.white
                )
            ),
            enabledBorder:OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.white
                )
            ),
        ),
      ),
    );
  }
}
