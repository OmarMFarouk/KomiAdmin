import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komiadmin/blocs/cashout_bloc/cashout_cubit.dart';
import 'package:komiadmin/components/cashout_comp/cashout_actions.dart';
import 'package:komiadmin/components/cashout_comp/cashout_details.dart';
import 'package:komiadmin/presentation/user_screens/user_data_screen.dart';
import 'package:komiadmin/src/app_size.dart';

import '../../src/app_navigator.dart';

class CashoutDialog extends StatelessWidget {
  const CashoutDialog({
    super.key,
    required this.userName,
    required this.image,
    required this.type,
    required this.id,
    required this.cashoutInfo,
    required this.cashoutAmount,
    required this.date,
  });
  final String userName, id, cashoutInfo, cashoutAmount, date, image, type;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            height: type == 'pending'
                ? AppSize.height(context) * 0.6
                : AppSize.height(context) * 0.525,
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
                  title: 'username',
                  text: userName,
                ),
                CashoutDetails(
                  title: 'date',
                  text: date,
                ),
                CashoutDetails(
                  title: 'amount',
                  text: cashoutAmount + r'$',
                ),
                CashoutDetails(
                  title: 'cashout',
                  text: cashoutInfo,
                ),
                const Text(
                  'ACTIONS',
                  style: TextStyle(
                      letterSpacing: 3,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                ),
                type != 'completed'
                    ? CashoutActions(
                        ontap: () {
                          CashoutCubit.get(context).markCompleted(
                              username: userName, id: id, context: context);
                        },
                        title: 'COMPLETE',
                        color: Colors.green.shade800,
                      )
                    : const SizedBox(),
                type != 'rejected'
                    ? CashoutActions(
                        ontap: () {
                          CashoutCubit.get(context).markRejected(
                              username: userName, id: id, context: context);
                        },
                        title: 'REJECT',
                        color: Colors.red.shade800,
                      )
                    : const SizedBox(),
                CashoutActions(
                  ontap: () {
                    AppNavigator.push(
                        context, UserDataScreen(userName: userName));
                  },
                  title: 'TRACE USER',
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
              icon: Icon(Icons.close, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
