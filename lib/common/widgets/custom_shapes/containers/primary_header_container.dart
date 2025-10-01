import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/circle_container.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';

import '../../../../utils/constants/colors.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
        color: ConstColors.primary,
        padding: const EdgeInsets.only(bottom: 0),
        // child: SizedBox(height: 400,
        child: Stack(
          children: [
            Positioned(top: -150, right: -250, child: CircleContainer(backgroundColor: ConstColors.textWhite.withOpacity(0.1),)),
            Positioned(top: 100, right: -300, child: CircleContainer(backgroundColor: ConstColors.textWhite.withOpacity(0.1),)),
          ],
        ),
      ),
    );
  }
}
