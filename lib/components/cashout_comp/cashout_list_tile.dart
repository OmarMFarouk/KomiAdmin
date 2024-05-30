import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komiadmin/components/cashout_comp/cashout_dialog.dart';

import '../../src/app_size.dart';

class CashoutListTile extends StatelessWidget {
  const CashoutListTile(
      {super.key,
      required this.type,
      required this.image,
      required this.id,
      required this.userName,
      required this.date,
      required this.cashoutInfo,
      required this.cashoutAmount});
  final String image, id, userName, cashoutAmount, date, cashoutInfo, type;

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
            width: AppSize.width(context) * 0.121,
            child: Text('#$id'),
          ),
          const VerticalDivider(
            color: Colors.blueGrey,
            endIndent: 12,
            indent: 12,
          ),
          SizedBox(
              width: AppSize.width(context) * 0.1,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.fill,
                ),
              )),
          SizedBox(
            width: AppSize.width(context) * 0.25,
            child: Text(
              userName,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const VerticalDivider(
            color: Colors.blueGrey,
            endIndent: 12,
            indent: 12,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => CashoutDialog(
                      id: id,
                      cashoutAmount: cashoutAmount,
                      type: type,
                      image: image,
                      userName: userName,
                      cashoutInfo: cashoutInfo,
                      date: date,
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
                    'VIEW',
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
