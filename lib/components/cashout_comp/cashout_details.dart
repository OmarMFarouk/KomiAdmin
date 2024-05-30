import 'package:flutter/material.dart';

class CashoutDetails extends StatelessWidget {
  const CashoutDetails({super.key, required this.text, required this.title});

  final String text, title;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.all(7),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF0F1015)),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style:
                    const TextStyle(color: Colors.deepOrange, letterSpacing: 1),
              ),
            ),
            SelectableText(
              text,
              maxLines: 1,
            )
          ],
        ));
  }
}
