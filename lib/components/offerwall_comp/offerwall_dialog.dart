import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komiadmin/blocs/offerwall_bloc/offerwall_cubit.dart';
import 'package:komiadmin/components/cashout_comp/cashout_actions.dart';
import 'package:komiadmin/components/cashout_comp/cashout_details.dart';
import 'package:komiadmin/components/offerwall_comp/offerwall_edit_modal.dart';
import 'package:komiadmin/src/app_size.dart';

import '../../src/app_navigator.dart';

class OfferWallDialog extends StatelessWidget {
  const OfferWallDialog({
    super.key,
    required this.title,
    required this.type,
    required this.id,
    required this.image,
    required this.hot,
    required this.url,
    required this.color,
  });
  final String url, hot, image, title, id, type, color;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            height: AppSize.height(context) * 0.57,
            width: AppSize.width(context),
            decoration: BoxDecoration(
                color: const Color(0xFF191C24),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(1, 1.5),
                      color: Colors.blueGrey.shade400,
                      blurRadius: 5,
                      spreadRadius: 0.5)
                ]),
            child: ListView(
              children: [
                CachedNetworkImage(
                  imageUrl: image,
                  height: kToolbarHeight,
                ),
                CashoutDetails(
                  title: 'title',
                  text: title,
                ),
                CashoutDetails(
                  title: 'Rate',
                  text: hot,
                ),
                CashoutDetails(
                  title: 'url',
                  text: url,
                ),
                CashoutDetails(
                  title: 'Color',
                  text: color,
                ),
                const Text(
                  'ACTIONS',
                  style: TextStyle(
                      letterSpacing: 3,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                ),
                CashoutActions(
                  ontap: () {
                    AppNavigator.pop(context);
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: const Color(0xFF191C24),
                      builder: (context) => OfferWallEditModal(
                          image: image,
                          title: title,
                          id: id,
                          rate: hot,
                          url: url),
                    );
                  },
                  title: 'EDIT',
                  color: Colors.green.shade800,
                ),
                type == 'enabled'
                    ? CashoutActions(
                        ontap: () {
                          OfferWallCubit.get(context)
                              .deactivateOfferwall(id: id, context: context);
                        },
                        title: 'DEACTIVATE',
                        color: Colors.amber.shade800,
                      )
                    : CashoutActions(
                        ontap: () {
                          OfferWallCubit.get(context)
                              .activateOfferwall(id: id, context: context);
                        },
                        title: 'ACTIVATE',
                        color: Colors.amber.shade800,
                      ),
                CashoutActions(
                  ontap: () {
                    OfferWallCubit.get(context)
                        .deleteNetwork(id: id, context: context);
                  },
                  title: 'DELETE',
                  color: Colors.red.shade800,
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () => AppNavigator.pop(context),
              icon: Icon(
                Icons.close,
                color: Colors.deepPurple.shade300,
              )),
        ],
      ),
    );
  }
}
