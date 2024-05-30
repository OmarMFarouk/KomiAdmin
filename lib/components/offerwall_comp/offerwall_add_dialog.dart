import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:komiadmin/blocs/offerwall_bloc/offerwall_cubit.dart';
import 'package:komiadmin/src/app_size.dart';

import '../../src/app_navigator.dart';
import '../cashout_comp/cashout_actions.dart';
import '../general/text_field.dart';

class AddOfferWallDialog extends StatefulWidget {
  const AddOfferWallDialog({
    super.key,
    required this.titleCont,
    required this.urlCont,
    required this.skinCont,
    required this.rateCont,
  });
  final TextEditingController titleCont, urlCont, skinCont, rateCont;

  @override
  State<AddOfferWallDialog> createState() => _AddOfferWallDialogState();
}

class _AddOfferWallDialogState extends State<AddOfferWallDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: const Color(0xFF191C24),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: AppSize.height(context) * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  OfferWallCubit.get(context).pickImage().whenComplete(() {
                    setState(() {});
                  });
                },
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.deepPurple.shade800,
                    foregroundImage: OfferWallCubit.get(context).path == ''
                        ? null
                        : FileImage(File(OfferWallCubit.get(context).path)),
                    radius: 50,
                    child: Icon(
                      Icons.image_search_outlined,
                      color: Colors.deepPurple.shade200,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  obscure: false,
                  hint: 'Network Name',
                  isLast: false,
                  controller: widget.titleCont),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  obscure: false,
                  hint: 'Network URL',
                  isLast: false,
                  controller: widget.urlCont),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableText('{user_id}',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600)),
                  Tooltip(
                    triggerMode: TooltipTriggerMode.tap,
                    textStyle: const TextStyle(fontSize: 11),
                    message: 'Replace Offerwall user parameter with {user_id}',
                    child: Icon(
                      Icons.help_outline,
                      size: 20,
                      color: Colors.deepPurple.shade600,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDropdown(
                  hintText: 'Select Color',
                  decoration: const CustomDropdownDecoration(
                      closedFillColor: Color(0xFF2A3038),
                      expandedFillColor: Color(0xFF2A3038)),
                  items: const [
                    'default',
                    'gold',
                    'red',
                    'vinous',
                    'blue',
                    'green'
                  ],
                  onChanged: (s) {
                    widget.skinCont.text = s;
                  }),
              const SizedBox(
                height: 10,
              ),
              CustomDropdown(
                  hintText: 'Select Rate (Stars)',
                  decoration: const CustomDropdownDecoration(
                      closedFillColor: Color(0xFF2A3038),
                      expandedFillColor: Color(0xFF2A3038)),
                  items: const ['1', '2', '3', '4', '5'],
                  onChanged: (s) {
                    widget.rateCont.text = s;
                  }),
              const SizedBox(
                height: 15,
              ),
              CashoutActions(
                  title: 'ADD',
                  ontap: () {
                    OfferWallCubit.get(context).addNetwork(context);
                    setState(() {});
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
      ),
    );
  }
}
