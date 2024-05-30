import 'package:flutter/material.dart';
import 'package:komiadmin/components/offerwall_comp/offerwall_list_tile.dart';
import 'package:komiadmin/models/offerwall_model.dart';

class ActivatedOfferWallScreen extends StatelessWidget {
  const ActivatedOfferWallScreen({super.key, required this.offerWallModel});
  final OfferWallModel offerWallModel;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: offerWallModel.activatedOfferwalls!.length,
      itemBuilder: (context, index) => OfferWallListTile(
        color: offerWallModel.activatedOfferwalls![index]!.skin!,
        type: 'enabled',
        url: offerWallModel.activatedOfferwalls![index]!.url!,
        hot: offerWallModel.activatedOfferwalls![index]!.rate!,
        id: offerWallModel.activatedOfferwalls![index]!.id!,
        image: offerWallModel.activatedOfferwalls![index]!.image!,
        title: offerWallModel.activatedOfferwalls![index]!.name!,
      ),
    );
  }
}
