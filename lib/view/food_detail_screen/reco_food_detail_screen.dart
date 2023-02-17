import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/view/cart_screen/cart_screen.dart';
import 'package:food_delivery_app/view/widgets/app_icon.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../controller/popular_product_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../widgets/expendable_text.dart';
import '../widgets/title_text.dart';

// ignore: must_be_immutable
class RecommendedFoodDetail extends StatelessWidget {
  int id;
  RecommendedFoodDetail({Key? key,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<ProductController>().listProduct[id];
    Get.find<ProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildSliverAppBarAndDetail(),
      bottomNavigationBar: _buildBottomNavigationBar(product),
    );
  }

  Widget _buildSliverAppBarAndDetail() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 75,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: AppIcon(icon: Icons.clear),
                onTap: (){
                  Get.toNamed(RouteHelper.getInitial());
                },
              ),
              GetBuilder<ProductController>(builder: (controller) {
                return GestureDetector(
                  onTap: (){
                  if(controller.totalItems >= 1) {
                    Get.toNamed(RouteHelper.getCartScreen());
                  }
                },
                  child: Stack(
                    children: [
                      const AppIcon(icon: Icons.shopping_cart),
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
          expandedHeight: 300,
          pinned: true,
          backgroundColor: AppColors.mainColor,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/img/food4.jpg',
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
          bottom: PreferredSize(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    top: Dimensions.height10, bottom: Dimensions.height10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20))),
                child: TitleText(
                  text: "Sliver App bar",
                  size: Dimensions.font26,
                ),
              ),
              preferredSize: Size.fromHeight(20)),
        ),
        SliverToBoxAdapter(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: ExpandableText(
                text:
                    'Sliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App barSliver App bar',
              ),
            )
          ],
        ))
      ],
    );
  }

  Widget _buildBottomNavigationBar(var product) {
    return GetBuilder<ProductController>(builder:(controller){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20 * 2.5, right: Dimensions.width20 * 2.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               GestureDetector(
                 onTap: (){
                   controller.setQuantity(false);
                 },
                 child:  AppIcon(
                     icon: Icons.remove,
                     iconColor: Colors.white,
                     backgroundColor: AppColors.mainColor,
                     iconSize: Dimensions.iconSize24),
               ),
                TitleText(text: '\$${product.attributes.price} X ${controller.inCartItems}'),
                GestureDetector(
                  onTap: (){
                    controller.setQuantity(true);
                  },
                  child: AppIcon(
                    icon: Icons.add,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                )
              ],
            ),
          ),
          Container(
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
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    controller.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor),
                    child: TitleText(
                      text: '\$${product.attributes.price} | Add to cart',
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );
    });
  }
}
