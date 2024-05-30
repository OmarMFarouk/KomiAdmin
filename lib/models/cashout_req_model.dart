class CompletedTransaction {
  String? id;
  String? username;
  String? method;
  String? amount;
  String? userinfo;
  String? datecreated;
  String? status;
  String? methodImage;
  String? dateCompleted;

  CompletedTransaction(
      {this.id,
      this.username,
      this.method,
      this.amount,
      this.userinfo,
      this.datecreated,
      this.methodImage,
      this.dateCompleted,
      this.status});

  CompletedTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    method = json['method'];
    amount = json['amount'];
    userinfo = json['user_info'];
    datecreated = json['date_created'];
    status = json['status'];
    methodImage = json['method_image'];
    dateCompleted = json['date_completed'];
  }
}

class PendingTransaction {
  String? id;
  String? username;
  String? method;
  String? amount;
  String? userinfo;
  String? datecreated;
  String? status;
  String? methodImage;
  String? dateCompleted;
  PendingTransaction(
      {this.id,
      this.username,
      this.method,
      this.amount,
      this.userinfo,
      this.methodImage,
      this.dateCompleted,
      this.datecreated,
      this.status});

  PendingTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    method = json['method'];
    amount = json['amount'];
    userinfo = json['user_info'];
    datecreated = json['date_created'];
    status = json['status'];
    methodImage = json['method_image'];
    dateCompleted = json['date_completed'];
  }
}

class RejectedTransaction {
  String? id;
  String? username;
  String? method;
  String? amount;
  String? userinfo;
  String? datecreated;
  String? status;
  String? methodImage;
  String? dateCompleted;
  RejectedTransaction(
      {this.id,
      this.username,
      this.dateCompleted,
      this.method,
      this.amount,
      this.userinfo,
      this.datecreated,
      this.methodImage,
      this.status});

  RejectedTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    method = json['method'];
    amount = json['amount'];
    userinfo = json['user_info'];
    datecreated = json['date_created'];
    status = json['status'];
    methodImage = json['method_image'];
    dateCompleted = json['date_completed'];
  }
}

class CashoutRequestModel {
  bool? success;
  String? message;
  List<PendingTransaction?>? pendingTransaction;
  List<CompletedTransaction?>? completedTransaction;
  List<RejectedTransaction?>? rejectedTransaction;

  CashoutRequestModel(
      {this.success,
      this.message,
      this.pendingTransaction,
      this.completedTransaction,
      this.rejectedTransaction});

  CashoutRequestModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['Pending_Transaction'] != null) {
      pendingTransaction = <PendingTransaction>[];
      json['Pending_Transaction'].forEach((v) {
        pendingTransaction!.add(PendingTransaction.fromJson(v));
      });
    }
    if (json['Completed_Transaction'] != null) {
      completedTransaction = <CompletedTransaction>[];
      json['Completed_Transaction'].forEach((v) {
        completedTransaction!.add(CompletedTransaction.fromJson(v));
      });
    }
    if (json['Rejected_Transaction'] != null) {
      rejectedTransaction = <RejectedTransaction>[];
      json['Rejected_Transaction'].forEach((v) {
        rejectedTransaction!.add(RejectedTransaction.fromJson(v));
      });
    }
  }
}
