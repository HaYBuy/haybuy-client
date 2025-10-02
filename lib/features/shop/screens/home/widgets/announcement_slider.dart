import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:haybuy_client/common/widgets/images/rounded_image.dart';
import 'package:haybuy_client/features/shop/controllers/home_controller.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';

class AnnouncementSlider extends StatelessWidget {
  const AnnouncementSlider({super.key, required this.banners});

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageInddicator(index),
          ),
          items: banners
              .map((url) => RoundedImage(imageUrl: url))
              .toList(),
        ),
        const SizedBox(height: Sizes.spaceBtwItems),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < banners.length; i++)
                  CircularContainer(
                    width: 20,
                    height: 4,
                    margin: const EdgeInsets.only(right: 10),
                    backgroundColor: controller.carouseCurrentIndex.value == i
                        ? ConstColors.primary
                        : ConstColors.grey,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
