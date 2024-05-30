import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komiadmin/blocs/cashout_bloc/cashout_cubit.dart';
import 'package:komiadmin/components/cashout_comp/cashout_actions.dart';
import 'package:komiadmin/components/cashout_comp/cashout_details.dart';
import 'package:komiadmin/components/methods_comp/method_edit_modal.dart';
import 'package:komiadmin/src/app_size.dart';

import '../../src/app_navigator.dart';

class MethodDialog extends StatelessWidget {
  const MethodDialog({
    super.key,
    required this.image,
    required this.id,
    required this.tierValue,
    required this.tierPoints,
    required this.status,
    required this.method,
  });
  final String id, image, method, status, tierValue, tierPoints;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            height: AppSize.height(context) * 0.62,
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
                  text: method,
                ),
                CashoutDetails(
                  title: 'activated',
                  text: status == 'activated' ? 'yes' : 'no',
                ),
                CashoutDetails(
                  title: 'tier value',
                  text: tierValue,
                ),
                CashoutDetails(
                  title: 'tier points',
                  text: tierPoints,
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
                      builder: (context) => MethodEditModal(
                          image: image,
                          method: method,
                          id: id,
                          tierPoints: tierPoints,
                          tierValue: tierValue),
                    );
                  },
                  title: 'EDIT',
                  color: Colors.green.shade800,
                ),
                CashoutActions(
                  ontap: () {
                    CashoutCubit.get(context)
                        .deleteMethod(id: id, context: context);
                  },
                  title: 'DELETE',
                  color: Colors.red.shade800,
                ),
                status == 'enabled'
                    ? CashoutActions(
                        ontap: () {
                          CashoutCubit.get(context)
                              .deactivateMethod(id: id, context: context);
                        },
                        title: 'DEACTIVATE',
                        color: Colors.amber.shade800,
                      )
                    : CashoutActions(
                        ontap: () {
                          CashoutCubit.get(context)
                              .activateMethod(id: id, context: context);
                        },
                        title: 'ACTIVATE',
                        color: Colors.amber.shade800,
                      ),
              ],
            ),
          ),
          Positioned(
            child: IconButton(
              onPressed: () {
                AppNavigator.pop(context);
              },
              icon: const Icon(Icons.close, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
