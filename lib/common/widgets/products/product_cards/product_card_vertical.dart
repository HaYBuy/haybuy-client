import 'package:flutter/material.dart';
import '../../../../features/shop/models/product_model.dart';


class ProductCardVertical extends StatelessWidget {
  final ProductModel? product;

  const ProductCardVertical({this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // รูปสินค้า
          // if (product?.imageUrl != null && product!.imageUrl!.isNotEmpty)
          if( false)
          
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(
                product!.imageUrl!,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            )
          else
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: const Icon(Icons.image, size: 50, color: Colors.white70),
            ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ชื่อสินค้า
                Text(
                  product?.name ?? 'No name',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // ราคา
                Text(
                  '฿${(product?.price ?? 0).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                // สถานะ (optional)
                if (product?.status != null)
                  Text(
                    product!.status!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
