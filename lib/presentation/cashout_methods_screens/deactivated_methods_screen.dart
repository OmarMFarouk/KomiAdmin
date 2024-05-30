import 'package:flutter/material.dart';
import 'package:komiadmin/components/methods_comp/method_tile.dart';
import 'package:komiadmin/models/cashout_methods_model.dart';

class DeactivatedCashoutMethodsScreen extends StatelessWidget {
  const DeactivatedCashoutMethodsScreen(
      {super.key, required this.cashoutMethodsModel});
  final CashoutMethodsModel cashoutMethodsModel;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cashoutMethodsModel.dectivatedMethods!.length,
      itemBuilder: (context, index) => MethodTile(
        id: cashoutMethodsModel.dectivatedMethods![index]!.id!,
        tierPoints: cashoutMethodsModel.dectivatedMethods![index]!.tierpoints!,
        status: cashoutMethodsModel.dectivatedMethods![index]!.status!,
        tierValue:
            '${cashoutMethodsModel.dectivatedMethods![index]!.tiervalue}',
        image: cashoutMethodsModel.dectivatedMethods![index]!.image!,
        method: cashoutMethodsModel.dectivatedMethods![index]!.method!,
      ),
    );
  }
}
