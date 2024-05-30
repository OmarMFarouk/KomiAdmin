class AnalyticsModel {
  bool? success;
  List<DailyAnalytics>? dailyAnalytics;
  List<WeeklyAnalytics>? weeklyAnalytics;
  List<MonthlyAnalytics>? monthlyAnalytics;
  List<AllTimeAnalytics>? allTimeAnalytics;
  List<Pending>? pending;
  AnalyticsModel(this.success,
      {this.dailyAnalytics,
      this.weeklyAnalytics,
      this.monthlyAnalytics,
      this.allTimeAnalytics,
      this.pending});

  AnalyticsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['daily_analytics'] != null) {
      dailyAnalytics = <DailyAnalytics>[];
      json['daily_analytics'].forEach((v) {
        dailyAnalytics!.add(DailyAnalytics.fromJson(v));
      });
    }
    if (json['weekly_analytics'] != null) {
      weeklyAnalytics = <WeeklyAnalytics>[];
      json['weekly_analytics'].forEach((v) {
        weeklyAnalytics!.add(WeeklyAnalytics.fromJson(v));
      });
    }
    if (json['monthly_analytics'] != null) {
      monthlyAnalytics = <MonthlyAnalytics>[];
      json['monthly_analytics'].forEach((v) {
        monthlyAnalytics!.add(MonthlyAnalytics.fromJson(v));
      });
    }
    if (json['all_time_analytics'] != null) {
      allTimeAnalytics = <AllTimeAnalytics>[];
      json['all_time_analytics'].forEach((v) {
        allTimeAnalytics!.add(AllTimeAnalytics.fromJson(v));
      });
    }
    if (json['pending'] != null) {
      pending = <Pending>[];
      json['pending'].forEach((v) {
        pending!.add(Pending.fromJson(v));
      });
    }
  }
}

class DailyAnalytics {
  String? sessions;
  String? revenue;

  String? newUsers;
  DailyAnalytics({this.sessions, this.revenue, this.newUsers});

  DailyAnalytics.fromJson(Map<String, dynamic> json) {
    sessions = json['sessions'];
    revenue = json['revenue'];
    newUsers = json['new_users'];
  }
}

class WeeklyAnalytics {
  String? sessions;
  String? revenue;

  String? newUsers;
  WeeklyAnalytics({this.sessions, this.revenue, this.newUsers});

  WeeklyAnalytics.fromJson(Map<String, dynamic> json) {
    sessions = json['sessions'];
    revenue = json['revenue'];
    newUsers = json['new_users'];
  }
}

class MonthlyAnalytics {
  String? sessions;
  String? revenue;
  String? newUsers;
  MonthlyAnalytics({this.sessions, this.revenue, this.newUsers});

  MonthlyAnalytics.fromJson(Map<String, dynamic> json) {
    sessions = json['sessions'];
    revenue = json['revenue'];
    newUsers = json['new_users'];
  }
}

class AllTimeAnalytics {
  String? sessions;
  String? revenue;
  String? newUsers;

  AllTimeAnalytics({this.sessions, this.revenue, this.newUsers});

  AllTimeAnalytics.fromJson(Map<String, dynamic> json) {
    sessions = json['sessions'];
    revenue = json['revenue'];
    newUsers = json['new_users'];
  }
}

class Pending {
  int? count;

  Pending({this.count});

  Pending.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}
