class ActivatedMethod {
  String? id;
  String? method;
  String? image;
  String? tiervalue;
  String? tierpoints;
  String? status;

  ActivatedMethod(
      {this.id,
      this.method,
      this.image,
      this.tiervalue,
      this.tierpoints,
      this.status});

  ActivatedMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    method = json['method'];
    image = json['image'];
    tiervalue = json['tier_value'];
    tierpoints = json['tier_points'];
    status = json['status'];
  }
}

class DectivatedMethod {
  String? id;
  String? method;
  String? image;
  String? tiervalue;
  String? tierpoints;
  String? status;

  DectivatedMethod(
      {this.id,
      this.method,
      this.image,
      this.tiervalue,
      this.tierpoints,
      this.status});

  DectivatedMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    method = json['method'];
    image = json['image'];
    tiervalue = json['tier_value'];
    tierpoints = json['tier_points'];
    status = json['status'];
  }
}

class CashoutMethodsModel {
  bool? success;
  String? message;
  List<ActivatedMethod?>? activatedMethods;
  List<DectivatedMethod?>? dectivatedMethods;

  CashoutMethodsModel(
      {this.success,
      this.message,
      this.activatedMethods,
      this.dectivatedMethods});

  CashoutMethodsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['Activated_Methods'] != null) {
      activatedMethods = <ActivatedMethod>[];
      json['Activated_Methods'].forEach((v) {
        activatedMethods!.add(ActivatedMethod.fromJson(v));
      });
    }
    if (json['Dectivated_Methods'] != null) {
      dectivatedMethods = <DectivatedMethod>[];
      json['Dectivated_Methods'].forEach((v) {
        dectivatedMethods!.add(DectivatedMethod.fromJson(v));
      });
    }
  }
}
