abstract class AdminStates {}

class AdminInitial extends AdminStates {}

class AdminSuccess extends AdminStates {
  String msg = '';
  AdminSuccess(this.msg);
}

class AdminError extends AdminStates {
  String msg = '';
  AdminError(this.msg);
}
