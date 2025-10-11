import 'package:flutter/material.dart';
import 'package:haybuy_client/utils/constants/colors.dart';

class ListLayout extends StatelessWidget {
  const ListLayout({super.key, required this.itemBuilder, required this.itemCount});

  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: itemCount,
      shrinkWrap: true,
      separatorBuilder: (_, __) => Divider(
        color: ConstColors.grey.withValues(alpha: 0.5),
        indent: 16,
        endIndent: 16,
      ),
      itemBuilder: itemBuilder,
      
    );
  }
}