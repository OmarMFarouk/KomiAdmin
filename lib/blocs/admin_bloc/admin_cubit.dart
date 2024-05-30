import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:komiadmin/blocs/admin_bloc/admin_states.dart';
import 'package:komiadmin/models/admin_options_model.dart';
import 'package:komiadmin/services/APIs/admin/admin_api.dart';
import 'package:komiadmin/services/functional/shared_prefs.dart';
import 'package:komiadmin/src/app_navigator.dart';

import '../../models/admin_data_model.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitial());
  static AdminCubit get(context) => BlocProvider.of(context);
  TextEditingController pushTitle = TextEditingController();
  TextEditingController pushBody = TextEditingController();

  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController percentage = TextEditingController();

  AdminDataModel? adminDataModel;
  ConfigurationModel? configurationModel;
  String path = '';
  fetchAdminData() {
    AdminApi().fetchAdminData().then((value) {
      if (value['success'] == true) {
        adminDataModel = AdminDataModel.fromJson(value);
      } else if (value['success'] == false) {
        emit(AdminError(value['message']));
      } else {
        emit(AdminError('check internet connection and try again'));
      }
    }).whenComplete(() {
      SharedPref.localStorage
          ?.setString('image', adminDataModel!.admindata![0]!.image!);
      SharedPref.localStorage
          ?.setString('name', adminDataModel!.admindata![0]!.adminname!);
      SharedPref.localStorage?.setDouble('percentage',
          double.parse(adminDataModel!.admindata![0]!.percentage!));
    });
  }

  saveAdminData() {
    if (path != '' ||
        name.text.isNotEmpty ||
        password.text.isNotEmpty ||
        percentage.text.isNotEmpty) {
      AdminApi()
          .saveAdminData(name.text, password.text, percentage.text, path)
          .then((value) {
        if (value['success'] == true) {
          fetchAdminData();
          password.clear();
          name.clear();
          path = '';
          percentage.clear();
          emit(AdminSuccess(value['message']));
        } else if (value['success'] == false) {
          emit(AdminError(value['message']));
        } else {
          emit(AdminError('check internet connection and try again'));
        }
      });
    }
  }

  announceUser(token, title, body, context) {
    if (body.isNotEmpty && title.isNotEmpty) {
      AdminApi().announceUser(token, title, body).then((value) {
        if (value['success'] == true) {
          emit(AdminSuccess(value['message']));
          AppNavigator.pop(context);
          pushBody.clear();
          pushTitle.clear();
        } else if (value['success'] == false) {
          emit(AdminError(value['message']));
        } else {
          emit(AdminError('check internet connection and try again'));
        }
      });
    }
  }

  announceUsers(context) {
    if (pushBody.text.isNotEmpty && pushTitle.text.isNotEmpty) {
      AdminApi().announceUsers(pushTitle.text, pushBody.text).then((value) {
        if (value['success'] == true) {
          emit(AdminSuccess(value['message']));
          AppNavigator.pop(context);
          pushBody.clear();
          pushTitle.clear();
        } else if (value['success'] == false) {
          emit(AdminError(value['message']));
        } else {
          emit(AdminError('check internet connection and try again'));
        }
      });
    }
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
    } else {
      path = pickedFile.path;
    }
  }

  fetchConfigs() {
    AdminApi().fetchConfigs().then((value) {
      if (value['success'] == true) {
        configurationModel = ConfigurationModel.fromJson(value);
      } else if (value['success'] == false) {
        emit(AdminError(value['message']));
      } else {
        emit(AdminError('check internet connection and try again'));
      }
    }).whenComplete(() {
      SharedPref.localStorage!.setBool('multiple-accounts',
          SharedPref.localStorage!.getBool('multiple-accounts') ?? true);
      SharedPref.localStorage!.setBool(
          'fake-email', SharedPref.localStorage!.getBool('fake-email') ?? true);
      SharedPref.localStorage!.setBool(
          'allow-vpn', SharedPref.localStorage!.getBool('allow-vpn') ?? true);
    });
  }

  editConfigs({required String fakeEmail, vpn, multipleAccounts}) {
    if (fakeEmail.isNotEmpty || vpn.isNotEmpty || multipleAccounts.isNotEmpty) {
      AdminApi()
          .editConfigs('1', fakeEmail, vpn, multipleAccounts)
          .then((value) {
        if (value['success'] == true) {
          configurationModel = ConfigurationModel.fromJson(value);
        } else if (value['success'] == false) {
          emit(AdminError(value['message']));
        } else {
          emit(AdminError('check internet connection and try again'));
        }
      }).whenComplete(() {
        fetchConfigs();
        emit(AdminSuccess('Option Saved!'));
      });
    }
  }
}
