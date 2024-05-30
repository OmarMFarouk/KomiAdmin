import 'package:flutter/material.dart';
import 'package:komiadmin/components/cashout_comp/cashout_list_tile.dart';
import 'package:komiadmin/models/cashout_req_model.dart';

class PendingCashoutScreen extends StatelessWidget {
  const PendingCashoutScreen({super.key, required this.cashoutRequestModel});
  final CashoutRequestModel cashoutRequestModel;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cashoutRequestModel.pendingTransaction!.length,
      itemBuilder: (context, index) => CashoutListTile(
        cashoutAmount: cashoutRequestModel.pendingTransaction![index]!.amount!,
        type: 'pending',
        date: cashoutRequestModel.pendingTransaction![index]!.datecreated!,
        cashoutInfo: cashoutRequestModel.pendingTransaction![index]!.userinfo!,
        id: '${cashoutRequestModel.pendingTransaction![index]!.id}',
        image: cashoutRequestModel.pendingTransaction![index]!.methodImage!,
        userName: cashoutRequestModel.pendingTransaction![index]!.username!,
      ),
    );
  }
}
