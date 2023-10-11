
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/casual/casual_model.dart';
import '../repos/auth_repo.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{

  final CasualModel _casualModel = CasualModel();
  AuthRepo authRepo = AuthRepo();
  Map<String, dynamic> _errors = <String, dynamic>{};

  AuthBloc() : super(InitialState()){
    on<LoginEvent>(loginEvent);
  }

  FutureOr<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    var result = await authRepo.login(event.casualModel);
    _errors = _casualModel.getCasualDataWithNull();
    // print(result);
    if(result['status']){
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("token", result['token']);
      emit(LoginState(casualModel: event.casualModel, errors: _errors));
      emit(HomeNavigateActionState(msg: result['message']));
    }else{
      if(result.containsKey("error")){
        result['error'].forEach((errors) {
          _errors.forEach((key, value) {
            if(errors['param'] == key && _errors[key] == null){
              _errors[key] = errors['msg'];
            }
          });
        });
        // print(_errors);
        // emit(LoginErrorState(errors: _errors));
        emit(LoginState(casualModel: event.casualModel, errors: _errors));
      }
      if(result.containsKey("message")){
        emit(UnAuthorizedState(result['message']));
      }
    }

  }

}