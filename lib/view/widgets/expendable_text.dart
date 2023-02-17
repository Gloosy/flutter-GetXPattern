

import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/view/widgets/sub_text.dart';

import '../../utils/colors.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHaft;
  bool expanded = true;
  double textHeight = Dimensions.screenHeight / 4.015;

  @override
  void initState() {
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHaft =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHaft = '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHaft.isEmpty
          ? SubText(text: firstHalf)
          : Column(
              children: [
                SubText(text: expanded ? ('$firstHalf...'):('$firstHalf$secondHaft'),size: Dimensions.iconSize16,height: 1.5,color: AppColors.paraColor,),
                InkWell(
                  onTap: (){
                    setState(() {
                      expanded = !expanded;
                    });
                  },
                  child: Row(
                    children: [
                      SubText(text: expanded ? 'Show more' : 'Show less',color: AppColors.mainColor,),
                      Icon(expanded ? Icons.arrow_drop_down : Icons.arrow_drop_up,color: AppColors.mainColor,)
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
