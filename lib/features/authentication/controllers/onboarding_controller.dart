import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  final pageController = PageController();
  Rx<int> currentPage = 0.obs;

  void updatePageIndicator(index) {
    currentPage.value = index;
  }

  void dotNavigationClick(index) {
    currentPage.value = index;
    pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void nextPage() {
    if (currentPage.value == 2) {
      // Get.to(LoginScreen());
    } else {
      currentPage.value += 1;
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  void skipPage() {
    currentPage.value = 2;
    pageController.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }
}
