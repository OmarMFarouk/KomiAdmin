import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komiadmin/components/offerwall_comp/offerwall_dialog.dart';

import '../../src/app_size.dart';

class OfferWallListTile extends StatelessWidget {
  const OfferWallListTile(
      {super.key,
      required this.hot,
      required this.image,
      required this.id,
      required this.type,
      required this.title,
      required this.color,
      required this.url});
  final String image, id, color, title, hot, url, type;

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
          SizedBox(width: AppSize.width(context) * 0.07, child: Text('#$id')),
          const VerticalDivider(
            color: Colors.blueGrey,
            endIndent: 12,
            indent: 12,
          ),
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(image),
            radius: 25,
          ),
          SizedBox(
            width: AppSize.width(context) * 0.3,
            child: Text(
              title,
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
                    builder: (context) => OfferWallDialog(
                      color: color,
                      type: type,
                      id: id,
                      hot: hot,
                      image: image,
                      title: title,
                      url: url,
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
