class Lead {
  String? id;
  String? offername;
  String? points;
  String? date;
  String? username;
  String? network;

  Lead(
      {this.id,
      this.offername,
      this.points,
      this.date,
      this.username,
      this.network});

  Lead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offername = json['offer_name'];
    points = json['points'];
    date = json['date'];
    username = json['username'];
    network = json['network'];
  }
}

class LeadsModel {
  bool? success;
  String? message;
  List<Lead?>? leads;
  List<String?>? formattedDate;

  LeadsModel({this.success, this.message, this.leads, this.formattedDate});

  LeadsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['Leads'] != null) {
      leads = <Lead>[];
      json['Leads'].forEach((v) {
        leads!.add(Lead.fromJson(v));
      });
    }
    if (json['Formatted_Date'] != null) {
      formattedDate = <String>[];
      json['Formatted_Date'].forEach((v) {
        formattedDate!.add(v);
      });
    }
  }
}
