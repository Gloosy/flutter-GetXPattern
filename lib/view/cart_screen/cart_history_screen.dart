import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/api_url.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/view/widgets/sub_text.dart';
import 'package:food_delivery_app/view/widgets/title_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/cart_controller.dart';
import '../widgets/app_icon.dart';

class CartHistoryScreen extends StatelessWidget {
  const CartHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildBodyCartHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      color: AppColors.mainColor,
      width: double.maxFinite,
      padding: EdgeInsets.only(
          top: Dimensions.height10, bottom: Dimensions.height10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TitleText(text: 'Cart History'),
          AppIcon(
            icon: Icons.shopping_cart,
          )
        ],
      ),
    );
  }

  Widget _buildBodyCartHistory() {
    var getHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    //Map <time,number>
    Map<String, int> cartItemsPerOrder = {};
    //first i = 0 Map<time ,value = 0>,Map<time ,if fine value = 1>
    for (int i = 0; i < getHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getHistoryList[i].time)) {
        //check if containkey(time) and then update Map<time ,value = value + 1>
        cartItemsPerOrder.update(getHistoryList[i].time!, (value) => ++value);
      } else {
        //work went loop do first time add to map
        cartItemsPerOrder.putIfAbsent(getHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartItemPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemPerOrder = cartItemPerOrderToList();
    var listCounter = 0;
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(
          left: Dimensions.width20,
          right: Dimensions.width20,
          bottom: Dimensions.height20),
      child: ListView(
        children: [
          for (int i = 0; i < itemPerOrder.length; i++)
            Column(
              children: [
                SizedBox(
                  height: Dimensions.height10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    (() {
                      DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
                          .parse(getHistoryList[listCounter].time!);
                      var inputDate = DateTime.parse(parseDate.toString());
                      var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
                      var outputDate = outputFormat.format(inputDate);
                      return TitleText(text: outputDate);
                    }()),
                    SubText(text: 'total')
                  ],
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Row(
                  children: [
                    Container(
                      height: Dimensions.height20 * 4,
                      width: Dimensions.width20 * 12.5,
                      child: ListView.builder(
                          scrollDirection : Axis.horizontal,
                          itemCount       : itemPerOrder[i],
                          itemBuilder     : (context, index) {
                            if (listCounter < getHistoryList.length) {
                              listCounter++;
                            }
                            return Container(
                              height: Dimensions.height20 * 4,
                              width: Dimensions.width20 * 4,
                              margin: EdgeInsets.only(right: Dimensions.width5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15 / 2),
                                  image: getHistoryList[listCounter - 1].img ==
                                          null
                                      ? const DecorationImage(
                                          image: AssetImage(
                                              'assets/img/food1.jpg'),
                                          fit: BoxFit.cover,
                                          opacity: 0.2)
                                      : DecorationImage(
                                          image: NetworkImage(ApiUrl.baseUrl +
                                              getHistoryList[listCounter - 1]
                                                  .img!),
                                          fit: BoxFit.cover)),
                            );
                          }),
                    ),
                    Expanded(
                      child: SizedBox(
                      //color: Colors.redAccent,
                      height: Dimensions.height20 * 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TitleText(text: '${itemPerOrder[i]} Items'),
                          GestureDetector(
                            onTap: () {
                              var orderTime = cartOrderTimeToList();
                              Map<int ,CartModel> orderAgain = {};
                              for(int j=0 ;j<getHistoryList.length;j++){
                                if(getHistoryList[j].time == orderTime[i])
                                  {
                                    orderAgain.putIfAbsent(getHistoryList[j].id!, () =>
                                    CartModel.fromJson(jsonDecode(jsonEncode(getHistoryList[j]))));
                                  }
                              }
                              Get.find<CartController>().setItems= orderAgain;
                              Get.find<CartController>().addToCartList();
                              Get.toNamed(RouteHelper.getCartScreen());
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: Dimensions.width10 / 2,
                                  right: Dimensions.width10 / 2,
                                  top: Dimensions.height10 / 2,
                                  bottom: Dimensions.height10 / 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.mainColor),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                              ),
                              child: const Text(
                                'buy again',
                                style: TextStyle(
                                    fontSize: 12, color: AppColors.mainColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                )
              ],
            )
        ],
      ),
    ));
  }
}
