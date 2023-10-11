

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:casual_app/models/casual/casual_model.dart';
import 'package:flutter/material.dart';

import '../repos/account_repo.dart';

part 'account_state.dart';
part 'account_event.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState>{
  AccountRepo accountRepo = AccountRepo();
  Map<String, dynamic> _errors = <String, dynamic>{};
  final CasualModel _casualModel = CasualModel();

  AccountBloc(): super(LoadingState()){
    on<GetProfileEvent>(getProfileEvent);
    on<UpdateProfileEvent>(updateProfileEvent);
  }

  FutureOr<void> getProfileEvent(GetProfileEvent event, Emitter<AccountState> emit) async {
    // print("Clicked");
    emit(LoadingState());
    var result = await accountRepo.getProfile();
    // print(result['status']);
    if(result['status']){
      emit(GetProfileState(casualModel: CasualModel.fromJson(result['casual'])));
    }else{
      print(result);
      if(result["token"] == "Expired"){
        emit(UnAuthorizedState(msg: result['message']));
      }
    }
  }

  FutureOr<void> updateProfileEvent(UpdateProfileEvent event, Emitter<AccountState> emit) async {
    emit(LoadingState());
    var result = await accountRepo.updateProfile(event.casualModel, event.image);
    _errors = _casualModel.getCasualDataWithNull();
    // print(result);
    if(result['status']){
      emit(ProfileUpdateSuccessState(msg: result['message']));
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
        emit(ProfileUpdateState(casualModel: event.casualModel, errors: _errors));
      }
      if(result["token"] == "Expired"){
        emit(UnAuthorizedState(msg: result['message']));
      }
    }
  }



}