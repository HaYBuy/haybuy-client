import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/layouts/grid_layout.dart';
import 'package:haybuy_client/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:haybuy_client/common/widgets/texts/section_heading.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';

/// Widget สำหรับแสดงสินค้าทั้งหมดที่ User เปิดขาย
class UserProductsSection extends StatelessWidget {
  const UserProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Heading
        const SectionHeading(
          title: 'Products for Sale',
          showActionButton: false,
        ),
        const SizedBox(height: Sizes.spaceBtwItems),

        // Products Grid
        GridLayout(
          itemCount: 8, // จำนวนสินค้าทั้งหมด (ในอนาคตจะเป็นข้อมูลจริงจาก API)
          itemBuilder: (_, index) => const ProductCardVertical(),
        ),
      ],
    );
  }
}
