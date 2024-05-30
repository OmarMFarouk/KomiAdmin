import 'package:flutter/material.dart';
import 'package:komiadmin/components/methods_comp/method_tile.dart';
import 'package:komiadmin/models/cashout_methods_model.dart';

class ActivatedCashoutMethodsScreen extends StatelessWidget {
  const ActivatedCashoutMethodsScreen(
      {super.key, required this.cashoutMethodsModel});
  final CashoutMethodsModel cashoutMethodsModel;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cashoutMethodsModel.activatedMethods!.length,
      itemBuilder: (context, index) => MethodTile(
        id: cashoutMethodsModel.activatedMethods![index]!.id!,
        tierPoints: cashoutMethodsModel.activatedMethods![index]!.tierpoints!,
        status: cashoutMethodsModel.activatedMethods![index]!.status!,
        tierValue: '${cashoutMethodsModel.activatedMethods![index]!.tiervalue}',
        image: cashoutMethodsModel.activatedMethods![index]!.image!,
        method: cashoutMethodsModel.activatedMethods![index]!.method!,
      ),
    );
  }
}
