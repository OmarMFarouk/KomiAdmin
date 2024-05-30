/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class Configuration {
  String? allowfakeemail;
  String? allowvpn;
  String? allowsignup;
  String? allowsignin;
  String? allowmultipleaccounts;
  String? id;

  Configuration(
      {this.allowfakeemail,
      this.allowvpn,
      this.allowsignup,
      this.allowsignin,
      this.allowmultipleaccounts,
      this.id});

  Configuration.fromJson(Map<String, dynamic> json) {
    allowfakeemail = json['allow_fake_email'];
    allowvpn = json['allow_vpn'];
    allowsignup = json['allow_signup'];
    allowsignin = json['allow_signin'];
    allowmultipleaccounts = json['allow_multiple_accounts'];
    id = json['id'];
  }
}

class ConfigurationModel {
  bool? success;
  String? message;
  List<Configuration?>? configurations;

  ConfigurationModel({this.success, this.message, this.configurations});

  ConfigurationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['Configurations'] != null) {
      configurations = <Configuration>[];
      json['Configurations'].forEach((v) {
        configurations!.add(Configuration.fromJson(v));
      });
    }
  }
}
