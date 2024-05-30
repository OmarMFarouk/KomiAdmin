import 'package:flutter/material.dart';
import 'package:h3m_shimmer_card/h3m_shimmer_card.dart';
import 'package:komiadmin/src/app_size.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerCard(
      height: AppSize.height(context) * 0.175,
      width: AppSize.width(context),
      beginAlignment: Alignment.topLeft,
      endAlignment: Alignment.bottomRight,
      backgroundColor: Color(0xFF191C24),
      shimmerColor: Color(0xFF6C7293),
    );
  }
}
