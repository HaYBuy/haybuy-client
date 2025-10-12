import 'package:flutter/material.dart';

class ProductPriceText extends StatelessWidget {
  const ProductPriceText({
    super.key, 
    this.currencySign = '฿', 
    required this.price, 
    this.maxLines = 1, 
    this.isLarge = false, 
    this.lineTrough = false });

  final String currencySign, price;
  final int maxLines;
  final bool isLarge;
  final bool lineTrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      price + currencySign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge ? Theme.of(context).textTheme.headlineMedium : Theme.of(context).textTheme.titleLarge,
    );
  }
}
