import 'package:flutter/material.dart';
import 'package:komiadmin/components/cashout_comp/cashout_list_tile.dart';

import '../../models/cashout_req_model.dart';

class RejectedCashout extends StatelessWidget {
  const RejectedCashout({super.key, required this.cashoutRequestModel});
  final CashoutRequestModel cashoutRequestModel;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cashoutRequestModel.rejectedTransaction!.length,
      itemBuilder: (context, index) => CashoutListTile(
        cashoutAmount: cashoutRequestModel.rejectedTransaction![index]!.amount!,
        type: 'rejected',
        date: cashoutRequestModel.rejectedTransaction![index]!.datecreated!,
        cashoutInfo: cashoutRequestModel.rejectedTransaction![index]!.userinfo!,
        id: '${cashoutRequestModel.rejectedTransaction![index]!.id}',
        image: cashoutRequestModel.rejectedTransaction![index]!.methodImage!,
        userName: cashoutRequestModel.rejectedTransaction![index]!.username!,
      ),
    );
  }
}
