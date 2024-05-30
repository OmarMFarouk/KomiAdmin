import 'package:flutter/material.dart';
import 'package:komiadmin/components/cashout_comp/cashout_list_tile.dart';

import '../../models/cashout_req_model.dart';

class CompletedCashout extends StatelessWidget {
  const CompletedCashout({super.key, required this.cashoutRequestModel});
  final CashoutRequestModel cashoutRequestModel;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cashoutRequestModel.completedTransaction!.length,
      itemBuilder: (context, index) => CashoutListTile(
        cashoutAmount:
            cashoutRequestModel.completedTransaction![index]!.amount!,
        type: 'completed',
        date: cashoutRequestModel.completedTransaction![index]!.datecreated!,
        cashoutInfo:
            cashoutRequestModel.completedTransaction![index]!.userinfo!,
        id: '${cashoutRequestModel.completedTransaction![index]!.id}',
        image: cashoutRequestModel.completedTransaction![index]!.methodImage!,
        userName: cashoutRequestModel.completedTransaction![index]!.username!,
      ),
    );
  }
}
