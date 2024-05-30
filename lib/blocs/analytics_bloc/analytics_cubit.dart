import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komiadmin/blocs/analytics_bloc/analytics_states.dart';
import 'package:komiadmin/models/analytics_model.dart';
import 'package:komiadmin/models/countries_model.dart';
import 'package:komiadmin/services/APIs/analytics/analytics_api.dart';
import 'package:komiadmin/services/functional/shared_prefs.dart';

class AnalyticsCubit extends Cubit<AnalyticsStates> {
  AnalyticsCubit() : super(AnalyticsInitial());
  static AnalyticsCubit get(context) => BlocProvider.of(context);
  TextEditingController adminId =
      TextEditingController(text: SharedPref.localStorage?.getString('id'));
  TextEditingController password = TextEditingController();
  bool rememberID = false;

  AnalyticsModel? analyticsModel;
  CountriesModel? countriesModel;

  fetchAnalytics() {
    AnalyticsApi().fetchAnalytics().then((value) {
      if (value['success'] == true) {
        analyticsModel = AnalyticsModel.fromJson(value);
        emit(AnalyticsSuccess(value['message']));
      } else if (value['success'] == false) {
        emit(AnalyticsError(value['message']));
      } else {
        emit(AnalyticsError('check internet connection and try again'));
      }
    });
  }

  fetchCountries() {
    AnalyticsApi().fetchCountries().then((value) {
      if (value['success'] == true) {
        countriesModel = CountriesModel.fromJson(value);
        emit(AnalyticsSuccess(value['message']));
      } else if (value['success'] == false) {
        emit(AnalyticsError(value['message']));
      } else {
        emit(AnalyticsError('check internet connection and try again'));
      }
    });
  }
}
