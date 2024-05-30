class UserDataModel {
  bool? success;
  String? message;
  List<UserInfo>? userInfo;
  List<UserCashout>? userCashout;
  List<UserLeads>? userLeads;

  UserDataModel(
      {this.success,
      this.message,
      this.userInfo,
      this.userCashout,
      this.userLeads});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['user_info'] != null) {
      userInfo = <UserInfo>[];
      json['user_info'].forEach((v) {
        userInfo!.add(UserInfo.fromJson(v));
      });
    }
    if (json['user_cashout'] != null) {
      userCashout = <UserCashout>[];
      json['user_cashout'].forEach((v) {
        userCashout!.add(UserCashout.fromJson(v));
      });
    }
    if (json['user_leads'] != null) {
      userLeads = <UserLeads>[];
      json['user_leads'].forEach((v) {
        userLeads!.add(UserLeads.fromJson(v));
      });
    }
  }
}

class UserInfo {
  String? id;

  String? password;
  String? lastLogin;
  String? dateCreated;
  String? balance;
  String? status;
  String? lastIp;
  String? firstIp;
  String? referCode;
  String? username;
  String? email;
  String? referer;
  String? deviceInfo;
  String? fcmToken;
  String? pointsEarned;

  UserInfo(
      {this.id,
      this.password,
      this.lastLogin,
      this.dateCreated,
      this.balance,
      this.status,
      this.lastIp,
      this.firstIp,
      this.referCode,
      this.username,
      this.email,
      this.referer,
      this.deviceInfo,
      this.fcmToken,
      this.pointsEarned});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    password = json['password'];
    lastLogin = json['last_login'];
    dateCreated = json['date_created'];
    balance = json['balance'];
    status = json['status'];
    lastIp = json['last_ip'];
    firstIp = json['first_ip'];
    referCode = json['refer_code'];
    username = json['username'];
    email = json['email'];
    referer = json['referer'];
    deviceInfo = json['device_info'];
    fcmToken = json['fcm_token'];
    pointsEarned = json['points_earned'];
  }
}

class UserCashout {
  String? id;
  String? username;
  String? method;
  String? pointsUsed;
  String? userInfo;
  String? dateCreated;
  String? status;
  String? methodImage;
  String? amount;
  String? dateCompleted;

  UserCashout(
      {this.id,
      this.username,
      this.method,
      this.pointsUsed,
      this.userInfo,
      this.dateCreated,
      this.status,
      this.amount,
      this.methodImage,
      this.dateCompleted});

  UserCashout.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    method = json['method'];
    pointsUsed = json['points_used'];
    userInfo = json['user_info'];
    dateCreated = json['date_created'];
    status = json['status'];
    amount = json['amount'];
    methodImage = json['method_image'];
    dateCompleted = json['date_completed'];
  }
}

class UserLeads {
  String? id;
  String? offerName;
  String? points;
  String? date;
  String? username;
  String? network;

  UserLeads(
      {this.id,
      this.offerName,
      this.points,
      this.date,
      this.username,
      this.network});

  UserLeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offerName = json['offer_name'];
    points = json['points'];
    date = json['date'];
    username = json['username'];
    network = json['network'];
  }
}
