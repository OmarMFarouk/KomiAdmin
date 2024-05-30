import 'package:flutter/material.dart';

import '../../src/app_size.dart';

class LeadsListTile extends StatelessWidget {
  const LeadsListTile(
      {super.key,
      required this.points,
      required this.offerName,
      required this.id,
      required this.network,
      required this.date,
      required this.username});
  final String username, id, network, offerName, points, date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 5),
      width: AppSize.width(context),
      height: AppSize.height(context) * 0.075,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFF191C24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: AppSize.width(context) * 0.2,
            child: Text(
              date,
              style: const TextStyle(fontSize: 10),
            ),
          ),
          const VerticalDivider(
            color: Colors.blueGrey,
            endIndent: 12,
            indent: 12,
          ),
          SizedBox(
            width: AppSize.width(context) * 0.17,
            child: SelectableText(
              network + '\n' + offerName,
              style: const TextStyle(fontSize: 10),
            ),
          ),
          const VerticalDivider(
            color: Colors.blueGrey,
            endIndent: 12,
            indent: 12,
          ),
          SizedBox(
            width: AppSize.width(context) * 0.1,
            child: Text(
              points,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const VerticalDivider(
            color: Colors.blueGrey,
            endIndent: 12,
            indent: 12,
          ),
          SizedBox(
            width: AppSize.width(context) * 0.13,
            child: SelectableText(
              username,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
