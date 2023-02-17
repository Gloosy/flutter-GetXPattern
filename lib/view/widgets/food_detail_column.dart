import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/widgets/sub_text.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'icon_and_text.dart';
import 'title_text.dart';

class FoodDetailColumn extends StatelessWidget {
  final String titleText;
  final String rating;
  final String quantity;
  final String price;
  const FoodDetailColumn({Key? key,
    required this.titleText,
    this.rating = 'none',this.price = '0',this.quantity = '0'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(text: titleText,size: Dimensions.iconSize26,),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Wrap(
              children: List.generate(
                  5,
                      (index) => const Icon(
                    Icons.star,
                    color: AppColors.mainColor,
                    size: 15,
                  )),
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            SubText(text: rating),
            SizedBox(
              width: Dimensions.width10,
            ),
            SubText(text: price),
            SizedBox(
              width: Dimensions.width10,
            ),
            SubText(text: 'Comments')
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(
                icon: Icons.price_check,
                text:price,
                iconColor: AppColors.iconColor1),
            IconAndText(
                icon: Icons.list_alt_outlined,
                text: quantity,
                iconColor: AppColors.mainColor),
            IconAndText(
                icon: Icons.favorite,
                text: rating,
                iconColor: AppColors.iconColor2)
          ],
        )
      ],
    );
  }
}
