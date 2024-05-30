abstract class LeadsStates {}

class LeadsInitial extends LeadsStates {}

class LeadsSuccess extends LeadsStates {
  String msg = '';
  LeadsSuccess(this.msg);
}

class LeadsError extends LeadsStates {
  String msg = '';
  LeadsError(this.msg);
}
