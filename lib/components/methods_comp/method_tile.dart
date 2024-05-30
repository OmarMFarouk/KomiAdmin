import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../src/app_size.dart';
import 'method_dialog.dart';

class MethodTile extends StatelessWidget {
  const MethodTile({
    super.key,
    required this.id,
    required this.image,
    required this.tierValue,
    required this.tierPoints,
    required this.status,
    required this.method,
  });
  final String id, image, method, status, tierValue, tierPoints;

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
            width: AppSize.width(context) * 0.07,
            child: Text(
              tierValue,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const VerticalDivider(
            color: Colors.blueGrey,
            endIndent: 12,
            indent: 12,
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 40,
            child: CachedNetworkImage(
              imageUrl: image,
              useOldImageOnUrlChange: false,
            ),
          ),
          SizedBox(
            width: AppSize.width(context) * 0.2,
            child: Text(
              method,
              softWrap: false,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              const VerticalDivider(
                color: Colors.blueGrey,
                endIndent: 12,
                indent: 12,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => MethodDialog(
                      id: id,
                      tierPoints: tierPoints,
                      tierValue: tierValue,
                      status: status,
                      image: image,
                      method: method,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: AppSize.height(context) * 0.04,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.shade600,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    'EDIT',
                    style: TextStyle(letterSpacing: 1, fontSize: 12),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
