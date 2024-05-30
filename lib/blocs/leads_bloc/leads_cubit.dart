import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komiadmin/blocs/Leads_bloc/Leads_states.dart';
import 'package:komiadmin/models/Leads_model.dart';

import '../../services/APIs/leads/leads_api.dart';

class LeadsCubit extends Cubit<LeadsStates> {
  LeadsCubit() : super(LeadsInitial());
  static LeadsCubit get(context) => BlocProvider.of(context);
  LeadsModel? leadsModel;

  fetchLeads() {
    LeadsApi().fetchLeads().then((value) {
      if (value['success'] == true) {
        leadsModel = LeadsModel.fromJson(value);
        emit(LeadsSuccess(value['message']));
      } else if (value['success'] == false) {
        emit(LeadsError(value['message']));
      } else {
        emit(LeadsError('check internet connection and try again'));
      }
    });
  }
}
