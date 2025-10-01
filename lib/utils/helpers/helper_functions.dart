import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THelperFunctions {
  
  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
