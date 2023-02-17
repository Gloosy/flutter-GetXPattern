import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/popular_product_controller.dart';
import 'package:food_delivery_app/data/api/status.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/api_url.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/view/widgets/food_detail_column.dart';
import 'package:food_delivery_app/view/widgets/icon_and_text.dart';
import 'package:food_delivery_app/view/widgets/sub_text.dart';
import 'package:food_delivery_app/view/widgets/title_text.dart';
import 'package:get/get.dart';

class FoodBodyScreen extends StatefulWidget {
  const FoodBodyScreen({Key? key}) : super(key: key);

  @override
  State<FoodBodyScreen> createState() => _FoodBodyScreenState();
}

class _FoodBodyScreenState extends State<FoodBodyScreen> {
  ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCarouselSlider(),
        SizedBox(height: Dimensions.height30,),
        _buildPopularText(),
        SizedBox(height: Dimensions.height20,),
        _buildPopularItem()
      ],
    );
  }

  Widget _buildCarouselSlider() {
    return GetBuilder<ProductController>(builder: (products) {
      var product = products.listProduct;
      print('${products.allProductList.message}');
      return products.allProductList.status == Status.LOADING
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            )
          : CarouselSlider.builder(
              itemCount: product.length ??=0,
              itemBuilder: (context, index, realIdx) {
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getFoodDetail(index,'home'));
                  },
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width10,
                            right: Dimensions.width10,
                            bottom: Dimensions.height50),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                          color: index.isEven
                              ? AppColors.mainColor
                              : Colors.greenAccent,
                          image: product[index]
                                      .attributes
                                      ?.thumbnail
                                      ?.data
                                      ?.attributes
                                      ?.url ==
                                  null
                              ? const DecorationImage(
                                  opacity: 0.0,
                                  image: AssetImage("assets/img/food2.jpg"),
                                  fit: BoxFit.cover)
                              : DecorationImage(
                                  image: NetworkImage(
                                      '${ApiUrl.baseUrl}${products.listProduct[index].attributes?.thumbnail?.data?.attributes?.url}'),
                                  fit: BoxFit.cover),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: Dimensions.stackContainerView,
                          margin: EdgeInsets.only(
                              left: Dimensions.width30,
                              right: Dimensions.width30,
                              bottom: Dimensions.height5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xFFe8e8e8),
                                    blurRadius: 5.0,
                                    offset: Offset(0, 5)),
                                BoxShadow(
                                    color: Colors.white, offset: Offset(-5, 0)),
                                BoxShadow(
                                    color: Colors.white, offset: Offset(5, 0)),
                              ]),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: Dimensions.width10,
                                right: Dimensions.width10,
                                top: Dimensions.height15),
                            child: FoodDetailColumn(
                                titleText: '${product[index].attributes?.title}',
                                price: '${product[index].attributes?.price}',
                                quantity:
                                    '${product[index].attributes?.quantity}',
                                rating: '${product[index].attributes?.rating}'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                  height: Dimensions.carouselPageView,
                  aspectRatio: 1.5,
                  viewportFraction: 0.85,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height));
    });
  }

  Widget _buildPopularText() {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.width20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TitleText(text: 'Popular'),
          SizedBox(
            width: Dimensions.width10,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 3),
            child: TitleText(
              text: '.',
              color: Colors.black26,
            ),
          ),
          SizedBox(
            width: Dimensions.width10,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 2),
            child: SubText(text: 'Food pairing'),
          )
        ],
      ),
    );
  }

  Widget _buildPopularItem() {
    return GetBuilder<ProductController>(builder: (products) {

      return products.allProductList.status == Status.LOADING
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            )
          : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: products.listProduct.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommendedFoodDetail(index));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        Container(
                          height: Dimensions.imgBoxSize,
                          width: Dimensions.imgBoxSize,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                              color: index.isEven
                                  ? AppColors.mainColor
                                  : Colors.greenAccent,
                              image: products.listProduct[index].attributes
                                  ?.thumbnail?.data?.attributes?.url == null
                                  ? const DecorationImage(
                                  opacity: 0.0,
                                  image: AssetImage("assets/img/food2.jpg"),
                                  fit: BoxFit.cover)
                                  : DecorationImage(
                                  image: NetworkImage(
                                      '${ApiUrl.baseUrl}${products.listProduct[index].attributes?.thumbnail?.data?.attributes?.url}'),
                                  fit: BoxFit.cover)),
                        ),
                        Expanded(
                            child: Container(
                              height: Dimensions.txtBoxSize,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(Dimensions.radius15),
                                      bottomRight:
                                      Radius.circular(Dimensions.radius15))),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Dimensions.width10,
                                    right: Dimensions.width5,
                                    bottom: Dimensions.height5,
                                    top: Dimensions.height5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TitleText(
                                        text:
                                        '${products.listProduct[index]?.attributes?.title}'),
                                    SubText(
                                        text: products.listProduct[index]?.attributes
                                            ?.price ??
                                            '\$${products.listProduct[index]?.attributes?.price}'),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndText(
                                            icon: Icons.rate_review_outlined,
                                            text:
                                            '${products.listProduct[index]?.attributes?.rating}',
                                            iconColor: AppColors.iconColor1),
                                        IconAndText(
                                            icon: Icons.location_on_outlined,
                                            text:
                                            '${products.listProduct[index]?.attributes?.quantity}',
                                            iconColor: AppColors.mainColor),
                                        IconAndText(
                                            icon: Icons.favorite,
                                            text:
                                            '${products.listProduct[index]?.attributes?.rating}',
                                            iconColor: AppColors.iconColor2)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              });
    });
  }
}
