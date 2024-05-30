/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class AdminData {
  String? id;
  String? adminname;
  String? lastlogin;
  String? adminid;
  String? fcmtoken;
  String? password;
  String? image;
  String? percentage;

  AdminData(
      {this.id,
      this.adminname,
      this.lastlogin,
      this.adminid,
      this.fcmtoken,
      this.password,
      this.percentage,
      required this.image});

  AdminData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminname = json['admin_name'];
    lastlogin = json['last_login'];
    adminid = json['admin_id'];
    fcmtoken = json['fcm_token'];
    password = json['password'];
    image = json['image'];
    percentage = json['percentage'];
  }
}

class AdminDataModel {
  bool? success;
  String? message;
  List<AdminData?>? admindata;

  AdminDataModel({this.success, this.message, this.admindata});

  AdminDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['admin_data'] != null) {
      admindata = <AdminData>[];
      json['admin_data'].forEach((v) {
        admindata!.add(AdminData.fromJson(v));
      });
    }
  }
}
