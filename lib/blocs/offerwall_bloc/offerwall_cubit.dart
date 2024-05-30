import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:komiadmin/blocs/offerwall_bloc/offerwall_states.dart';
import 'package:komiadmin/models/offerwall_model.dart';
import 'package:komiadmin/services/APIs/offerwalls/offerwalls_api.dart';

import '../../components/general/toast.dart';
import '../../src/app_navigator.dart';

class OfferWallCubit extends Cubit<OfferWallStates> {
  OfferWallCubit() : super(OfferWallInitial());
  static OfferWallCubit get(context) => BlocProvider.of(context);
  TextEditingController offerWallurl = TextEditingController();
  TextEditingController offerWallName = TextEditingController();
  TextEditingController offerWallSkin = TextEditingController();
  TextEditingController offerWallRate = TextEditingController();
  String path = '';
  OfferWallModel? offerWallModel;

  fetchOfferWalls() {
    OfferWallsApi().fetchOfferWalls().then((value) {
      if (value['success'] == true) {
        offerWallModel = OfferWallModel.fromJson(value);
        emit(OfferWallSuccess(value['message']));
      } else if (value['success'] == false) {
        emit(OfferWallError(value['message']));
      } else {
        emit(OfferWallError('check internet connection and try again'));
      }
    });
  }

  activateOfferwall({id, context}) {
    OfferWallsApi().activateOfferwall(id).then((value) {
      if (value['success'] == true) {
        MyToast.customToast(value['message'], context);

        OfferWallCubit.get(context).fetchOfferWalls();
        AppNavigator.pop(context);
      } else if (value['success'] == false) {
        emit(OfferWallError(value['message']));
      } else {
        emit(OfferWallError('check internet connection and try again'));
      }
    });
  }

  deactivateOfferwall({id, context}) {
    OfferWallsApi().deactivateOfferwall(id).then((value) {
      if (value['success'] == true) {
        MyToast.customToast(value['message'], context);

        OfferWallCubit.get(context).fetchOfferWalls();
        AppNavigator.pop(context);
      } else if (value['success'] == false) {
        emit(OfferWallError(value['message']));
      } else {
        emit(OfferWallError('check internet connection and try again'));
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

  addNetwork(context) {
    if (path != '' &&
        offerWallurl.text.isNotEmpty &&
        offerWallName.text.isNotEmpty &&
        offerWallSkin.text.isNotEmpty &&
        offerWallRate.text.isNotEmpty) {
      OfferWallsApi()
          .addNetwork(offerWallName.text, offerWallurl.text, offerWallRate.text,
              path, offerWallSkin.text)
          .then((value) {
        if (value['success'] == true) {
          MyToast.customToast(value['message'], context);
          fetchOfferWalls();
          AppNavigator.pop(context);
          path = '';
          offerWallurl.clear();
          offerWallName.clear();
        } else if (value['success'] == false) {
          emit(OfferWallError(value['message']));
        } else {
          emit(OfferWallError('check internet connection and try again'));
        }
      });
    }
  }

  deleteNetwork({id, context}) {
    OfferWallsApi().deleteNetwork(id).then((value) {
      if (value['success'] == true) {
        MyToast.customToast(value['message'], context);

        fetchOfferWalls();
        AppNavigator.pop(context);
      } else if (value['success'] == false) {
        emit(OfferWallError(value['message']));
      } else {
        emit(OfferWallError('check internet connection and try again'));
      }
    });
  }

  editNetwork(context, String id, title, url, rate) {
    OfferWallsApi().editNetwork(id, title, url, rate, path).then((value) {
      if (value['success'] == true) {
        MyToast.customToast(value['message'], context);

        fetchOfferWalls();

        AppNavigator.pop(context);
        path = '';
      } else if (value['success'] == false) {
        emit(OfferWallError(value['message']));
      } else {
        emit(OfferWallError('check internet connection and try again'));
      }
    });
  }
}
