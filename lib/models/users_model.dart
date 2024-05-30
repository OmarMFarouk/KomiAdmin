class UsersModel {
  bool? success;
  String? message;
  List<User?>? users;

  UsersModel({this.success, this.message, this.users});

  UsersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['users'] != null) {
      users = <User>[];
      json['users'].forEach((v) {
        users!.add(User.fromJson(v));
      });
    }
  }
}

class User {
  String? username;
  String? id;
  String? ip;

  User({this.username, this.id, this.ip});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    id = json['id'];
    ip = json['last_ip'];
  }
}
