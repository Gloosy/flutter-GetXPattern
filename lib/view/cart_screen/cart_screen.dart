import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/popular_product_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/api_url.dart';
import 'package:food_delivery_app/utils/colors.dart';

import 'package:food_delivery_app/view/widgets/sub_text.dart';
import 'package:food_delivery_app/view/widgets/title_text.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../utils/dimensions.dart';
import '../widgets/app_icon.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white.withOpacity(0.9),
      body: SafeArea(
        child: Stack(
          children: [
            _buildAppBarIcons(),
            _buildListCartView(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBarIcons() {
    return Positioned(
      top: Dimensions.height20,
      left: Dimensions.width20,
      right: Dimensions.width20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

         GestureDetector(
           onTap: (){
             Get.toNamed(RouteHelper.getInitial());
           },
           child: const AppIcon(
             icon: Icons.arrow_back_ios_new,
             backgroundColor: AppColors.mainColor,
             iconColor: Colors.white,
           ),
          ),

          SizedBox(
            width: Dimensions.width20 * 7,
          ),

          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getInitial());
            },
            child:const AppIcon(
              icon: Icons.home,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
            ),
          ),

          AppIcon(
            icon: Icons.shopping_cart,
            backgroundColor: AppColors.mainColor,
            iconColor: Colors.white,
          ),
          
        ],
      ),
    );
  }

  Widget _buildListCartView() {
    return Positioned(
        top: Dimensions.height20 * 4,
        left: Dimensions.width20,
        right: Dimensions.width20,
        bottom: 0,
        child: GetBuilder<CartController>(builder: (controller) {
          var cartList = controller.getItems;
            if (cartList.isNotEmpty) {
              return ListView.separated(
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: double.maxFinite,
                    height: Dimensions.height20 * 5,
                    child: Row(
                      children: [
                       GestureDetector(
                         onTap: (){
                           print('${cartList[index].product}');
                           var productIndex = Get.find<ProductController>().listProduct.indexOf(cartList[index].product);
                           print('productIndex $productIndex');
                           if(productIndex >=0){
                             Get.toNamed(RouteHelper.getFoodDetail(productIndex,'cart'));
                           }
                           //else{
                           //   var otherIndex = other list product index
                           //   Get.toNamed that route
                           // }
                           //but now have only 1 list
                           //Get.toNamed(RouteHelper.getFoodDetail(productIndex,'cart'));
                         },
                         child:  Container(
                           width: Dimensions.height20 * 5,
                           height: Dimensions.height20 * 5,
                           decoration: BoxDecoration(
                               borderRadius:
                               BorderRadius.circular(Dimensions.radius15),
                               color: Colors.white,
                               image:cartList[index].img == null
                                   ? const DecorationImage(
                                   image: AssetImage('assets/img/food1.jpg'),
                                   opacity: 0.1,
                                   fit: BoxFit.cover)
                                   : DecorationImage(
                                   image: NetworkImage(
                                       '${ApiUrl.baseUrl}${cartList[index].img}'),
                                   fit: BoxFit.cover)),
                         ),
                       ),
                        Expanded(
                          child: Container(
                          height: Dimensions.height20 * 4.5,
                          padding: EdgeInsets.only(left: Dimensions.width5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(Dimensions.radius15),
                                  bottomRight:
                                      Radius.circular(Dimensions.radius15)),
                              color: Colors.white70),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TitleText(
                                text: '${cartList[index].name}',
                                color: Colors.black54,
                              ),
                              SubText(text: 'spicy'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TitleText(
                                    text:
                                        '\$${cartList[index].price}',
                                    color: Colors.redAccent,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width10,
                                        vertical: Dimensions.height5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20),
                                        color: Colors.white),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          child: const Icon(
                                            Icons.remove,
                                            color: AppColors.signColor,
                                          ),
                                          onTap: () {
                                            controller.addItem(cartList[index].product!, -1);
                                          },
                                        ),
                                        SizedBox(
                                          width: Dimensions.width10,
                                        ),
                                        TitleText(text: '${cartList[index].quantity}'),
                                        SizedBox(
                                          width: Dimensions.width10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.addItem(cartList[index].product!, 1);
                                          },
                                          child: const Icon(
                                            Icons.add,
                                            color: AppColors.signColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 1,
                  );
                });
            } else {
              return const Center(child: Text('No Items.'));
            }
          },
        ));
  }


  Widget _buildBottomNavigationBar() {
    return GetBuilder<CartController>(builder: (controller) {
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
              child: TitleText(text: '\$${controller.totalAmount}'),
            ),
            GestureDetector(
              onTap: () {
                controller.addToHistory();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor),
                child: TitleText(
                  text: 'Check out',
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
