import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:komiadmin/blocs/cashout_bloc/cashout_states.dart';
import 'package:komiadmin/models/cashout_methods_model.dart';
import 'package:komiadmin/models/cashout_req_model.dart';
import 'package:komiadmin/services/APIs/cashout/cashout_api.dart';
import 'package:komiadmin/src/app_navigator.dart';

import '../../components/general/toast.dart';

class CashoutCubit extends Cubit<CashoutStates> {
  CashoutCubit() : super(CashoutInitial());
  static CashoutCubit get(context) => BlocProvider.of(context);
  TextEditingController methodCont = TextEditingController();
  TextEditingController tierValueCont = TextEditingController();
  TextEditingController tierPointsCont = TextEditingController();
  String path = '';
  CashoutRequestModel? cashoutRequestModel;
  CashoutMethodsModel? cashoutMethodsModel;

  fetchTransactions() {
    CashoutApi().fetchTransactions().then((value) {
      if (value['success'] == true) {
        cashoutRequestModel = CashoutRequestModel.fromJson(value);
        emit(CashoutSuccess(value['message']));
      } else if (value['success'] == false) {
        emit(CashoutError(value['message']));
      } else {
        emit(CashoutError('check internet connection and try again'));
      }
    });
  }

  fetchMethods() {
    CashoutApi().fetchMethods().then((value) {
      if (value['success'] == true) {
        cashoutMethodsModel = CashoutMethodsModel.fromJson(value);
        emit(CashoutSuccess(value['message']));
      } else if (value['success'] == false) {
        emit(CashoutError(value['message']));
      } else {
        emit(CashoutError('check internet connection and try again'));
      }
    });
  }

  markCompleted({username, id, context}) {
    CashoutApi().markCompleted(username, id).then((value) {
      if (value['success'] == true) {
        MyToast.customToast(value['message'], context);

        CashoutCubit.get(context).fetchTransactions();
        AppNavigator.pop(context);
      } else if (value['success'] == false) {
        emit(CashoutError(value['message']));
      } else {
        emit(CashoutError('check internet connection and try again'));
      }
    });
  }

  markRejected({username, id, context}) {
    CashoutApi().markRejected(username, id).then((value) {
      if (value['success'] == true) {
        MyToast.customToast(value['message'], context);

        CashoutCubit.get(context).fetchTransactions();
        AppNavigator.pop(context);
      } else if (value['success'] == false) {
        emit(CashoutError(value['message']));
      } else {
        emit(CashoutError('check internet connection and try again'));
      }
    });
  }

  deactivateMethod({id, context}) {
    CashoutApi().deactivateMethod(id).then((value) {
      if (value['success'] == true) {
        MyToast.customToast(value['message'], context);

        CashoutCubit.get(context).fetchMethods();
        AppNavigator.pop(context);
      } else if (value['success'] == false) {
        emit(CashoutError(value['message']));
      } else {
        emit(CashoutError('check internet connection and try again'));
      }
    });
  }

  activateMethod({id, context}) {
    CashoutApi().activateMethod(id).then((value) {
      if (value['success'] == true) {
        MyToast.customToast(value['message'], context);

        CashoutCubit.get(context).fetchMethods();
        AppNavigator.pop(context);
      } else if (value['success'] == false) {
        emit(CashoutError(value['message']));
      } else {
        emit(CashoutError('check internet connection and try again'));
      }
    });
  }

  deleteMethod({id, context}) {
    CashoutApi().deleteMethod(id).then((value) {
      if (value['success'] == true) {
        MyToast.customToast(value['message'], context);

        CashoutCubit.get(context).fetchMethods();
        AppNavigator.pop(context);
      } else if (value['success'] == false) {
        emit(CashoutError(value['message']));
      } else {
        emit(CashoutError('check internet connection and try again'));
      }
    });
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) {
    } else {
      path = pickedFile.path;
    }
  }

  addMethod(
    context,
  ) {
    if (path.isNotEmpty &&
        methodCont.text.isNotEmpty &&
        tierValueCont.text.isNotEmpty &&
        tierPointsCont.text.isNotEmpty) {
      CashoutApi()
          .addMethod(
              methodCont.text, tierValueCont.text, tierPointsCont.text, path)
          .then((value) {
        if (value['success'] == true) {
          MyToast.customToast(value['message'], context);
          CashoutCubit.get(context).fetchMethods();
          AppNavigator.pop(context);
          path = '';
          methodCont.clear();
          tierPointsCont.clear();
          tierValueCont.clear();
        } else if (value['success'] == false) {
          emit(CashoutError(value['message']));
        } else {
          emit(CashoutError('check internet connection and try again'));
        }
      });
    }
  }

  editMethod(context, String id, method, tierPoints, tierValue) {
    CashoutApi()
        .editMethod(id, method, tierPoints, tierValue, path)
        .then((value) {
      if (value['success'] == true) {
        MyToast.customToast(value['message'], context);

        CashoutCubit.get(context).fetchMethods();

        AppNavigator.pop(context);
        path = '';
      } else if (value['success'] == false) {
        emit(CashoutError(value['message']));
      } else {
        emit(CashoutError('check internet connection and try again'));
      }
    });
  }
}
