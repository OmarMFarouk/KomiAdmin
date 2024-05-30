import 'package:flutter/material.dart';
import 'package:komiadmin/src/app_size.dart';

class CashoutActions extends StatelessWidget {
  const CashoutActions({
    super.key,
    required this.title,
    required this.ontap,
    required this.color,
  });
  final String title;
  final VoidCallback ontap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        alignment: Alignment.center,
        height: AppSize.height(context) * 0.04,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, letterSpacing: 3, fontSize: 12),
        ),
      ),
    );
  }
}
