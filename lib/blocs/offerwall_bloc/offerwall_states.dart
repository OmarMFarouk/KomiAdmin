abstract class OfferWallStates {}

class OfferWallInitial extends OfferWallStates {}

class OfferWallSuccess extends OfferWallStates {
  String msg = '';
  OfferWallSuccess(this.msg);
}

class OfferWallError extends OfferWallStates {
  String msg = '';
  OfferWallError(this.msg);
}
