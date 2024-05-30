import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komiadmin/blocs/auth_bloc/auth_states.dart';
import 'package:komiadmin/models/auth_model.dart';
import 'package:komiadmin/services/APIs/auth/auth_api.dart';
import 'package:komiadmin/services/functional/shared_prefs.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  TextEditingController adminId =
      TextEditingController(text: SharedPref.localStorage?.getString('id'));
  TextEditingController password = TextEditingController();
  bool rememberID = false;

  AuthModel? _authModel;

  loginAdmin() {
    if (adminId.text.isNotEmpty && password.text.isNotEmpty) {
      _authModel = AuthModel(adminId: adminId.text, password: password.text);
      AuthApi().loginAdmin(_authModel!).then((value) {
        if (value['success'] == true) {
          emit(AuthSuccess(value['message']));
          SharedPref.localStorage!.setBool('active', true);
        } else if (value['success'] == false) {
          emit(AuthError(value['message']));
        } else {
          emit(AuthError('check internet connection and try again'));
        }
      });
    } else {
      emit(AuthError('Empty Fields'));
    }
  }

  clearAndSave() async {
    if (rememberID == true) {
      await SharedPref.localStorage?.setString('id', adminId.text);
    }

    adminId.clear();
    password.clear();
  }
}
