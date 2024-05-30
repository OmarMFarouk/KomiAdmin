import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komiadmin/blocs/cashout_bloc/cashout_cubit.dart';
import 'package:komiadmin/src/app_size.dart';

import '../cashout_comp/cashout_actions.dart';

class MethodEditModal extends StatefulWidget {
  const MethodEditModal({
    super.key,
    required this.method,
    required this.id,
    required this.tierPoints,
    required this.tierValue,
    required this.image,
  });

  final String method, tierPoints, tierValue, image;
  final String id;

  @override
  State<MethodEditModal> createState() => _MethodEditModalState();
}

class _MethodEditModalState extends State<MethodEditModal> {
  TextEditingController titleCont = TextEditingController();
  TextEditingController tierValueCont = TextEditingController();
  TextEditingController tierPointsCont = TextEditingController();
  bool picked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: AppSize.height(context) * 0.55,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Center(
          child: Column(
            children: [
              const Text('Edit Method details'),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.all(7),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF0F1015)),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      foregroundImage: CashoutCubit.get(context).path != ''
                          ? FileImage(File(CashoutCubit.get(context).path))
                              as ImageProvider
                          : CachedNetworkImageProvider(widget.image),
                      backgroundColor: Colors.deepPurple.shade800,
                      radius: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          picked = !picked;
                        });
                        CashoutCubit.get(context).pickImage().whenComplete(() {
                          setState(() {});
                        });
                      },
                      child: Icon(
                        Icons.edit_square,
                        color: Colors.deepPurple.shade200,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.all(7),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF0F1015)),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'title',
                          style: TextStyle(
                              color: Colors.deepOrange, letterSpacing: 1),
                        ),
                      ),
                      TextField(
                          controller: titleCont,
                          decoration: InputDecoration(
                              hintText: widget.method,
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700)))
                    ],
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.all(7),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF0F1015)),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'tier value',
                          style: TextStyle(
                              color: Colors.deepOrange, letterSpacing: 1),
                        ),
                      ),
                      TextField(
                          controller: tierValueCont,
                          decoration: InputDecoration(
                              hintText: widget.tierValue,
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700)))
                    ],
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.all(7),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF0F1015)),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'tier points',
                          style: TextStyle(
                              color: Colors.deepOrange, letterSpacing: 1),
                        ),
                      ),
                      TextField(
                          controller: tierPointsCont,
                          decoration: InputDecoration(
                              hintText: widget.tierPoints,
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700))),
                      CashoutActions(
                        ontap: titleCont.text.isNotEmpty ||
                                tierPointsCont.text.isNotEmpty ||
                                tierValueCont.text.isNotEmpty ||
                                picked == true
                            ? () {
                                CashoutCubit.get(context).editMethod(
                                    context,
                                    widget.id,
                                    titleCont.text,
                                    tierPointsCont.text,
                                    tierValueCont.text);
                              }
                            : () {},
                        title: 'SAVE',
                        color: Colors.green.shade800,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
