/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class ActivatedOfferwall {
  String? id;
  String? name;
  String? image;
  String? url;
  String? rate;
  String? status;
  String? skin;

  ActivatedOfferwall(
      {this.id,
      this.name,
      this.image,
      this.url,
      this.rate,
      this.status,
      this.skin});

  ActivatedOfferwall.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    url = json['url'];
    rate = json['rate'];
    status = json['status'];
    skin = json['skin'];
  }
}

class DeactivatedOfferwall {
  String? id;
  String? name;
  String? image;
  String? url;
  String? rate;
  String? status;
  String? skin;

  DeactivatedOfferwall(
      {this.id,
      this.name,
      this.image,
      this.url,
      this.rate,
      this.status,
      this.skin});

  DeactivatedOfferwall.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    url = json['url'];
    rate = json['rate'];
    status = json['status'];
    skin = json['skin'];
  }
}

class OfferWallModel {
  bool? success;
  String? message;
  List<ActivatedOfferwall?>? activatedOfferwalls;
  List<DeactivatedOfferwall?>? deactivatedOfferwalls;

  OfferWallModel(
      {this.success,
      this.message,
      this.activatedOfferwalls,
      this.deactivatedOfferwalls});

  OfferWallModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['Activated_Offerwalls'] != null) {
      activatedOfferwalls = <ActivatedOfferwall>[];
      json['Activated_Offerwalls'].forEach((v) {
        activatedOfferwalls!.add(ActivatedOfferwall.fromJson(v));
      });
    }
    if (json['Deactivated_Offerwalls'] != null) {
      deactivatedOfferwalls = <DeactivatedOfferwall>[];
      json['Deactivated_Offerwalls'].forEach((v) {
        deactivatedOfferwalls!.add(DeactivatedOfferwall.fromJson(v));
      });
    }
  }
}
