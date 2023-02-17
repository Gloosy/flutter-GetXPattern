import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/cart_controller.dart';
import 'package:food_delivery_app/controller/popular_product_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

import 'package:food_delivery_app/view/widgets/app_icon.dart';
import 'package:food_delivery_app/view/widgets/food_detail_column.dart';
import 'package:food_delivery_app/view/widgets/title_text.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../widgets/expendable_text.dart';

// ignore: must_be_immutable
class FoodDetailScreen extends StatelessWidget {
  int slideId;
  String screen;
  FoodDetailScreen({Key? key, required this.slideId,required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<ProductController>().listProduct[slideId];
    Get.find<ProductController>().initProduct(product, Get.find<CartController>());
    print('$slideId');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            _buildBackgroundImg(),
            _buildAppBarIcon(),
            _buildFoodDetail(product),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(product),
    );
  }

  Widget _buildBackgroundImg() {
    return Positioned(
      left: 0,
      right: 0,
      child: Container(
        width: double.maxFinite,
        height: Dimensions.foodImgBoxSize,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/img/food1.jpg'), fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildAppBarIcon() {
    print('screen1: $screen');
    return Positioned(
      top: Dimensions.height20,
      left: Dimensions.width20,
      right: Dimensions.width20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                if(screen == "cart"){
                  print(' true :$screen');
                  Get.toNamed(RouteHelper.getCartScreen());
              }else{
                  print(' false :$screen');
                  Get.toNamed(RouteHelper.getInitial());
                }
              },
              child: AppIcon(icon: Icons.arrow_back_ios_new)),
          GetBuilder<ProductController>(builder: (controller) {
            return GestureDetector(
              onTap: (){
                if(controller.totalItems >= 1) {
                  Get.toNamed(RouteHelper.getCartScreen());
                }
              },
              child: Stack(
                children: [
                  AppIcon(icon: Icons.shopping_cart),
                  controller.totalItems >= 1
                      ? Positioned(
                          right: 0,
                          top: 0,
                          child: AppIcon(
                            icon: Icons.circle,
                            size: 20,
                            iconColor: Colors.transparent,
                            backgroundColor: AppColors.mainColor,
                          ))
                      : Container(),
                  controller.totalItems >= 1
                      ? Positioned(
                      right: 5,
                      top: 3,
                      child: TitleText(text: '${controller.totalItems}', size: 12,color: Colors.white,))
                      : Container()
                ],
              ),
            );
          })
        ],
      ),
    );
  }

  Widget _buildFoodDetail(var product) {

    return Positioned(
      left: 0,
      right: 0,
      top: Dimensions.foodImgBoxSize - 20,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.only(
            left: Dimensions.width20,
            right: Dimensions.width20,
            top: Dimensions.height20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20),
                topRight: Radius.circular(Dimensions.radius20)),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FoodDetailColumn(
                titleText: '${product.attributes.title}',
                rating: '${product.attributes.rating}',
                quantity: '${product.attributes.quantity}',
                price: '${product.attributes.price}'),
            SizedBox(
              height: Dimensions.height20,
            ),
            TitleText(text: 'Introduce'),
            SizedBox(
              height: Dimensions.height10,
            ),
            Expanded(
                child: SingleChildScrollView(
                    child: ExpandableText(
              text: '${product.attributes.description}',
            )))
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(var productObj) {
    return GetBuilder<ProductController>(builder: (controller) {
      return Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(
            top: Dimensions.height30,
            bottom: Dimensions.height30,
            left: Dimensions.width20,
            right: Dimensions.width20),
        decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20,
                  vertical: Dimensions.height20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white),
              child: Row(
                children: [
                  GestureDetector(
                    child: const Icon(
                      Icons.remove,
                      color: AppColors.signColor,
                    ),
                    onTap: () {
                      controller.setQuantity(false);
                    },
                  ),
                  SizedBox(
                    width: Dimensions.width10,
                  ),
                  TitleText(text: '${controller.inCartItems}'),
                  SizedBox(
                    width: Dimensions.width10,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(true);
                    },
                    child: const Icon(
                      Icons.add,
                      color: AppColors.signColor,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.addItem(productObj);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor),
                child: TitleText(
                  text: ' Add to cart',
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
