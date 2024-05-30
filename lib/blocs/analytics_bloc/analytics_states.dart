abstract class AnalyticsStates {}

class AnalyticsInitial extends AnalyticsStates {}

class AnalyticsSuccess extends AnalyticsStates {
  String msg = '';
  AnalyticsSuccess(this.msg);
}

class AnalyticsError extends AnalyticsStates {
  String msg = '';
  AnalyticsError(this.msg);
}
