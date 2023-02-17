//use get x

import 'package:get/get.dart';


class Dimensions{
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;


  static double carouselPageView = screenHeight / 2.86; //803/280px
  static double stackContainerView = screenHeight / 6.69;
  //height for margin ,padding
  static double height5 = screenHeight / 160.6 ;
  static double height10 = screenHeight / 80.3 ; // screenHeight / 10 = 80.3;
  static double height15 = screenHeight / 53.53;//screenHeight / 15 = 53.53;
  static double height20 = screenHeight / 40.15;
  static double height30 = screenHeight / 26.76;
  static double height45 = screenHeight / 17.84;
  static double height50 = screenHeight / 16.06;
  //width for margin ,padding
  static double width5 = screenHeight / 160.6 ;
  static double width10 = screenHeight / 80.3 ; // screenHeight / 10 = 80.3;
  static double width15 = screenHeight / 53.53;//screenHeight / 15 = 53.53;
  static double width20 = screenHeight / 40.15;
  static double width30 = screenHeight / 26.76;
  static double width45 = screenHeight / 17.84;

  static double font20 = screenHeight / 40.15;
  static double font12 = screenHeight / 67;
  static double font26 = screenHeight / 30.88;

  static double radius15 = screenHeight /53.53;
  static double radius20 = screenHeight /40.15;
  static double radius30 = screenHeight /26.76;

  static double iconSize24 = screenHeight / 33.45;
  static double iconSize16 = screenHeight / 50.18;
  static double iconSize26 = screenHeight / 30.88;


  //listview
  static double imgBoxSize = screenHeight / 6.69;//803/120
  static double txtBoxSize = screenHeight / 8.03;//803/100

  //foodDetail
  static double foodImgBoxSize = screenHeight/2.29; //screenHeight/ 350px

  //bottomnavigationbar
  static double bottomHeightBar = screenHeight/ 6.69;
}