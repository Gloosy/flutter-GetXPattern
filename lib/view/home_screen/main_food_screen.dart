import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

import 'package:food_delivery_app/view/widgets/sub_text.dart';

import '../widgets/title_text.dart';
import 'product_food_screen.dart';



class MainFoodScreen extends StatefulWidget {
  const MainFoodScreen({Key? key}) : super(key: key);

  @override
  State<MainFoodScreen> createState() => _MainFoodScreenState();
}

class _MainFoodScreenState extends State<MainFoodScreen> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.97),
        body: Column(
          children: [
            _buildFoodHeader(),
            _buildFoodBody(),
          ],
        ),
        
      ),
    );
  }

  Widget _buildFoodHeader() {
    return Container(
      margin: EdgeInsets.only(
          top: Dimensions.height15, bottom: Dimensions.height15),
      padding: EdgeInsets.only(
          left: Dimensions.width20, right: Dimensions.width20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TitleText(text: 'Cambodia', color: AppColors.mainColor),
              Row(
                children: [
                  SubText(text: 'Chhay'),
                  const Icon(Icons.arrow_drop_down)
                ],
              )
            ],
          ),
          Center(
            child: Container(
              width: Dimensions.width45,
              height: Dimensions.height45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                color: AppColors.mainColor,
              ),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: Dimensions.iconSize24,
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFoodBody() {
    return Expanded(
      child: SingleChildScrollView(
        child: FoodBodyScreen(),
      ),
    );
  }
}
