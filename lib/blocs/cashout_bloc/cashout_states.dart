abstract class CashoutStates {}

class CashoutInitial extends CashoutStates {}

class CashoutSuccess extends CashoutStates {
  String msg = '';
  CashoutSuccess(this.msg);
}

class CashoutError extends CashoutStates {
  String msg = '';
  CashoutError(this.msg);
}
