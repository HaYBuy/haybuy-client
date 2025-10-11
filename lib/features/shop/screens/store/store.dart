import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/common/widgets/appbar/tabbar.dart';
import 'package:haybuy_client/common/widgets/chats/chat_menu_icon.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:haybuy_client/common/widgets/layouts/grid_layout.dart';
import 'package:haybuy_client/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:haybuy_client/common/widgets/brands/brand_card.dart';
import 'package:haybuy_client/common/widgets/texts/section_heading.dart';
import 'package:haybuy_client/features/shop/screens/store/widgets/category_tab.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            CartCounterIcon(onPressed: () {}),
            ChatCounterIcon(onPressed: () {})
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: HelperFunctions.isDarkMode(context)
                    ? ConstColors.black
                    : ConstColors.white,
                expandedHeight: 440,

                flexibleSpace: Padding(
                  padding: EdgeInsets.all(Sizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// -- Search bar
                      SizedBox(height: Sizes.spaceBtwItems),
                      SearchContainer(
                        text: 'Search in Store',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(height: Sizes.spaceBtwSections),

                      /// -- Featured Products
                      SectionHeading(
                        title: 'Featured Products',
                        onPressed: () {},
                      ),
                      const SizedBox(height: Sizes.spaceBtwItems / 1.5),

                      GridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                          return const BrandCard(showBorder: false);
                        },
                      ),

                      /// -- Categories
                    ],
                  ),
                ),

                bottom: CustomTabBar(
                  tabs: [
                    Tab(child: Text('Sports')),
                    Tab(child: Text('Furniture')),
                    Tab(child: Text('Electronics')),
                    Tab(child: Text('Clothes')),
                    Tab(child: Text('Cosmetics')),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              CategoryTab(),
              CategoryTab(),
              CategoryTab(),
              CategoryTab(),
              CategoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}
