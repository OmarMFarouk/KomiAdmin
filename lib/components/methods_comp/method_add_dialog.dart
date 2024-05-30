import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:komiadmin/blocs/cashout_bloc/cashout_cubit.dart';
import 'package:komiadmin/src/app_size.dart';

import '../../src/app_navigator.dart';
import '../cashout_comp/cashout_actions.dart';
import '../general/text_field.dart';

class AddMethodDialog extends StatefulWidget {
  const AddMethodDialog({
    super.key,
    required this.methodController,
    required this.tierValueCont,
    required this.tierPointsCont,
  });
  final TextEditingController methodController, tierValueCont, tierPointsCont;

  @override
  State<AddMethodDialog> createState() => _AddMethodDialogState();
}

class _AddMethodDialogState extends State<AddMethodDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Color(0xFF191C24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: AppSize.height(context) * 0.55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                CashoutCubit.get(context).pickImage().whenComplete(() {
                  setState(() {});
                });
              },
              child: CircleAvatar(
                backgroundColor: Colors.deepPurple.shade800,
                foregroundImage: CashoutCubit.get(context).path == ''
                    ? null
                    : FileImage(File(CashoutCubit.get(context).path)),
                radius: 50,
                child: Icon(
                  Icons.image_search_outlined,
                  color: Colors.deepPurple.shade200,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
                obscure: false,
                hint: 'Method Name',
                isLast: false,
                controller: widget.methodController),
            const SizedBox(
              height: 5,
            ),
            MyTextField(
                obscure: false,
                hint: r'Tier Value  (ex: 1$)',
                isLast: false,
                controller: widget.tierValueCont),
            const SizedBox(
              height: 5,
            ),
            MyTextField(
                obscure: false,
                hint: 'Tier Points  (ex: 1000)',
                isLast: false,
                controller: widget.tierPointsCont),
            const SizedBox(
              height: 15,
            ),
            CashoutActions(
                title: 'ADD',
                ontap: () {
                  CashoutCubit.get(context).addMethod(context);
                },
                color: Colors.green.shade700),
            CashoutActions(
                title: 'CANCEL',
                ontap: () {
                  AppNavigator.pop(context);
                },
                color: Colors.red.shade800),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
