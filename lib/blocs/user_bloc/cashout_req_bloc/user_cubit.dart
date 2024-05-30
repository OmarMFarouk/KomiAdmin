import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komiadmin/blocs/user_bloc/cashout_req_bloc/user_states.dart';

import '../../../models/user_data_model.dart';
import '../../../models/users_model.dart';
import '../../../services/APIs/users/users_api.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);
  UsersModel? usersModel;

  UserDataModel? userDataModel;

  fetchUsers() {
    UserApi().fetchUsers().then((value) {
      if (value['success'] == true) {
        usersModel = UsersModel.fromJson(value);
        emit(UserSuccess(value['message']));
      } else if (value['success'] == false) {
        emit(UserError(value['message']));
      } else {
        emit(UserError('check internet connection and try again'));
      }
    });
  }

  fetchUserInfo(username) {
    UserApi().fetchUserInfo(username).then((value) {
      if (value['success'] == true) {
        userDataModel = UserDataModel.fromJson(value);
        emit(UserSuccess(value['message']));
      } else if (value['success'] == false) {
        emit(UserError(value['message']));
      } else {
        emit(UserError('check internet connection and try again'));
      }
    });
  }

  deleteUser(username, reason) {
    UserApi().deleteUser(username, reason).then((value) {
      if (value['success'] == true) {
        emit(UserSuccess(value['message']));
        fetchUsers();
      } else if (value['success'] == false) {
        emit(UserError(value['message']));
      } else {
        emit(UserError('check internet connection and try again'));
      }
    });
  }

  banUser(username, reason) {
    UserApi().banUser(username, reason).then((value) {
      if (value['success'] == true) {
        emit(UserSuccess(value['message']));
      } else if (value['success'] == false) {
        emit(UserError(value['message']));
      } else {
        emit(UserError('check internet connection and try again'));
      }
    });
  }

  editBalance(username, points) {
    UserApi().editBalance(username, points).then((value) {
      if (value['success'] == true) {
        emit(UserSuccess(value['message']));
        fetchUserInfo(username);
      } else if (value['success'] == false) {
        emit(UserError(value['message']));
      } else {
        emit(UserError('check internet connection and try again'));
      }
    });
  }
}
