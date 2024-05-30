import 'package:flutter/material.dart';
import 'package:komiadmin/components/offerwall_comp/offerwall_list_tile.dart';
import '../../models/offerwall_model.dart';

class DeactivatedOfferWallScreen extends StatelessWidget {
  const DeactivatedOfferWallScreen({super.key, required this.offerWallModel});
  final OfferWallModel offerWallModel;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: offerWallModel.deactivatedOfferwalls!.length,
      itemBuilder: (context, index) => OfferWallListTile(
        type: 'disabled',
        url: offerWallModel.deactivatedOfferwalls![index]!.url!,
        color: offerWallModel.deactivatedOfferwalls![index]!.skin!,
        hot: offerWallModel.deactivatedOfferwalls![index]!.rate!,
        id: offerWallModel.deactivatedOfferwalls![index]!.id!,
        image: offerWallModel.deactivatedOfferwalls![index]!.image!,
        title: offerWallModel.deactivatedOfferwalls![index]!.name!,
      ),
    );
  }
}
