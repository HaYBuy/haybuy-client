import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:haybuy_client/common/widgets/layouts/grid_layout.dart';
import 'package:haybuy_client/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:haybuy_client/common/widgets/texts/section_heading.dart';
import 'package:haybuy_client/features/shop/models/product_model.dart';
import 'package:haybuy_client/features/shop/screens/all_products/all_products.dart';
import 'package:haybuy_client/features/shop/screens/home/widgets/announcement_slider.dart';
import 'package:haybuy_client/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:haybuy_client/features/shop/screens/home/widgets/home_categories.dart';
import 'package:haybuy_client/features/shop/screens/product_search/product_search.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../data/services/api/api_get_product.dart';
import '../../../../utils/constants/colors.dart';
import '../product_create/product_create.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ProductModel>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = ItemService.fetchItems(limit: 8); // ตัวอย่างดึง 8 รายการ
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: SizedBox(
      //   width: 70,
      //   height: 70,
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       Get.to(() => const CreateProductScreen());
      //     },
      //     shape: const CircleBorder(),
      //     child: const Icon(Icons.add, size: 40),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  HomeAppBar(),
                  SizedBox(height: Sizes.spaceBtwSections),
                  SearchContainer(
                    text: 'Search for Products',
                    icon: Iconsax.search_normal,
                    onTap: () => Get.to(() => const ProductSearchScreen()),
                  ),
                  SizedBox(height: Sizes.spaceBtwSections),
                  Padding(
                    padding: const EdgeInsets.only(left: Sizes.defaultSpace),
                    child: Column(
                      children: [
                        SectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: ConstColors.white,
                        ),
                        SizedBox(height: Sizes.spaceBtwSections),
                        HomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  AnnouncementSlider(
                    banners: [
                      Images.onboardingImage1,
                      Images.onboardingImage2,
                      Images.onboardingImage3,
                    ],
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections),
                  SectionHeading(title: 'Following Products', onPressed: () => Get.to(() => const AllProducts())),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  FutureBuilder<List<ProductModel>>(
                    future: _itemsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        debugPrint('❌ Snapshot Error: ${snapshot.error}');
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No products found'));
                      } else {
                        final items = snapshot.data!;
                        // ✅ แสดงข้อมูลทั้งหมด
                        print('📊 Total items: ${items.length}');

                        // ✅ ถ้ามีรายการแรก ให้แสดงข้อมูล id 1
                        if (items.isNotEmpty) {
                          final firstItem = items[0];
                          print('🆔 ID: ${firstItem.id}');
                          print('📝 Name: ${firstItem.name}');
                          print(' description: ${firstItem.description}');
                          print('💰 Price: ${firstItem.price}');
                          print('📦 Quantity: ${firstItem.quantity}');
                          print('⚙️ Status: ${firstItem.status}');
                          print('🖼️ Image URL: ${firstItem.imageUrl}');
                          print(' search_text: ${firstItem.searchText}');
                          print('📌 Category ID: ${firstItem.categoryId}');
                          print('👤 Owner ID: ${firstItem.ownerId}');
                          print(' groupId : ${firstItem.groupId}');
                          print('📅 Created At: ${firstItem.createdAt}');
                          print('📅 Updated At: ${firstItem.updatedAt}');
                          print('📅 Deleted At: ${firstItem.deletedAt}');
                          print('---');
                          print('🔍 Full Object: $firstItem');
                        }
                                                return GridLayout(
                          itemCount: items.length,
                          itemBuilder: ( context, index) => ProductCardVertical(product: items[index]),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
