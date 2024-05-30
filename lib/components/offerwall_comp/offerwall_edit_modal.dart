import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:komiadmin/blocs/cashout_bloc/cashout_cubit.dart';
import 'package:komiadmin/blocs/offerwall_bloc/offerwall_cubit.dart';
import 'package:komiadmin/src/app_size.dart';

import '../cashout_comp/cashout_actions.dart';

class OfferWallEditModal extends StatefulWidget {
  const OfferWallEditModal({
    super.key,
    required this.rate,
    required this.title,
    required this.url,
    required this.image,
    required this.id,
  });

  final String title, url, rate, image, id;

  @override
  State<OfferWallEditModal> createState() => _OfferWallEditModalState();
}

class _OfferWallEditModalState extends State<OfferWallEditModal> {
  TextEditingController titleCont = TextEditingController();
  TextEditingController urlCont = TextEditingController();
  TextEditingController rateCont = TextEditingController();
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
              const Text('Edit Offerwall details'),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 0),
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
                      radius: 43,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          picked = !picked;
                        });
                        OfferWallCubit.get(context)
                            .pickImage()
                            .whenComplete(() {
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
                              hintText: widget.title,
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
                          'url',
                          style: TextStyle(
                              color: Colors.deepOrange, letterSpacing: 1),
                        ),
                      ),
                      TextField(
                          controller: urlCont,
                          decoration: InputDecoration(
                              hintText: widget.url,
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
                          'rate',
                          style: TextStyle(
                              color: Colors.deepOrange, letterSpacing: 1),
                        ),
                      ),
                      TextField(
                          maxLength: 1,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.deny(RegExp('[6-9-0]')),
                          ],
                          keyboardType: TextInputType.number,
                          controller: rateCont,
                          decoration: InputDecoration(
                              hintText: widget.rate,
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700))),
                      CashoutActions(
                        ontap: titleCont.text.isNotEmpty ||
                                rateCont.text.isNotEmpty ||
                                urlCont.text.isNotEmpty ||
                                picked == true
                            ? () {
                                OfferWallCubit.get(context).editNetwork(
                                    context,
                                    widget.id,
                                    titleCont.text,
                                    urlCont.text,
                                    rateCont.text);
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
