class CountryModel {
  String? countrycode;
  String? count;

  CountryModel({this.countrycode, this.count});

  CountryModel.fromJson(Map<String, dynamic> json) {
    countrycode = json['country_code'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['country_code'] = countrycode;
    data['count'] = count;
    return data;
  }
}

class CountriesModel {
  bool? success;
  String? message;
  List<CountryModel?>? countries;

  CountriesModel({this.success, this.message, this.countries});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['Countries'] != null) {
      countries = <CountryModel>[];
      json['Countries'].forEach((v) {
        countries!.add(CountryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    data['Countries'] = countries?.map((v) => v?.toJson()).toList();
    return data;
  }
}
