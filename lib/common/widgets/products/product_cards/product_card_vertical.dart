import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/features/shop/screens/home/home.dart';
import 'package:haybuy_client/features/shop/screens/product_details/product_detail.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/shop/models/product_model.dart';


class ProductCardVertical extends StatelessWidget {
  final ProductModel? product;

  const ProductCardVertical({this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailScreen(product: product));
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(Sizes.productImageRadius ?? 16),
          color: dark ? const Color(0xFF272C2E) : Colors.white,
        ),
        child: Column(
          children: [
            // 🖼️ รูปสินค้า
            Container(
              height: 180,
              padding: const EdgeInsets.all(Sizes.sm ?? 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.productImageRadius ?? 16),
                color: dark ? const Color(0xFF3C4143) : const Color(0xFFF3F3F3),
              ),
              child: Stack(
                children: [
                  // รูปสินค้า
                  if (false)
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                      child: Image.network(
                        product!.imageUrl!,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(Sizes.productImageRadius ?? 16),
                      ),
                      child: const Icon(Icons.image, size: 50, color: Colors.white70),
                    ),

                  // ✨ Sale Badge
                  // Positioned(
                  //   top: 12,
                  //   left: 12,
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(Sizes.sm ?? 8),
                  //       color: const Color.fromARGB(255, 0, 255, 13).withOpacity(0.8),
                  //     ),
                  //     child: Text(
                  //       '20%',
                  //       style: const TextStyle(
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // ❤️ Favourite Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Iconsax.heart5,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // 📝 รายละเอียดสินค้า
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ชื่อสินค้า
                    Text(
                      product?.name ?? 'No name',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // ประเภท/แบรนด์
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product?.status ?? 'Available',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Iconsax.verify5,
                          color: ConstColors.primary,
                          size: 16,
                        ),
                      ],
                    ),

                    // ราคา + ปุ่มเพิ่ม
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ราคา
                        Text(
                          '฿${(product?.price ?? 0).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),

                        // ปุ่มเพิ่ม
                        Container(
                          decoration: const BoxDecoration(
                            color: ConstColors.dark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: SizedBox(
                            width: 36,
                            height: 36,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  // TODO: Add to cart
                                },
                                child: const Icon(
                                  Iconsax.add,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
