
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:casual_app/features/settings/repos/settings_repo.dart';
import 'package:casual_app/models/casual/casual_password_model.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {

  SettingsRepo settingsRepo = SettingsRepo();
  Map<String, dynamic> _errors = <String, dynamic>{};
  final CasualPasswordModel _casualPasswordModel = CasualPasswordModel();

  SettingsBloc() : super(SettingsInitials()){
    on<UpdatePasswordEvent>(updatePasswordEvent);
  }

  FutureOr<void> updatePasswordEvent(UpdatePasswordEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsLoadingState());

    var result = await settingsRepo.updatePassword(event.casualPasswordModel);
    _errors = _casualPasswordModel.getManagerPasswordWithNull();
    if(result['status']){
      // print(result);
      emit(ChangePasswordSuccessState(msg: result['message']));
    }else{
      // print(result);
      if(result.containsKey("error")){
        result['error'].forEach((errors){
          _errors.forEach((key, value) {
            if(errors['param'] == key && _errors[key] == null){
              _errors[key] = errors['msg'];
            }
          });
        });
        emit(ChangePasswordState(casualPasswordModel: event.casualPasswordModel, errors: _errors));
      }else if(result['token'] == "Expired"){
        emit(SettingsApiTokenExpired(msg: result['message']));
      } else{
        emit(SettingsDataNotifyState(msg: result['message']));
      }
    }
  }
}