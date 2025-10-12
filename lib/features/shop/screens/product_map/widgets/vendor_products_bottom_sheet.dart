import 'package:flutter/material.dart';
import '../../../../../utils/helpers/helper_function.dart';
import '../../../models/vendor_model.dart';
import '../../../models/product_model.dart';

class VendorProductsBottomSheet extends StatelessWidget {
  final VendorModel vendor;
  final List<ProductModel> products;
  final bool isLoading;
  final VoidCallback onClose;

  const VendorProductsBottomSheet({
    super.key,
    required this.vendor,
    required this.products,
    required this.isLoading,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[900] : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.5 : 0.26),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: isDark
                          ? Colors.orange[900]
                          : Colors.orange[100],
                      backgroundImage: vendor.profileImage != null
                          ? NetworkImage(vendor.profileImage!)
                          : null,
                      child: vendor.profileImage == null
                          ? const Icon(Icons.store, color: Colors.orange)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vendor.fullName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          if (vendor.profile?.district != null)
                            Text(
                              vendor.profile!.district!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      onPressed: onClose,
                    ),
                  ],
                ),
              ),
              const Divider(),
              // Products list
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : products.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              size: 64,
                              color: isDark
                                  ? Colors.grey[600]
                                  : Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'ยังไม่มีสินค้า',
                              style: TextStyle(
                                fontSize: 16,
                                color: isDark
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        controller: scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: products.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 24),
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductListItem(
                            product: product,
                            isDark: isDark,
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProductListItem extends StatelessWidget {
  final ProductModel product;
  final bool isDark;

  const ProductListItem({
    super.key,
    required this.product,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 80,
            height: 80,
            color: isDark ? Colors.grey[800] : Colors.grey[200],
            child: product.imageUrl != null
                ? Image.network(
                    product.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.grey[400],
                      );
                    },
                  )
                : Icon(Icons.shopping_bag, size: 40, color: Colors.grey[400]),
          ),
        ),
        const SizedBox(width: 12),
        // Product details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (product.description != null) ...[
                const SizedBox(height: 4),
                Text(
                  product.description!,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    product.price.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const Spacer(),
                  if (product.quantity != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: product.quantity! > 0
                            ? (isDark ? Colors.green[900] : Colors.green[50])
                            : (isDark ? Colors.red[900] : Colors.red[50]),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        product.quantity! > 0
                            ? 'คงเหลือ ${product.quantity}'
                            : 'สินค้าหมด',
                        style: TextStyle(
                          fontSize: 12,
                          color: product.quantity! > 0
                              ? (isDark ? Colors.green[300] : Colors.green[700])
                              : (isDark ? Colors.red[300] : Colors.red[700]),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
