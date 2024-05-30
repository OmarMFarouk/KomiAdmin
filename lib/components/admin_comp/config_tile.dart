import 'package:flutter/material.dart';
import 'package:komiadmin/src/app_size.dart';

class ConfigTile extends StatelessWidget {
  const ConfigTile({
    super.key,
    required this.option,
    required this.onchanged,
    required this.value,
  });
  final String option;
  final Function onchanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: AppSize.width(context) * 0.55,
          child: Text(
            option,
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1,
                color: Colors.deepPurple.shade400),
          ),
        ),
        Switch(
            activeColor: Colors.deepPurple.shade300,
            value: value,
            onChanged: (s) {
              onchanged(s);
            })
      ],
    );
  }
}
